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
    _mapKey.currentState!.displayedData = null;
    _mapKey.currentState!.unsubscribeMqtt();
  }

  @override
  void onEnable() {}

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

        final DigitransitStopInfoRoute? route =
            StopInfo.of(context)?.routes[stoptime.routeGtfsId];

        return _MapLinesEmbedWidget(
          settings,
          key: _mapKey,
          displayedData: _DisplayedData(
            routeGtfsId: stoptime.routeGtfsId!,
            tripRoute: parsed,
            route: route,
          ),
        );
      },
    );
  }
}

class _MapLinesEmbedWidget extends StatefulWidget {
  final MapLinesEmbedSettings settings;
  final _DisplayedData displayedData;

  const _MapLinesEmbedWidget(
    this.settings, {
    super.key,
    required this.displayedData,
  });

  @override
  State<StatefulWidget> createState() => _MapLinesEmbedWidgetState();
}

class _MapLinesEmbedWidgetState extends State<_MapLinesEmbedWidget> {
  _DisplayedData? displayedData;

  late final MapController _mapController;

  DigitransitMqttSubscription? _positioningSub;
  bool get _mqttSubscribed => _positioningSub != null;

  ErrorWidget? _positioningSubError;
  final Map<String, VehiclePosition> _vehiclePositions = {};

  _ComputedRoute? _computedRoute;

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

  void _subscribeMqtt(GtfsId routeId) {
    if (_mqtt?.isConnected != true) {
      _positioningSubError = MqttOfflineErrorWidget();
      return;
    }

    final GtfsId stopId = Config.of(context).stopId;

    _positioningSubError = null;
    _positioningSub = _mqtt!.subscribe(
      DigitransitPositioningTopic(
        feedId: stopId.feedId,
        routeId: routeId.rawId,
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
  void _computeGeometry(DigitransitTripRouteQuery? route) {
    final String? patternGeometry = route?.pattern.patternGeometry;
    if (patternGeometry == null) {
      _computedRoute = null;
      return;
    }

    _computedRoute = _ComputedRoute(
      routeGtfsId: route!.routeGtfsId,
      geometry: decodePolyline(patternGeometry).toList(),
      stops: route.pattern.stops,
    );

    final double cameraFitPadding = _RouteTitleHeader.getPadding(context);
    final double cameraTopPadding;
    if (widget.settings.showRouteInfo) {
      cameraTopPadding =
          _RouteTitleHeader.getHeight(context) + (2 * cameraFitPadding);
    } else {
      cameraTopPadding = cameraFitPadding;
    }

    final CameraFit cameraFit = CameraFit.bounds(
      bounds: LatLngBounds.fromPoints(_computedRoute!.geometry),
      padding: EdgeInsets.only(
        left: cameraFitPadding,
        right: cameraFitPadding,
        bottom: cameraFitPadding,
        top: cameraTopPadding,
      ),
    );
    _mapController.fitCamera(cameraFit);
  }

  /// TODO: Rethink this entire data fetching process.

  @override
  Widget build(BuildContext context) {
    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider),
    ];

    if (_computedRoute != null) {
      mapChildren.add(
        PolylineLayer(
          polylines: [
            Polyline(
              points: _computedRoute!.geometry,
              color: displayedData?.route?.color ?? Colors.grey,
              strokeWidth: 4 * Layout.of(context).logicalPixelSize,
            ),
          ],
        ),
      );
    }
    if (widget.settings.showStops && _computedRoute != null) {
      mapChildren.add(
        CircleLayer(
          circles: _computedRoute!.stops
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
      mapChildren.add(_RouteTitleHeader(route: displayedData?.route));
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

class _DisplayedData {
  /// Unlike [tripRoute], this will always be provided.
  final GtfsId routeGtfsId;
  final DigitransitTripRouteQuery? tripRoute;
  final DigitransitStopInfoRoute? route;

  _DisplayedData({
    required this.routeGtfsId,
    required this.tripRoute,
    required this.route,
  });
}

class _ComputedRoute {
  final GtfsId routeGtfsId;
  final List<LatLng> geometry;
  final List<DigitransitPatternStop> stops;

  _ComputedRoute({
    required this.routeGtfsId,
    required this.geometry,
    required this.stops,
  });
}
