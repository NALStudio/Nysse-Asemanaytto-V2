import 'dart:async';
import 'dart:collection';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/helpers/helpers.dart';
import 'package:nysse_asemanaytto/core/components/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/stop_marker_layer.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/vehicle_marker_layer.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

import 'package:nysse_asemanaytto/main/stoptimes.dart';

final GlobalKey<_MapVehiclesEmbedWidgetState> _mapKey = GlobalKey();
final GlobalKey<VehicleMarkerLayerState> _vehiclesKey = GlobalKey();

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
        tileProvider: MapEmbedTiles.digitransit512,
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
    // Reset animation so that the tiles don't pop in during enable
    _mapKey.currentState?.resetMapAnimation();

    _vehiclesKey.currentState?.stopUpdate();
    _vehiclesKey.currentState?.clearVehicleData();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.scheduleMapAnimation(
      durationFromDouble(seconds: settings.beforeAnimationSeconds),
    );

    _vehiclesKey.currentState?.startUpdate();
  }
}

class _MapVehiclesEmbedWidgetState extends State<MapVehiclesEmbedWidget>
    with SingleTickerProviderStateMixin {
  late final MapController _mapController;
  late final AnimationController _mapAnimationController;
  late final TileProvider _tileProvider;

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

  final Map<GtfsId, DigitransitMqttSubscription> _positioningSubs = {};

  DigitransitMqttState? _mqtt;

  @override
  void initState() {
    super.initState();

    _mapController = MapController();

    _mapAnimationController = AnimationController(vsync: this);
    _mapAnimationController.addListener(
      () => _updateMapAnimation(_mapAnimationController.value),
    );

    _tileProvider = CancellableNetworkTileProvider(silenceExceptions: true);
  }

  @override
  void didChangeDependencies() {
    _mqtt = DigitransitMqtt.maybeOf(context);
    updateMqttSubs();

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

    _tileProvider.dispose();

    _unsubscribeMqtt();

    super.dispose();
  }

  LatLng _getStopPositionOrDefault() {
    final stopinfo = StopInfo.of(context);

    final double? lat = stopinfo?.lat;
    final double? lon = stopinfo?.lon;

    if (lat != null && lon != null) {
      return LatLng(lat, lon);
    } else {
      return kDefaultMapPosition;
    }
  }

  void updateMqttSubs() {
    MapEmbedVehicles vehicles = widget.settings.vehicles;

    bool trip;
    Set<GtfsId>? requests;
    if (vehicles == MapEmbedVehicles.scheduledTrips) {
      trip = true;
      requests = Stoptimes.of(context)
          ?.stoptimesWithoutPatterns
          ?.map((st) => st.tripGtfsId)
          .nonNulls
          .toSet();
    } else if (vehicles == MapEmbedVehicles.allRoutes) {
      trip = false;
      requests = StopInfo.of(context)?.routes.keys.toSet();
    } else {
      throw UnimplementedError("Setting: $vehicles not implemented.");
    }

    if (requests == null) return;

    // Delete all subs that are not needed anymore (no pending request found)
    // We also remove all requests that already have a value
    _positioningSubs.removeWhere((key, value) {
      if (!requests!.remove(key)) {
        _mqtt?.unsubscribe(value);
        return true;
      }
      return false;
    });

    // Add new requests
    for (final GtfsId req in requests) {
      DigitransitMqttSubscription? sub;
      if (trip) {
        sub = _mqtt?.subscribeTrip(req);
      } else {
        sub = _mqtt?.subscribeRoute(req);
      }

      if (sub != null) {
        sub.onMessageReceived = _onVehiclePositionUpdate;

        assert(!_positioningSubs.containsKey(req));
        _positioningSubs[req] = sub;
      }
    }
  }

  void _onVehiclePositionUpdate(FeedEntity entity) {
    _vehiclesKey.currentState?.updateVehicle(entity);
  }

  void _unsubscribeMqtt() {
    for (DigitransitMqttSubscription sub in _positioningSubs.values) {
      _mqtt?.unsubscribe(sub);
    }
    _positioningSubs.clear();
  }

  void scheduleMapAnimation(Duration delay) {
    resetMapAnimation();

    if (delay == Duration.zero) {
      _runMapAnimation();
      return;
    }

    _scheduledMapAnimations.add(Timer(delay, _runMapAnimation));
  }

  void runMapAnimation() {
    resetMapAnimation();
    _runMapAnimation();
  }

  // Resets the map to the start of animation.
  void resetMapAnimation() {
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

    final String stopRawId = Config.of(context).stopId.rawId;

    switch (widget.settings.cameraFit) {
      case MapEmbedCameraFit.fixed:
        destPos = stopPos;
        destZoom = _mapController.camera.maxZoom!;
      case MapEmbedCameraFit.fitArrivingVehicles:
      case MapEmbedCameraFit.fitVehicles:
        final Iterable<LatLng>? vehiclePos;

        if (widget.settings.cameraFit ==
            MapEmbedCameraFit.fitArrivingVehicles) {
          vehiclePos = _vehiclesKey.currentState?.getVehiclePositions(
            filter: (v) => v.stopId == stopRawId,
          );
        } else {
          vehiclePos = _vehiclesKey.currentState?.getVehiclePositions();
        }

        final List<LatLng>? fitPositions = vehiclePos?.toList(growable: true);
        if (fitPositions == null || fitPositions.isEmpty) {
          destPos = stopPos;
          destZoom = _mapController.camera.maxZoom!;
          break;
        }

        fitPositions.add(stopPos);

        final MapCamera fit = CameraFit.coordinates(
          coordinates: fitPositions,
          padding: EdgeInsets.all(MediaQuery.sizeOf(context).width / 8),
          maxZoom: _mapController.camera.maxZoom!,
          // +1 so that map zooms even at least a little bit.
          minZoom: _mapController.camera.minZoom! + 1,
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
      buildMapEmbedTileProvider(
        context,
        tileProvider: _tileProvider,
        tileStyle: widget.settings.tileProvider,
      )
    ];

    if (_mapReady) {
      mapChildren.add(VehicleMarkerLayer(key: _vehiclesKey));

      final LatLng? stopPos = stopinfo?.latlon;
      if (stopPos != null) {
        mapChildren.add(
          StopMarkerLayer(stops: [stopPos]),
        );
      }
    }

    if (_mqtt?.healthy != true) {
      mapChildren.add(MapErrorLayer(error: MqttOfflineErrorWidget(_mqtt)));
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
