import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'dart:developer' as developer;

class VehicleMarkerLayer extends StatefulWidget {
  const VehicleMarkerLayer({super.key});

  @override
  State<VehicleMarkerLayer> createState() => VehicleMarkerLayerState();
}

class _VehicleData {
  static const Duration defaultTimeout = Duration(seconds: 3);

  Duration elapsed;
  Duration totalExistTime;
  final Duration timeout;

  final VehiclePosition? previousPosition;
  final VehiclePosition position;

  _VehicleData({
    required this.timeout,
    required this.totalExistTime,
    required this.previousPosition,
    required this.position,
  }) : elapsed = Duration.zero;
}

class VehicleMarkerLayerState extends State<VehicleMarkerLayer>
    with SingleTickerProviderStateMixin {
  static const Duration moveDuration = Duration(seconds: 1);

  Duration? lastTickerUpdate;

  late Ticker _ticker;
  final Map<String, _VehicleData> _vehicles = {};

  @override
  void initState() {
    super.initState();

    _ticker = Ticker(_tickerTick);
  }

  void updateVehicle(
    FeedEntity vehicle, {
    Duration timeout = _VehicleData.defaultTimeout,
  }) {
    _vehicles.update(
      vehicle.id,
      (previous) => _VehicleData(
        timeout: timeout,
        totalExistTime: previous.totalExistTime,
        previousPosition: previous.position,
        position: vehicle.vehicle,
      ),
      ifAbsent: () => _VehicleData(
        timeout: timeout,
        totalExistTime: Duration.zero,
        previousPosition: null,
        position: vehicle.vehicle,
      ),
    );
  }

  void clearVehicleData() {
    _vehicles.clear();
  }

  /// Only include values that satisfy the filter. All values are returned if filter is null.
  Iterable<LatLng> getVehiclePositions({
    bool Function(VehiclePosition pos)? filter,
  }) {
    Iterable<_VehicleData> data;
    if (filter == null) {
      data = _vehicles.values;
    } else {
      data = _vehicles.values.where((v) => filter(v.position));
    }

    return data.map((v) => _positionToLatLng(v.position.position));
  }

  void startUpdate() {
    _ticker.start();
  }

  void stopUpdate() {
    _ticker.stop();
  }

  void _tickerTick(Duration elapsed) {
    setState(() {
      _updateVehicles(elapsed);
    });
  }

  void _updateVehicles(Duration elapsedSinceStart) {
    Duration elapsed;
    Duration? lastUpdate = lastTickerUpdate;
    if (lastUpdate == null) {
      elapsed = elapsedSinceStart;
    } else {
      elapsed = elapsedSinceStart - lastUpdate;
    }

    lastTickerUpdate = elapsedSinceStart;

    _vehicles.updateAll((_, data) {
      data.elapsed += elapsed;
      data.totalExistTime += elapsed;

      return data;
    });

    int beforeCount = _vehicles.length;
    _vehicles.removeWhere((_, data) => data.elapsed >= data.timeout);
    int afterCount = _vehicles.length;

    if (beforeCount != afterCount) {
      developer.log(
        "${beforeCount - afterCount} vehicles timed out.",
        name: "vehicle_marker_layer.VehicleMarkerLayer",
      );
    }
  }

  LatLng _computePos(_VehicleData data) {
    Position? prev = data.previousPosition?.position;
    Position cur = data.position.position;

    if (prev == null || data.elapsed > moveDuration) {
      return _positionToLatLng(cur);
    }

    // Verify so that t is computed correctly
    assert(!data.elapsed.isNegative);

    double t = data.elapsed.inMicroseconds / moveDuration.inMicroseconds;
    double lat = lerpDouble(prev.latitude, cur.latitude, t)!;
    double lng = lerpDouble(prev.longitude, cur.longitude, t)!;

    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    return MarkerLayer(
      markers: _vehicles.values
          .map(
            (data) => buildVehicleMarker(
              context,
              renderPos: _computePos(data),
              pos: data.position,
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();

    super.dispose();
  }
}

LatLng _positionToLatLng(Position pos) {
  return LatLng(pos.latitude, pos.longitude);
}
