import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/core/widgets/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

import 'package:nysse_asemanaytto/main/stoptimes.dart';

final GlobalKey<_MapVehiclesEmbedWidgetState> _mapKey = GlobalKey();

class MapVehiclesEmbed extends Embed {
  const MapVehiclesEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapVehiclesEmbed> createEmbed(
          covariant MapVehiclesEmbedSettings settings) =>
      MapVehiclesEmbedWidget(key: _mapKey, settings: settings);

  @override
  EmbedSettings<MapVehiclesEmbed> createDefaultSettings() =>
      MapVehiclesEmbedSettings(
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
  final MapVehiclesEmbedSettings settings;

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
    _mapKey.currentState?.unsubscribeMqtt();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.subscribeMqtt();
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
  ErrorWidget? _positioningSubError;
  final Map<String, VehiclePosition> _vehiclePositions = {};

  DigitransitMqttState? _mqtt;

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
  void didChangeDependencies() {
    _mqtt = DigitransitMqtt.maybeOf(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    while (_scheduledMapAnimations.isNotEmpty) {
      final Timer t = _scheduledMapAnimations.removeLast();
      t.cancel();
    }

    _mapController.dispose();
    _mapAnimationController.dispose();

    unsubscribeMqtt();

    super.dispose();
  }

  LatLng _getStopPositionOrDefault() {
    final stopinfo = StopInfo.of(context);

    if (stopinfo != null) {
      return LatLng(stopinfo.lat, stopinfo.lon);
    } else {
      return kDefaultMapPosition;
    }
  }

  void subscribeMqtt() {
    if (_mqtt?.isConnected != true) {
      _positioningSubError = MqttOfflineErrorWidget();
      return;
    }

    final GtfsId stopId = Config.of(context).stopId;

    _positioningSubError = null;

    switch (widget.settings.vehicles) {
      case MapEmbedVehicles.arrivingOnly:
        _positioningSub = _mqtt!.subscribe(
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
        _positioningSub = _mqtt!.subscribeAll(
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
        _positioningSub = _mqtt!.subscribeAll(
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

  void unsubscribeMqtt() {
    if (_positioningSub == null) {
      return;
    }

    _mqtt?.unsubscribe(_positioningSub!);
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

    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider)
    ];

    if (_mapReady) {
      mapChildren.add(
        MarkerLayer(
          markers: _vehiclePositions.values
              .map(
                (e) => buildVehicleMarker(
                  context,
                  mapController: _mapController,
                  pos: e,
                ),
              )
              .toList(growable: false),
        ),
      );

      if (stopinfo != null) {
        mapChildren.add(
          MarkerLayer(
            markers: [
              buildStopMarker(
                LatLng(stopinfo.lat, stopinfo.lon),
                camera: _mapController.camera,
              ),
            ],
          ),
        );
      }
    }

    if (_positioningSubError != null) {
      mapChildren.add(MapErrorLayer(error: _positioningSubError!));
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
        initialCenter: kDefaultMapPosition,
        onMapReady: () => _mapReady = true,
      ),
      children: mapChildren,
    );
  }
}
