import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/core/widgets/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/_queries/trip_route.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/_decode_polyline.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

import 'package:nysse_asemanaytto/main/stoptimes.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

final GlobalKey<_MapLinesEmbedWidgetState> _mapKey = GlobalKey();

class MapLinesEmbed extends Embed {
  const MapLinesEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapLinesEmbed> createEmbed(
          covariant MapLinesEmbedSettings settings) =>
      MapLinesEmbedWidget(settings: settings);

  @override
  EmbedSettings<MapLinesEmbed> createDefaultSettings() => MapLinesEmbedSettings(
        tileProvider: MapEmbedTileProvider.digitransitRetina,
        showStops: false,
        showRouteInfo: true,
      );
}

class MapLinesEmbedWidget extends StatelessWidget
    implements EmbedWidgetMixin<MapLinesEmbed> {
  final MapLinesEmbedSettings settings;

  const MapLinesEmbedWidget({required this.settings, super.key});

  @override
  Duration? getDuration() {
    return const Duration(seconds: 10);
  }

  @override
  void onDisable() {
    _mapKey.currentState?.unsubscribeMqtt();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.subscribeMqtt();
    _mapKey.currentState?.computeGeometry();
  }

  @override
  Widget build(BuildContext context) {
    final DigitransitStoptime? stoptime =
        Stoptimes.of(context)?.stoptimesWithoutPatterns?.firstOrNull;
    if (stoptime == null) {
      return ErrorWidget.withDetails(message: "No stoptimes");
    }

    return Query(
      options: QueryOptions(
        document: gql(DigitransitTripRouteQuery.query),
        variables: {
          "tripId": stoptime.tripGtfsId!.id,
        },
        pollInterval: RequestInfo.ratelimits.tripRouteRequest,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return ErrorWidget(result.exception!);
        }

        final Map<String, dynamic>? data = result.data;

        final DigitransitTripRouteQuery? parsed =
            data != null ? DigitransitTripRouteQuery.parse(data) : null;

        // TODO: Keep old stoptime after first vehicle has departed
        // Probably set it in the state first
        // and do not render the line or buses before the route has loaded
        // I tried it before and without ^^^^^^ it flickered grey buses and I didn't like it
        return _MapLinesEmbedWidget(
          settings,
          key: _mapKey,
          stoptime: stoptime,
          route: parsed,
        );
      },
    );
  }
}

class _MapLinesEmbedWidget extends StatefulWidget {
  final MapLinesEmbedSettings settings;
  final DigitransitStoptime stoptime;
  final DigitransitTripRouteQuery? route;

  const _MapLinesEmbedWidget(
    this.settings, {
    super.key,
    required this.stoptime,
    required this.route,
  });

  @override
  State<StatefulWidget> createState() => _MapLinesEmbedWidgetState();
}

class _MapLinesEmbedWidgetState extends State<_MapLinesEmbedWidget> {
  late final MapController _mapController;

  DigitransitMqttSubscription? _positioningSub;
  ErrorWidget? _positioningSubError;
  final Map<String, VehiclePosition> _vehiclePositions = {};

  List<LatLng>? _geometry;
  List<DigitransitPatternStop>? _stops;

