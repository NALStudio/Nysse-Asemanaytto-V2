import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/core/painters/bus_marker_painter.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/core/widgets/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'dart:math' as math;

final GlobalKey<_MapEmbedWidgetState> _mapKey = GlobalKey();

class MapEmbed extends Embed {
  const MapEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapEmbed> createEmbed(covariant MapEmbedSettings settings) =>
      MapEmbedWidget(key: _mapKey, settings: settings);

  @override
  EmbedSettings<MapEmbed> createDefaultSettings() => MapEmbedSettings(
        beforeAnimationSeconds: 0.5,
        animationDurationSeconds: 10,
        afterAnimationSeconds: 5.0,
        cameraFit: MapEmbedCameraFit.fitVehicles,
        vehicles: MapEmbedVehicles.arrivingOnly,
      );
}

class MapEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin<MapEmbed> {
  final MapEmbedSettings settings;

  const MapEmbedWidget({required this.settings, super.key});

  @override
  State<MapEmbedWidget> createState() => _MapEmbedWidgetState();

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

class _MapEmbedWidgetState extends State<MapEmbedWidget>
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
    final stopInfo = StopInfo.of(context);

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
      case MapEmbedVehicles.allRoutes:
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
      // (doesn't fit to our topic, too far for example)
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

    switch (widget.settings.cameraFit) {
      case MapEmbedCameraFit.fixed:
        destPos = stopPos;
        destZoom = _mapController.camera.maxZoom!;
      case MapEmbedCameraFit.fitVehicles:
        if (_vehiclePositions.isEmpty) {
          destPos = stopPos;
          destZoom = _mapController.camera.maxZoom!;
          break;
        }

        final List<LatLng> vehiclePositions = _vehiclePositions.values
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
      TileLayer(
        urlTemplate:
            "https://cdn.digitransit.fi/map/v2/hsl-map-256/{z}/{x}/{y}{r}.png?digitransit-subscription-key=${Config.of(context).digitransitSubscriptionKey!}",
        retinaMode: true,
        tileProvider: CancellableNetworkTileProvider(silenceExceptions: true),
        userAgentPackageName: RequestInfo.packageName,
      ),
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
    const double textBorderPadding = 1;

    const double fontSizePadding = (2 * borderWidth) - (2 * textBorderPadding);
    final double fontSize = size - fontSizePadding;
    final double maxFontSize = maxSize - fontSizePadding;

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
          lineNumberSize: fontSize,
          lineNumberMinSize: 12 * Layout.of(context).logicalPixelSize,
          lineNumberMaxSize: maxFontSize,
        ),
      ),
    );
  }
}

enum MapEmbedCameraFit { fixed, fitVehicles }

const Map<MapEmbedCameraFit, String> _mapEmbedCameraFitNotes = {
  MapEmbedCameraFit.fitVehicles:
      "Only the vehicle positions received during 'Wait before animation' are considered when fitting the camera.",
};

enum MapEmbedVehicles { allRoutes, arrivingOnly }

class MapEmbedSettings extends EmbedSettings<MapEmbed> {
  double beforeAnimationSeconds;
  double animationDurationSeconds;
  double afterAnimationSeconds;

  MapEmbedCameraFit cameraFit;
  MapEmbedVehicles vehicles;

  MapEmbedSettings({
    required this.beforeAnimationSeconds,
    required this.animationDurationSeconds,
    required this.afterAnimationSeconds,
    required this.cameraFit,
    required this.vehicles,
  });

  @override
  void deserialize(String serialized) {
    final Map<String, dynamic> map = json.decode(serialized);
    beforeAnimationSeconds = (map["waitBeforeAnim"] as num).toDouble();
    animationDurationSeconds = (map["animDuration"] as num).toDouble();
    afterAnimationSeconds = (map["waitAfterAnim"] as num).toDouble();

    final String cameraFitStr = map["cameraFit"];
    final String vehiclesStr = map["vehicles"];
    cameraFit = MapEmbedCameraFit.values
        .firstWhere((element) => element.name == cameraFitStr);
    vehicles = MapEmbedVehicles.values
        .firstWhere((element) => element.name == vehiclesStr);
    // as num cast so that if there is an integer in the json,
    // it is still saved as double. (aka doesn't crash)
  }

  @override
  String serialize() {
    final Map<String, dynamic> map = {
      "waitBeforeAnim": beforeAnimationSeconds,
      "animDuration": animationDurationSeconds,
      "waitAfterAnim": afterAnimationSeconds,
      "cameraFit": cameraFit.name,
      "vehicles": vehicles.name,
    };
    return json.encode(map);
  }

  @override
  EmbedSettingsForm<MapEmbedSettings> createForm(
    covariant MapEmbedSettings defaultSettings,
  ) =>
      MapEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );
}

