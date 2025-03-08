import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/painters/bus_marker_painter.dart';
import 'package:nysse_asemanaytto/digitransit/_models/gtfs_id.dart';
import 'package:nysse_asemanaytto/digitransit/_models/route.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'dart:math' as math;

import 'package:nysse_asemanaytto/main/stopinfo.dart';

class VehicleMarkerLayer extends StatefulWidget {
  const VehicleMarkerLayer({super.key});

  @override
  State<VehicleMarkerLayer> createState() => VehicleMarkerLayerState();
}

class _VehicleData {
  static const Duration defaultTimeout = Duration(seconds: 3);

  Duration elapsed;
  final Duration timeout;

  final VehiclePosition? previousPosition;
  final VehiclePosition position;

  _VehicleData({
    required this.timeout,
    required this.previousPosition,
    required this.position,
  }) : elapsed = Duration.zero;
}

class VehicleMarkerLayerState extends State<VehicleMarkerLayer>
    with SingleTickerProviderStateMixin {
  final Logger _logger = Logger("VehicleMarkerLayer");

  static const Duration moveDuration = Duration(seconds: 1);

  Duration? lastTickerUpdate;

  late Ticker _ticker;
  bool _canStartTicker = false;
  final Map<String, _VehicleData> _vehicles = {};

  @override
  void initState() {
    super.initState();

    // createTicker doesn't stop when the embed is hidden, I'll stop the ticker manually instead
    _ticker = Ticker(_tickerTick);
  }

  void updateVehicle(
    FeedEntity vehicle, {
    Duration timeout = _VehicleData.defaultTimeout,
  }) {
    _startTickerIfPossible();

    _vehicles.update(
      vehicle.id,
      (previous) => _VehicleData(
        timeout: timeout,
        previousPosition: _ticker.isTicking ? previous.position : null,
        position: vehicle.vehicle,
      ),
      ifAbsent: () {
        return _VehicleData(
          timeout: timeout,
          previousPosition: null,
          position: vehicle.vehicle,
        );
      },
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
    _canStartTicker = true;

    if (_vehicles.isNotEmpty) {
      // Start ticker so that we can timeout any vehicles that have stopped updating
      _startTickerIfPossible();
    }
  }

  void _startTickerIfPossible() {
    if (_canStartTicker && !_ticker.isActive) {
      // If there are no more vehicles to render,
      // the ticker will continue ticking until stopUpdate is called.
      _ticker.start();
    }
  }

  void stopUpdate() {
    _canStartTicker = false;
    _ticker.stop();
    lastTickerUpdate = null;
  }

  void _tickerTick(Duration elapsed) {
    // Only update UI state if there are any vehicles to be updated
    if (_vehicles.isNotEmpty) {
      setState(() {
        _updateVehicles(elapsed);
      });
    }
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
      return data;
    });

    int beforeCount = _vehicles.length;
    _vehicles.removeWhere((_, data) => data.elapsed >= data.timeout);
    int afterCount = _vehicles.length;

    if (beforeCount != afterCount && _logger.isLoggable(Level.INFO)) {
      final int diff = beforeCount - afterCount;
      final String msg = "$diff vehicle${diff != 1 ? 's' : ''} timed out.";
      _logger.info(msg);
    }
  }

  LatLng _computePos(_VehicleData data) {
    Position? prev = data.previousPosition?.position;
    Position cur = data.position.position;

    if (prev == null || data.elapsed > moveDuration) {
      return _positionToLatLng(cur);
    }
    // Verify that elapsed is computed correctly
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
            (data) => _buildVehicleMarker(
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

Marker _buildVehicleMarker(
  BuildContext context, {
  required LatLng renderPos,
  required VehiclePosition pos,
}) {
  final Config config = Config.of(context);
  final stopInfo = StopInfo.of(context);

  double size = MapCamera.of(context).getScaleZoom(10);

  // example: 6921_91
  final String vehicleId = pos.vehicle.id;
  // 6921_91 => 6921
  final String vehicleIdHeader = vehicleId.substring(0, vehicleId.indexOf('_'));

  // example: 86921
  final String routeIdFull = pos.trip.routeId;
  assert(routeIdFull.endsWith(vehicleIdHeader));
  // ^^ No idea why routeId has this weird ass suffix
  // 86921 => 8
  final String routeId =
      routeIdFull.substring(0, routeIdFull.length - vehicleIdHeader.length);

  final GtfsId routeGtfsId = GtfsId.combine(config.stopId.feedId, routeId);

  final DigitransitRoute? route = stopInfo?.routes[routeGtfsId];

  const double borderWidth = 3;

  return Marker(
    point: renderPos,
    width: size,
    height: size,
    child: CustomPaint(
      painter: BusMarkerPainter(
        // deg2rad = math.pi / 180
        bearing: pos.position.bearing * (math.pi / 180),
        borderColor: route?.color ?? Colors.grey,
        borderWidth: borderWidth,
        lineNumber: route?.shortName ?? "??",
        lineNumberMinSize: 12 * Layout.of(context).logicalPixelSize,
      ),
    ),
  );
}