  DigitransitMqttState? _mqtt;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void didChangeDependencies() {
    _mqtt = DigitransitMqtt.maybeOf(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _mapController.dispose();
    unsubscribeMqtt();

    super.dispose();
  }

  void subscribeMqtt() {
    if (_mqtt?.isConnected != true) {
      _positioningSubError = MqttOfflineErrorWidget();
      return;
    }

    final GtfsId stopId = Config.of(context).stopId;

    _positioningSubError = null;
    _positioningSub = _mqtt!.subscribe(
      DigitransitPositioningTopic(
        feedId: stopId.feedId,
        routeId: widget.stoptime.routeGtfsId!.rawId,
      ).buildTopicString(),
      MqttQos.atMostOnce,
    );

    _positioningSub!.onMessageReceived = _onVehiclePositionUpdate;
  }

  void _onVehiclePositionUpdate(DigitransitMqttMessage msg) {
    final FeedEntity ent = FeedEntity.fromBuffer(msg.bytes);
    setState(() {
      // BUG: After vehicle stops being updated
      // (doesn't fit to our topic <= too far for example)
      // The vehicle isn't removed from the map before the next disconnect.
      // This is fine for now, but I would like to make a timeout system in the future.
      _vehiclePositions[ent.id] = ent.vehicle;
    });
  }

  /// Safe to call multiple times.
  void unsubscribeMqtt() {
    if (_positioningSub == null) {
      return;
    }

    _mqtt?.unsubscribe(_positioningSub!);
    _vehiclePositions.clear();
  }

  /// Must be called before this widget's build will display the pattern route.
  void computeGeometry() {
    final String? patternGeometry = widget.route?.pattern.patternGeometry;
    if (patternGeometry == null) {
      _stops = null;
      _geometry = null;
      _mapController.move(kDefaultMapPosition, _mapController.camera.minZoom!);
      return;
    }

    _stops = widget.route!.pattern.stops;
    _geometry = decodePolyline(patternGeometry).toList();

    final double cameraFitPadding = _RouteTitleHeader.getPadding(context);
    final double cameraTopPadding;
    if (widget.settings.showRouteInfo) {
      cameraTopPadding =
          _RouteTitleHeader.getHeight(context) + (2 * cameraFitPadding);
    } else {
      cameraTopPadding = cameraFitPadding;
    }

    final CameraFit cameraFit = CameraFit.bounds(
      bounds: LatLngBounds.fromPoints(_geometry!),
      padding: EdgeInsets.only(
        left: cameraFitPadding,
        right: cameraFitPadding,
        bottom: cameraFitPadding,
        top: cameraTopPadding,
      ),
    );
    _mapController.fitCamera(cameraFit);
  }

  @override
  Widget build(BuildContext context) {
    final stopinfo = StopInfo.of(context);

    final DigitransitStopInfoRoute? route = widget.route != null
        ? stopinfo?.routes[widget.route!.routeGtfsId]
        : null;

    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider),
    ];

    if (_geometry != null) {
      mapChildren.add(
        PolylineLayer(
          polylines: [
            Polyline(
              points: _geometry!,
              color: route?.color ?? Colors.grey,
              strokeWidth: 4 * Layout.of(context).logicalPixelSize,
            ),
          ],
        ),
      );
    }
    if (widget.settings.showStops && _stops != null) {
      mapChildren.add(
        CircleLayer(
          circles: _stops!
              .map(
                (e) => buildStopMarker(
                  LatLng(e.lat, e.lon),
                  camera: _mapController.camera,
                  zoomOverride: 6 * Layout.of(context).logicalPixelSize,
                ),
              )
              .toList(),
        ),
      );
    }

    // Draw stops and vehicles on top of line
    mapChildren.add(
      MarkerLayer(
        markers: _vehiclePositions.values
            .map(
              (e) => buildVehicleMarker(
                context,
                mapController: _mapController,
                pos: e,
                zoomOverride: _mapController.camera.minZoom!,
              ),
            )
            .toList(growable: false),
      ),
    );

    if (widget.settings.showRouteInfo) {
      mapChildren.add(_RouteTitleHeader(route: route));
    }

    if (_positioningSubError != null) {
      mapChildren.add(
        MapErrorLayer(error: _positioningSubError!),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        minZoom: 8,
        maxZoom: 22,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: kDefaultMapPosition,
      ),
      children: mapChildren,
    );
  }
}

class _RouteTitleHeader extends StatelessWidget {
  final DigitransitStopInfoRoute? route;

  const _RouteTitleHeader({required this.route});

  static double getHeight(BuildContext context) =>
      Layout.of(context).tileHeight;
  static double getPadding(BuildContext context) =>
      Layout.of(context).shrinkedPadding;

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);
    final double padding = getPadding(context);
    final double totalHeight = getHeight(context);
    final double contentHeight = totalHeight - (2 * padding);

    return Positioned(
      left: padding,
      top: padding,
      height: totalHeight,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: route?.color ?? Colors.grey,
          borderRadius: BorderRadius.circular(padding),
        ),
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: Row(
            children: [
              SvgPicture(
                height: contentHeight,
                NyssePictograms.getModePictogram(
                  StopInfo.of(context)?.vehicleMode ?? DigitransitMode.bus,
                ),
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                alignment: Alignment.centerLeft,
              ),
              SizedBox(width: padding),
              Text(
                "${route?.shortName ?? "??"} ",
                style: layout.labelStyle.copyWith(
                  fontSize: layout.labelStyle.fontSize! / 3,
                ),
              ),
              Text(
                route?.longName ?? "?????????? ?????????? ??????????",
                style: layout.shrinkedLabelStyle.copyWith(
                  fontSize: layout.shrinkedLabelStyle.fontSize! / 3,
                  height: layout.labelStyle.fontSize! /
                      layout.shrinkedLabelStyle.fontSize!,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
