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

double calculateMarkerSize(
  double minSize,
  double maxSize, {
  required MapController mapController,
  double? zoomOverride,
}) {
  return remapDouble(
    zoomOverride ?? mapController.camera.zoom,
    mapController.camera.minZoom!,
    mapController.camera.maxZoom!,
    minSize,
    maxSize,
  );
}

Marker buildVehicleMarker(
  BuildContext context, {
  required MapController mapController,
  required VehiclePosition pos,
}) {
  final Config config = Config.of(context);
  final stopInfo = StopInfo.of(context);

  double size = calculateMarkerSize(10, 30, mapController: mapController);
  double maxSize = calculateMarkerSize(
    10,
    30,
    mapController: mapController,
    zoomOverride: mapController.camera.maxZoom!,
  );

  LatLng point = LatLng(pos.position.latitude, pos.position.longitude);

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
