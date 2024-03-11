import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/core/painters/bus_marker_painter.dart';
import 'package:nysse_asemanaytto/core/widgets/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'dart:math' as math;

import 'package:nysse_asemanaytto/main/stoptimes.dart';

final GlobalKey<_MapVehiclesEmbedWidgetState> _mapKey = GlobalKey();

class MapVehiclesEmbed extends Embed {
  const MapVehiclesEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapVehiclesEmbed> createEmbed(
          covariant MapEmbedSettings settings) =>
      MapVehiclesEmbedWidget(key: _mapKey, settings: settings);

  @override
  EmbedSettings<MapVehiclesEmbed> createDefaultSettings() => MapEmbedSettings(
        beforeAnimationSeconds: 1.0,
        animationDurationSeconds: 10,
        afterAnimationSeconds: 5.0,
        tileProvider: MapEmbedTileProvider.digitransitRetina,
        cameraFit: MapEmbedCameraFit.fitArrivingVehicles,
        vehicles: MapEmbedVehicles.scheduledTrips,
      );
}

class MapVehiclesEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin<MapVehiclesEmbed> {
  final MapEmbedSettings settings;

  const MapVehiclesEmbedWidget({required this.settings, super.key});

  @override
  State<MapVehiclesEmbedWidget> createState() => _MapVehiclesEmbedWidgetState();

  @override
  Duration? getDuration() {
    return durationFromDouble(
      seconds: settings.beforeAnimationSeconds +
          settings.animationDurationSeconds +
          settings.afterAnimationSeconds,
    );
  }

  @override
  void onDisable() {
    _mapKey.currentState?.unsubscribeMqttIfNeeded();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.subscribeMqttIfNeeded();
    _mapKey.currentState?.scheduleMapAnimation(
      durationFromDouble(seconds: settings.beforeAnimationSeconds),
    );
  }
}