class MapEmbedSettingsForm extends EmbedSettingsForm<MapEmbedSettings> {
  MapEmbedCameraFit? _cameraFitSetting;
  MapEmbedVehicles? _vehicleSetting;

  MapEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  String? _formatValue(num number) {
    String suffix;
    if (number == 1) {
      suffix = "second";
    } else {
      suffix = "seconds";
    }

    return "$number $suffix";
  }

  double? _tryParseDouble(String? value) {
    if (value == null) return null;

    String? number = value.split(' ').firstOrNull;
    if (number == null) return null;

    return double.tryParse(number);
  }

  String _formatEnumName(Enum value, {bool capitalizeFirstChar = true}) {
    final String enumName = value.name;
    String output = "";

    // first character isn't upper-case in camelCase
    // But we want to take the portion from start to the first upper-case character
    // So we set this as 0 at start.
    int lastUpperIndex = 0;
    for (final (int index, String char) in enumName.characters.indexed) {
      if (char == char.toUpperCase()) {
        // Add the portion between these upper characters.
        output += ' ';
        output += enumName.substring(lastUpperIndex, index).toLowerCase();
        lastUpperIndex = index;
      }
    }
    // Add the rest of the name
    output += enumName.substring(lastUpperIndex);

    if (capitalizeFirstChar) {
      return output[0].toUpperCase() + output.substring(1);
    } else {
      return output;
    }
  }

  List<DropdownMenuItem<T?>> _buildDropdownMenuItems<T extends Enum>(
    List<T> enumValues, {
    required T defaultValue,
  }) {
    return enumValues.map((e) {
      String formattedName = _formatEnumName(e);
      if (e == defaultValue) {
        formattedName += " (default)";
      }

      return DropdownMenuItem(
        value: e,
        child: Text(formattedName),
      );
    }).toList();
  }

  String? _doubleValidate(
    String? value, {
    bool allowNegativeNumbers = false,
  }) {
    if (value?.isNotEmpty != true) {
      return null;
    }

    final double? number = _tryParseDouble(value);
    if (number == null) {
      return "Not a valid decimal number.";
    }
    if (!allowNegativeNumbers && number < 0) {
      return "Value cannot be negative.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _cameraFitSetting ??= parentSettings.cameraFit;
    _vehicleSetting ??= parentSettings.vehicles;

    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Wait before animation",
            hintText: _formatValue(defaultSettings.beforeAnimationSeconds),
          ),
          initialValue: _formatValue(parentSettings.beforeAnimationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.beforeAnimationSeconds =
                  defaultSettings.beforeAnimationSeconds;
            } else {
              parentSettings.beforeAnimationSeconds =
                  _tryParseDouble(newValue)!;
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Animation duration",
            hintText: _formatValue(defaultSettings.animationDurationSeconds),
          ),
          initialValue: _formatValue(parentSettings.animationDurationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.animationDurationSeconds =
                  defaultSettings.animationDurationSeconds;
            } else {
              parentSettings.animationDurationSeconds =
                  _tryParseDouble(newValue)!;
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Wait after animation",
            hintText: _formatValue(defaultSettings.afterAnimationSeconds),
          ),
          initialValue: _formatValue(parentSettings.afterAnimationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.afterAnimationSeconds =
                  defaultSettings.afterAnimationSeconds;
            } else {
              parentSettings.afterAnimationSeconds = _tryParseDouble(newValue)!;
            }
          },
        ),
        DropdownButtonFormField<MapEmbedCameraFit?>(
          decoration: InputDecoration(
            labelText: "Camera Fit",
            hintText: _formatEnumName(defaultSettings.vehicles),
            helperText: _mapEmbedCameraFitNotes[_cameraFitSetting],
          ),
          items: _buildDropdownMenuItems(
            MapEmbedCameraFit.values,
            defaultValue: defaultSettings.cameraFit,
          ),
          value: _cameraFitSetting,
          onChanged: (value) => _cameraFitSetting = value,
          onSaved: (newValue) =>
              parentSettings.cameraFit = newValue ?? defaultSettings.cameraFit,
        ),
        DropdownButtonFormField<MapEmbedVehicles?>(
          decoration: InputDecoration(
            labelText: "Vehicles",
            hintText: _formatEnumName(defaultSettings.vehicles),
          ),
          items: _buildDropdownMenuItems(
            MapEmbedVehicles.values,
            defaultValue: defaultSettings.vehicles,
          ),
          value: _vehicleSetting,
          onChanged: (value) => _vehicleSetting = value,
          onSaved: (newValue) =>
              parentSettings.vehicles = newValue ?? defaultSettings.vehicles,
        ),
      ],
    );
  }

  @override
  Color get displayColor => Colors.green;

  @override
  String get displayName => "Map Embed";
}
