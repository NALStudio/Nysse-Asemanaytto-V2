import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class StopMarkerLayer extends StatelessWidget {
  final List<LatLng> stops;
  final double? sizeOverride;

  const StopMarkerLayer({super.key, required this.stops, this.sizeOverride});

  factory StopMarkerLayer.fromPattern(
    DigitransitPattern pattern, {
    double? sizeOverride,
  }) {
    return StopMarkerLayer(
      stops: pattern.stops
          .map((p) => LatLng(p.lat, p.lon))
          .toList(growable: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = stops
        .map((e) => _buildStopMarker(context, point: e))
        .toList(growable: false);

    return MarkerLayer(markers: markers);
  }
}

Marker _buildStopMarker(
  BuildContext context, {
  required LatLng point,
  double? sizeOverride,
}) {
  double size = sizeOverride ?? MapCamera.of(context).getScaleZoom(10);

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