class _MapVehiclesEmbedWidgetState extends State<MapVehiclesEmbedWidget>
    with SingleTickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController _mapAnimationController;

  static const Curve _moveCurve = Curves.easeInOut;
  static const Curve _zoomCurve = Curves.easeInOut;
  late LatLng _sourcePos;
  late double _sourceZoom;
  LatLng? _destPos;
  double? _destZoom;

  double _posAnimT = 0.0;
  double _zoomAnimT = 0.0;

  bool _mapReady = false;

  final List<Timer> _scheduledMapAnimations = [];

  DigitransitMqttSubscription? _positioningSub;
  Widget? _positioningSubError;
  final Map<String, VehiclePosition> _vehiclePositions = {};

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _mapAnimationController = AnimationController(vsync: this);
    _mapAnimationController.addListener(
      () => _updateMapAnimation(_mapAnimationController.value),
    );
  }

  @override
  void dispose() {
    while (_scheduledMapAnimations.isNotEmpty) {
      final Timer t = _scheduledMapAnimations.removeLast();
      t.cancel();
    }

    _mapController.dispose();
    _mapAnimationController.dispose();

    unsubscribeMqttIfNeeded();

    super.dispose();
  }

  LatLng _getStopPositionOrDefault() {
    final stopinfo = StopInfo.of(context);

    if (stopinfo != null) {
      return LatLng(stopinfo.lat, stopinfo.lon);
    } else {
      return const LatLng(61.497742570, 23.761290078);
    }
  }

  void subscribeMqttIfNeeded() {
    final DigitransitMqttState? mqtt = DigitransitMqtt.maybeOf(context);
    if (mqtt?.isConnected != true) {
      _positioningSubError = MqttOfflineErrorWidget();
      return;
    }

    final GtfsId stopId = Config.of(context).stopId;

    _positioningSubError = null;

    switch (widget.settings.vehicles) {
      case MapEmbedVehicles.arrivingOnly:
        _positioningSub = mqtt!.subscribe(
          DigitransitPositioningTopic(
            feedId: stopId.feedId,
            nextStop: stopId.rawId,
          ).buildTopicString(),
          MqttQos.atMostOnce,
        );
      case MapEmbedVehicles.scheduledTrips:
        final List<DigitransitStoptime>? stoptimes =
            Stoptimes.of(context)?.stoptimesWithoutPatterns;
        if (stoptimes == null) {
          _positioningSubError =
              ErrorWidget.withDetails(message: "No stoptimes");
          return;
        }
        _positioningSub = mqtt!.subscribeAll(
          stoptimes.map(
            (e) => DigitransitPositioningTopic(
              feedId: e.tripGtfsId!.feedId,
              tripId: e.tripGtfsId!.rawId,
            ).buildTopicString(),
          ),
          MqttQos.atMostOnce,
        );
      case MapEmbedVehicles.allRoutes:
        final stopInfo = StopInfo.of(context);
        if (stopInfo == null) {
          _positioningSubError =
              ErrorWidget.withDetails(message: "No stop info.");
          return;
        }
        _positioningSub = mqtt!.subscribeAll(
          stopInfo.routes.keys.map(
            (e) =>
                DigitransitPositioningTopic(feedId: e.feedId, routeId: e.rawId)
                    .buildTopicString(),
          ),
          MqttQos.atMostOnce,
        );
    }

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

  void unsubscribeMqttIfNeeded() {
    if (_positioningSub == null) {
      return;
    }

    DigitransitMqtt.of(context).unsubscribe(_positioningSub!);
    _vehiclePositions.clear();
  }

  void scheduleMapAnimation(Duration delay) {
    _prepareMapAnimation();

    if (delay == Duration.zero) {
      _runMapAnimation();
      return;
    }

    _scheduledMapAnimations.add(Timer(delay, _runMapAnimation));
  }

  void runMapAnimation() {
    _prepareMapAnimation();
    _runMapAnimation();
  }

  // Resets the map to the start of animation.
  void _prepareMapAnimation() {
    if (!_mapReady) return;

    _sourcePos = _getStopPositionOrDefault();
    _sourceZoom = _mapController.camera.minZoom!;

    _updateMapAnimation(0);
    _mapAnimationController.reset();
  }

  void _runMapAnimation() {
    final LatLng destPos;
    final double destZoom;

    final LatLng stopPos = _getStopPositionOrDefault();

    Config config = Config.of(context);

    switch (widget.settings.cameraFit) {
      case MapEmbedCameraFit.fixed:
        destPos = stopPos;
        destZoom = _mapController.camera.maxZoom!;
      case MapEmbedCameraFit.fitArrivingVehicles:
      case MapEmbedCameraFit.fitVehicles:
        if (_vehiclePositions.isEmpty) {
          destPos = stopPos;
          destZoom = _mapController.camera.maxZoom!;
          break;
        }

        final Iterable<VehiclePosition> vehiclePositionsIterable;
        if (widget.settings.cameraFit ==
            MapEmbedCameraFit.fitArrivingVehicles) {
          vehiclePositionsIterable = _vehiclePositions.values
              .where((element) => element.stopId == config.stopId.rawId);
        } else {
          vehiclePositionsIterable = _vehiclePositions.values;
        }

        final List<LatLng> vehiclePositions = vehiclePositionsIterable
            .map((e) => LatLng(e.position.latitude, e.position.longitude))
            .toList(growable: true);
        vehiclePositions.add(stopPos);

        final MapCamera fit = CameraFit.coordinates(
          coordinates: vehiclePositions,
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 10),
          maxZoom: _mapController.camera.maxZoom!,
          minZoom: _mapController.camera.minZoom! + 1,
          // +2 so that map zooms even at least a little bit.
          forceIntegerZoomLevel: false,
        ).fit(_mapController.camera);

        destPos = fit.center;
        destZoom = fit.zoom;
    }

    _destPos = destPos;
    _destZoom = destZoom;

    _mapAnimationController.duration =
        durationFromDouble(seconds: widget.settings.animationDurationSeconds);
    _mapAnimationController.forward();
  }

  void _updateMapAnimation(double t) {
    assert(_destPos != null || t == 0);
    assert(_destZoom != null || t == 0);

    setState(() {
      _posAnimT = _moveCurve.transform(t);
      _zoomAnimT = _zoomCurve.transform(t);
    });

    _mapController.move(
      LatLng(
        lerpDouble(_sourcePos.latitude, _destPos?.latitude, _posAnimT)!,
        lerpDouble(_sourcePos.longitude, _destPos?.longitude, _posAnimT)!,
      ),
      lerpDouble(_sourceZoom, _destZoom, _zoomAnimT)!,
    );
  }

  @override
  Widget build(BuildContext context) {
    final stopinfo = StopInfo.of(context);

    List<Marker> stopMarkers = List.empty(growable: true);
    if (stopinfo != null) {
      stopMarkers.add(_buildStopMarker(LatLng(stopinfo.lat, stopinfo.lon)));
    }

    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider),
      MarkerLayer(
        markers: _vehiclePositions.values
            .map((e) => _buildVehicleMarker(e))
            .toList(growable: false),
      ),
      MarkerLayer(markers: stopMarkers),
    ];

    if (_positioningSubError != null) {
      mapChildren.add(
        Positioned(
          left: _mapController.camera.nonRotatedSize.x / 1.5,
          bottom: _mapController.camera.nonRotatedSize.y / 1.5,
          right: 0,
          top: 0,
          child: _positioningSubError!,
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialZoom: 13,
        minZoom: 13,
        maxZoom: 19,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: const LatLng(61.497742570, 23.761290078),
        onMapReady: () => _mapReady = true,
      ),
      children: mapChildren,
    );
  }

  double _calculateMarkerSize(double minSize, double maxSize,
      {required double zoom}) {
    return remapDouble(
      zoom,
      _mapController.camera.minZoom!,
      _mapController.camera.maxZoom!,
      minSize,
      maxSize,
    );
  }

  Marker _buildStopMarker(LatLng point) {
    double size =
        _calculateMarkerSize(10, 30, zoom: _mapController.camera.zoom);
    return Marker(
      point: point,
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }

  Marker _buildVehicleMarker(VehiclePosition pos) {
    final Config config = Config.of(context);
    final stopInfo = StopInfo.of(context);

    double size = _calculateMarkerSize(
      10,
      30,
      zoom: _mapController.camera.zoom,
    );
    double maxSize = _calculateMarkerSize(
      10,
      30,
      zoom: _mapController.camera.maxZoom!,
    );

    LatLng point = LatLng(pos.position.latitude, pos.position.longitude);

    // example: 6921_91
    final String vehicleId = pos.vehicle.id;
    // 6921_91 => 6921
    final String vehicleIdHeader =
        vehicleId.substring(0, vehicleId.indexOf('_'));

    // example: 86921
    final String routeIdFull = pos.trip.routeId;
    assert(routeIdFull.endsWith(vehicleIdHeader));
    // ^^ No idea why routeId has this weird ass suffix
    // 86921 => 8
    final String routeId =
        routeIdFull.substring(0, routeIdFull.length - vehicleIdHeader.length);

    final GtfsId routeGtfsId = GtfsId.combine(config.stopId.feedId, routeId);

    final DigitransitStopInfoRoute? route = stopInfo?.routes[routeGtfsId];

    const double borderWidth = 3;

    return Marker(
      point: point,
      width: size,
      height: size,
      child: CustomPaint(
        painter: BusMarkerPainter(
          // deg2rad = math.pi / 180
          bearing: pos.position.bearing * (math.pi / 180),
          borderColor: route?.color ?? Colors.grey,
          borderWidth: borderWidth,
          lineNumber: route?.shortName ?? "??",
          maxSize: Size(maxSize, maxSize),
          lineNumberMinSize: 12 * Layout.of(context).logicalPixelSize,
        ),
      ),
    );
  }
}
