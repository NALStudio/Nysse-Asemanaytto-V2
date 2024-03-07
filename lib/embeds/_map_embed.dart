import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/digitransit/positioning/positioning.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

final GlobalKey<_MapEmbedWidgetState> _mapKey = GlobalKey();

class MapEmbed extends Embed {
  const MapEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapEmbed> createEmbed(covariant MapEmbedSettings settings) =>
      MapEmbedWidget(key: _mapKey);

  @override
  EmbedSettings<MapEmbed> deserializeSettings(String? serialized) =>
      MapEmbedSettings.deserialize(serialized);
}

class MapEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin<MapEmbed> {
  const MapEmbedWidget({super.key});

  @override
  State<MapEmbedWidget> createState() => _MapEmbedWidgetState();

  @override
  Duration? getDuration() => const Duration(seconds: 15);

  @override
  void onDisable() {}

  @override
  void onEnable() {
    _mapKey.currentState?.animateMap();
  }
}

class _MapEmbedWidgetState extends State<MapEmbedWidget>
    with SingleTickerProviderStateMixin {
  late MapController _mapController;
  late AnimationController _mapAnimationController;

  static const Curve _moveCurve = Curves.easeInOut;
  static const Curve _zoomCurve = Curves.easeInOut;
  late LatLng _sourcePos;
  late double _sourceZoom;
  late LatLng _destPos;
  late double _destZoom;

  double _posAnimT = 0.0;
  double _zoomAnimT = 0.0;

  bool _mapReady = false;

  PositioningSubscription? _positioningSub;
  List<VehiclePosition> _mapVehicles = List.empty();

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _mapAnimationController.addListener(
      () => _updateMapAnimation(_mapAnimationController.value),
    );
  }

  void _onMapReady() {
    _mapReady = true;
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapAnimationController.dispose();

    if (_positioningSub != null) {
      PositioningProvider.of(context).unsubscribe(_positioningSub!);
    }

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

  void _connectPositioning() {
    final Config config = Config.of(context);
    _positioningSub = PositioningProvider.of(context).subscribe(
      PositioningTopic(
        feedId: config.stopId.stopFeedId,
        nextStop: config.stopId.stopGtfsId,
      ),
    );
    _positioningSub!.addListener(
      () => _mapVehicles = _positioningSub!.vehiclePositions.toList(),
    );
  }

  void animateMap() {
    if (!_mapReady) return;

    if (_positioningSub == null) {
      _connectPositioning();
    }

    _sourcePos = _getStopPositionOrDefault();
    _sourceZoom = 13;

    _destPos = _sourcePos;
    // TODO: Adjust zoom to fit closest vehicle.
    _destZoom = 19;

    _updateMapAnimation(0);
    _mapAnimationController.reset();
    _mapAnimationController.forward();
  }

  void _updateMapAnimation(double t) {
    setState(() {
      _posAnimT = _moveCurve.transform(t);
      _zoomAnimT = _zoomCurve.transform(t);
    });

    _mapController.move(
      LatLng(
        lerpDouble(_sourcePos.latitude, _destPos.latitude, _posAnimT)!,
        lerpDouble(_sourcePos.longitude, _destPos.longitude, _posAnimT)!,
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

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: const LatLng(61.497742570, 23.761290078),
        onMapReady: _onMapReady,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://cdn.digitransit.fi/map/v2/hsl-map-256/{z}/{x}/{y}{r}.png?digitransit-subscription-key=${Config.of(context).digitransitSubscriptionKey!}",
          retinaMode: true,
          tileProvider: CancellableNetworkTileProvider(),
          userAgentPackageName: RequestInfo.packageName,
        ),
        MarkerLayer(
          markers: _mapVehicles
              .map((e) => _buildVehicleMarker(e))
              .toList(growable: false),
        ),
        MarkerLayer(markers: stopMarkers),
      ],
    );
  }

  Marker _buildStopMarker(LatLng point) {
    double size = lerpDouble(10, 30, _zoomAnimT)!;
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
    double size = lerpDouble(10, 30, _zoomAnimT)!;
    LatLng point = LatLng(pos.position.latitude, pos.position.longitude);

    return Marker(
      point: point,
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
          border: Border.all(
            color: Colors.blue,
            width: 3,
          ),
        ),
      ),
    );
  }
}

class MapEmbedSettings extends EmbedSettings<MapEmbed> {
  MapEmbedSettings.deserialize(super.serialized) : super.deserialize();

  @override
  EmbedSettingsForm<MapEmbedSettings> createForm() =>
      MapEmbedSettingsForm(settingsParent: this);

  @override
  String serialize() => "";
}

class MapEmbedSettingsForm extends EmbedSettingsForm<MapEmbedSettings> {
  MapEmbedSettingsForm({required super.settingsParent});

  @override
  Widget build(BuildContext context) {
    return const Text("TODO");
  }

  @override
  Color get displayColor => Colors.grey;

  @override
  String get displayName => "Map Embed";
}
