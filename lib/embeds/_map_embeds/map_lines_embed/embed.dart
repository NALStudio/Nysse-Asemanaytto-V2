import 'dart:collection';

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
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/_decode_polyline.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/stop_marker_layer.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/vehicle_marker_layer.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

import 'package:nysse_asemanaytto/main/stoptimes.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

final GlobalKey<_MapLinesEmbedWidgetState> _mapKey = GlobalKey();
final GlobalKey<VehicleMarkerLayerState> _vehiclesKey = GlobalKey();

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
          tripRoute: parsed,
          route: route,
        );
      },
    );
  }

  @override
  void onDisable() {
    _mapKey.currentState?.onDisabled();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.onEnabled();
  }
}

class _MapLinesEmbedWidget extends StatefulWidget {
  final MapLinesEmbedSettings settings;
  final DigitransitTripRouteQuery? tripRoute;
  final DigitransitStopInfoRoute? route;

  const _MapLinesEmbedWidget(
    this.settings, {
    super.key,
    required this.tripRoute,
    required this.route,
  });

  @override
  State<StatefulWidget> createState() => _MapLinesEmbedWidgetState();
}

class _MapLinesEmbedWidgetState extends State<_MapLinesEmbedWidget> {
  late final MapController _mapController;

  DigitransitMqttSubscription? _positioningSub;
  GtfsId? _subbedRouteId;
  bool get _isSubbed {
    assert((_positioningSub == null) == (_subbedRouteId == null));
    return _positioningSub != null;
  }

  ErrorWidget? _positioningSubError;

  _ComputedRoute? _computedRoute;

  DigitransitMqttState? _mqtt;

  bool _embedIsEnabled = false;
  bool _mapReady = false;

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
    onDisabled();
    _mapController.dispose();
    super.dispose();
  }

  void onEnabled() {
    _embedIsEnabled = true;

    if (widget.route != null) {
      _subscribeMqtt(widget.route!.gtfsId);
    }

    _vehiclesKey.currentState?.startUpdate();

    _fitCamera();
  }

  void onDisabled() {
    _embedIsEnabled = false;
    _unsubscribeMqtt();

    _vehiclesKey.currentState?.stopUpdate();
    _vehiclesKey.currentState?.clearVehicleData();
  }

  void _subscribeMqtt(GtfsId routeId) {
    assert(_embedIsEnabled);
    assert(!_isSubbed);

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
    _subbedRouteId = routeId;

    _positioningSub!.onMessageReceived = _onVehiclePositionUpdate;
  }

  void _onVehiclePositionUpdate(DigitransitMqttMessage msg) {
    final FeedEntity ent = FeedEntity.fromBuffer(msg.bytes);
    setState(() {
      _vehiclesKey.currentState?.updateVehicle(ent);
    });
  }

  /// Safe to call multiple times.
  void _unsubscribeMqtt() {
    if (_positioningSub != null) {
      _mqtt?.unsubscribe(_positioningSub!);
      _positioningSub = null;
      _subbedRouteId = null;
    }
  }

  double get routeLineStrokeWidth => 4 * Layout.of(context).logicalPixelSize;

  void _fitCamera() {
    if (!_mapReady) return;
    if (_computedRoute == null) return;

    final double cameraFitPadding = Layout.of(context).widePadding;
    final double cameraTopPadding;
    if (widget.settings.showRouteInfo) {
      cameraTopPadding = _RouteTitleHeader.getPadding(context) +
          _RouteTitleHeader.getHeight(context) +
          cameraFitPadding;
    } else {
      cameraTopPadding = cameraFitPadding;
    }

    final double cameraFitPaddingAdjust = routeLineStrokeWidth / 2;

    final CameraFit cameraFit = CameraFit.bounds(
      bounds: LatLngBounds.fromPoints(_computedRoute!.geometry),
      padding: EdgeInsets.fromLTRB(
        cameraFitPadding + cameraFitPaddingAdjust,
        cameraTopPadding + cameraFitPaddingAdjust, // NOTE: Top is different
        cameraFitPadding + cameraFitPaddingAdjust,
        cameraFitPadding + cameraFitPaddingAdjust,
      ),
    );
    _mapController.fitCamera(cameraFit);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tripRoute != null &&
        _computedRoute?.pattern.code != widget.tripRoute!.pattern.code) {
      _computedRoute = _ComputedRoute.decode(widget.tripRoute!.pattern);
    }
    if (widget.route != null && _subbedRouteId != widget.route!.gtfsId) {
      _unsubscribeMqtt();
      _vehiclesKey.currentState?.clearVehicleData();

      if (_embedIsEnabled) {
        _subscribeMqtt(widget.route!.gtfsId);
      }
    }

    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider),
    ];

    if (_computedRoute != null) {
      // Route line
      mapChildren.add(
        PolylineLayer(
          // Disable culling: we always zoom the entire line into view
          cullingMargin: null,
          polylines: [
            Polyline(
              points: _computedRoute!.geometry,
              color: widget.route?.color ?? Colors.grey,
              strokeWidth: routeLineStrokeWidth,
            ),
          ],
        ),
      );

      // Route stops
      if (widget.settings.showStops) {
        mapChildren.add(StopMarkerLayer.fromPattern(_computedRoute!.pattern));
      }
    }

    // Route vehicles
    mapChildren.add(VehicleMarkerLayer(key: _vehiclesKey));

    if (widget.settings.showRouteInfo) {
      mapChildren.add(_RouteTitleHeader(route: widget.route));
    }

    if (_positioningSubError != null) {
      mapChildren.add(
        MapErrorLayer(error: _positioningSubError!),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: kDefaultMapPosition,
        onMapReady: () => _mapReady = true,
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

class _ComputedRoute {
  final DigitransitPattern pattern;
  final List<LatLng> geometry;
  final LatLngBounds bounds;

  _ComputedRoute({
    required this.pattern,
    required this.geometry,
    required this.bounds,
  });

  static _ComputedRoute? decode(DigitransitPattern pattern) {
    String? geometry = pattern.patternGeometry;
    if (geometry == null) return null;

    List<LatLng> geo = decodePolyline(geometry).toList(growable: false);
    LatLngBounds bounds = LatLngBounds.fromPoints(geo);

    return _ComputedRoute(
      pattern: pattern,
      geometry: geo,
      bounds: bounds,
    );
  }
}
