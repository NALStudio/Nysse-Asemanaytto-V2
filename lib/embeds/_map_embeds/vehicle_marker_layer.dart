import 'dart:collection';
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
  /// Whether this data should be deleted at the end of frame.
  /// This should be true from the start of the frame until the first received update.
  bool unsafe;

  Duration elapsedTowardsNextPos;
  VehiclePosition latest;

  Position currentPosition;
  final Queue<Position> nextPositions;

  _VehicleData({
    required this.latest,
  })  : currentPosition = latest.position,
        nextPositions = Queue(),
        unsafe = false,
        elapsedTowardsNextPos = Duration.zero;
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

  void updateVehicle(VehiclePosition pos) {
    _startTickerIfPossible();

    _vehicles.update(
      pos.vehicle.id,
      (existing) {
        existing.unsafe = false;
        existing.latest = pos;

        if (_ticker.isTicking) {
          // Only add the new position if it doesn't match the previous.
          // We might get double updates if both lines and vehicles embed
          // have subscribed to the same vehicle on different events.
          if (existing.nextPositions.lastOrNull != pos.position) {
            existing.nextPositions.add(pos.position);
          }
        } else {
          existing.nextPositions.clear();
          existing.elapsedTowardsNextPos = Duration.zero;
          existing.currentPosition = pos.position;
        }

        return existing;
      },
      ifAbsent: () {
        return _VehicleData(latest: pos);
      },
    );
  }

  void clearVehicleData() {
    _vehicles.clear();
  }

  /// Only include values that satisfy the filter. All values are returned if filter is null.
  Iterable<LatLng> getNonInterpolatedVehiclePositions({
    bool Function(VehiclePosition pos)? filter,
  }) {
    Iterable<_VehicleData> data;
    if (filter == null) {
      data = _vehicles.values;
    } else {
      data = _vehicles.values.where((v) => filter(v.latest));
    }

    return data.map((v) => _positionToLatLng(v.latest.position));
  }

  void onEnable() {
    _markAllVehiclesAsUnsafe();

    _canStartTicker = true;
    if (_vehicles.isNotEmpty) {
      // Vehicle positions have updated during the time this embed was disabled,
      // update them as soon as possible
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

  void onDisable() {
    _canStartTicker = false;
    _ticker.stop();
    lastTickerUpdate = null;

    // Timeout all vehicles that didn't receive an update during the time this embed was enabled
    _removeUnsafeVehicles();

    // We do not do the same thing for the duration the embed is disabled
    // since the embed is disabled for quite a long time and thus the likelihood
    // of this happening in reverse is pretty low
  }

  void _markAllVehiclesAsUnsafe() {
    _vehicles.updateAll((_, data) {
      data.unsafe = true;
      return data;
    });
  }

  void _removeUnsafeVehicles() {
    int beforeCount = _vehicles.length;
    _vehicles.removeWhere((_, data) => data.unsafe);
    int afterCount = _vehicles.length;

    if (beforeCount != afterCount && _logger.isLoggable(Level.INFO)) {
      final int diff = beforeCount - afterCount;
      final String msg = "$diff vehicle${diff != 1 ? 's' : ''} timed out.";
      _logger.info(msg);
    }
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
      elapsed = Duration.zero;
    } else {
      elapsed = elapsedSinceStart - lastUpdate;
    }
    lastTickerUpdate = elapsedSinceStart;

    _vehicles.updateAll((_, data) {
      if (data.nextPositions.isNotEmpty) {
        data.elapsedTowardsNextPos += elapsed;
        if (data.elapsedTowardsNextPos > moveDuration) {
          // Set as 0, since we don't want to leave a partial state to the next position,
          // which might have a long delay before coming
          data.elapsedTowardsNextPos = Duration.zero;
          data.currentPosition = data.nextPositions.removeFirst();
        }
      }

      return data;
    });
  }

  LatLng _computePos(_VehicleData data) {
    Duration elapsed = data.elapsedTowardsNextPos;

    Position current = data.currentPosition;
    Position? next = data.nextPositions.firstOrNull;

    // This should rarely be true
    if (elapsed > moveDuration) {
      return _positionToLatLng(next ?? current);
    }

    if (next == null) {
      return _positionToLatLng(current);
    }

    // Verify that elapsed is computed correctly
    assert(!elapsed.isNegative);

    double t = elapsed.inMicroseconds / moveDuration.inMicroseconds;
    double lat = lerpDouble(current.latitude, next.latitude, t)!;
    double lng = lerpDouble(current.longitude, next.longitude, t)!;

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
              data: data.latest,
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
  required VehiclePosition data,
}) {
  final Config config = Config.of(context);
  final stopInfo = StopInfo.of(context);

  double size = MapCamera.of(context).getScaleZoom(10);

  // example: 6921_91
  final String vehicleId = data.vehicle.id;

  // 6921_91 => 6921
  int vehicleIdHeaderLength = vehicleId.indexOf('_');

  // example: 86921
  final String routeIdFull = data.trip.routeId;
  assert(routeIdFull.endsWith(vehicleId.substring(0, vehicleIdHeaderLength)));
  // ^^ No idea why routeId has this weird ass suffix
  // 86921 => 8
  final String routeId =
      routeIdFull.substring(0, routeIdFull.length - vehicleIdHeaderLength);

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
        bearing: data.position.bearing * (math.pi / 180),
        borderColor: route?.color ?? Colors.grey,
        borderWidth: borderWidth,
        lineNumber: route?.shortName ?? "??",
        lineNumberMinSize: 12 * Layout.of(context).logicalPixelSize,
      ),
    ),
  );
}
