import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/core/painters/bus_marker_painter.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/digitransit/_models/gtfs_id.dart';
import 'package:nysse_asemanaytto/digitransit/_queries/stop_info.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'dart:math' as math;

enum MapEmbedTileProvider {
  digitransit,
  digitransitRetina,
  openStreetMap,
  solidWhite,
}

Widget buildMapEmbedTileProvider(
    BuildContext context, MapEmbedTileProvider provider) {
  switch (provider) {
    case MapEmbedTileProvider.digitransit:
      return _buildDigitransit(context, retina: false);
    case MapEmbedTileProvider.digitransitRetina:
      return _buildDigitransit(context, retina: true);
    case MapEmbedTileProvider.openStreetMap:
      return TileLayer(
        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        tileProvider: CancellableNetworkTileProvider(silenceExceptions: true),
        userAgentPackageName: RequestInfo.packageName,
      );
    case MapEmbedTileProvider.solidWhite:
      return const SizedBox.expand(child: ColoredBox(color: Colors.white));
  }
}

TileLayer _buildDigitransit(BuildContext context, {required bool retina}) {
  return TileLayer(
    urlTemplate:
        "https://cdn.digitransit.fi/map/v2/hsl-map-256/{z}/{x}/{y}{r}.png?digitransit-subscription-key=${Config.of(context).digitransitSubscriptionKey!}",
    retinaMode: true,
    tileProvider: CancellableNetworkTileProvider(silenceExceptions: true),
    userAgentPackageName: RequestInfo.packageName,
  );
}

class MapErrorLayer extends StatelessWidget {
  final ErrorWidget error;

  const MapErrorLayer({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController.of(context);

    return Positioned(
      left: mapController.camera.nonRotatedSize.x / 1.5,
      bottom: mapController.camera.nonRotatedSize.y / 1.5,
      right: 0,
      top: 0,
      child: error,
    );
  }
}

double calculateScaledSize({
  required double minSize,
  required double maxSize,
  required MapCamera camera,
  double? zoomOverride,
}) {
  return remapDouble(
    zoomOverride ?? camera.zoom,
    camera.minZoom!,
    camera.maxZoom!,
    minSize,
    maxSize,
  );
}

Marker buildVehicleMarker(
  BuildContext context, {
  required MapController mapController,
  required VehiclePosition pos,
  double? zoomOverride,
}) {
  final Config config = Config.of(context);
  final stopInfo = StopInfo.of(context);

  LatLng point = LatLng(pos.position.latitude, pos.position.longitude);

  double size = calculateScaledSize(
    minSize: 10,
    maxSize: 30,
    camera: mapController.camera,
  );
  double maxSize = calculateScaledSize(
    minSize: 10,
    maxSize: 30,
    camera: mapController.camera,
    zoomOverride: mapController.camera.maxZoom!,
  );

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

CircleMarker buildStopMarker(
  LatLng point, {
  required MapCamera camera,
  double? zoomOverride,
}) {
  double size = calculateScaledSize(
    minSize: 10,
    maxSize: 30,
    camera: camera,
    zoomOverride: zoomOverride,
  );
  return CircleMarker(
    point: point,
    radius: size / 2,
    color: Colors.white,
    borderColor: Colors.black,
    borderStrokeWidth: 3,
  );
}

const LatLng kDefaultMapPosition = LatLng(61.497742570, 23.761290078);
