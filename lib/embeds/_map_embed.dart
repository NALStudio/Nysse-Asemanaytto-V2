import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
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
  bool? correctMapInitialPosition;
  late MapController _mapController;
  late AnimationController _mapAnimationController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();

    _mapAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _mapAnimationController.addListener(
      () => _updateMapAnim(_mapAnimationController.value),
    );
  }

  @override
  void dispose() {
    _mapController.dispose();
    _mapAnimationController.dispose();
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

  void animateMap() {
    _updateMapAnim(0);
    _mapAnimationController.reset();
    _mapAnimationController.forward();
  }

  void _updateMapAnim(double t) {
    final LatLng target = _getStopPositionOrDefault();

    const double kZoomMin = 13;
    const double kZoomMax = 19;
    // const double kRotMin = -45;
    // const double kRotMax = 0;

    _mapController.move(
      target,
      lerpDouble(kZoomMin, kZoomMax, Curves.easeInOut.transform(t))!,
      // lerpDouble(kRotMin, kRotMax, Curves.easeOut.transform(t))!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        interactionOptions: InteractionOptions(
            // flags: InteractiveFlag.none,
            ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://cdn.digitransit.fi/map/v2/hsl-map-256/{z}/{x}/{y}{r}.png?digitransit-subscription-key=${Config.of(context).digitransitSubscriptionKey!}",
          tileProvider: CancellableNetworkTileProvider(),
          userAgentPackageName: "com.nalstudio.nysse_asemanaytto",
        ),
        MarkerLayer(
          markers: [_buildStopMarker(_getStopPositionOrDefault())],
        ),
      ],
    );
  }
}

Marker _buildStopMarker(LatLng point) {
  return Marker(
    point: point,
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
