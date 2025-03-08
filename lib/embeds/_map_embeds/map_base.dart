import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';

enum MapEmbedTiles {
  digitransit256,
  digitransit512,
  digitransitEnglish512,
  digitransitNoText512,
  openStreetMap,
  solidWhite,
}

Widget buildMapEmbedTileProvider(
  BuildContext context, {
  required TileProvider tileProvider,
  required MapEmbedTiles tileStyle,
}) {
  switch (tileStyle) {
    case MapEmbedTiles.digitransit256:
      return _buildDigitransit(
        context,
        tileSource: "hsl-map-256",
        tileProvider: tileProvider,
        retina: RetinaMode.isHighDensity(context),
        size512: false,
      );
    case MapEmbedTiles.digitransit512:
      return _buildDigitransit(
        context,
        tileSource: "hsl-map",
        tileProvider: tileProvider,
        retina: true, // retina is recommended for 512px
        size512: true,
      );
    case MapEmbedTiles.digitransitEnglish512:
      return _buildDigitransit(
        context,
        tileSource: "hsl-map-en",
        tileProvider: tileProvider,
        retina: true,
        size512: true,
      );
    case MapEmbedTiles.digitransitNoText512:
      return _buildDigitransit(
        context,
        tileSource: "hsl-map-no-text",
        tileProvider: tileProvider,
        retina: true,
        size512: true,
      );
    case MapEmbedTiles.openStreetMap:
      return _buildTileLayer(
        tileProvider: tileProvider,
        urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
        retina: false,
      );
    case MapEmbedTiles.solidWhite:
      return const SizedBox.expand(child: ColoredBox(color: Colors.white));
  }
}

TileLayer _buildDigitransit(
  BuildContext context, {
  required String tileSource,
  required TileProvider tileProvider,
  required bool retina,
  required bool size512,
}) {
  return _buildTileLayer(
    tileProvider: tileProvider,
    urlTemplate:
        "https://cdn.digitransit.fi/map/v2/$tileSource/{z}/{x}/{y}{r}.png?digitransit-subscription-key=${Config.of(context).digitransitSubscriptionKey!}",
    retina: retina,
    size512: size512,
  );
}

/// [performance] controls whether the map should choose to render at worse quality for faster results.
TileLayer _buildTileLayer({
  required TileProvider tileProvider,
  required String urlTemplate,
  required bool retina,
  bool performance = true,
  bool size512 = false,
}) {
  return TileLayer(
    urlTemplate: urlTemplate,
    retinaMode: retina,
    tileProvider: tileProvider,
    userAgentPackageName: RequestInfo.packageName,
    tileDimension: size512 ? 512 : 256,
    zoomOffset: size512 ? -1 : 0,
    panBuffer: performance ? 0 : 1,
    keepBuffer: performance ? 0 : 2,
  );
}

class MapErrorLayer extends StatelessWidget {
  final ErrorWidget error;

  const MapErrorLayer({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = MapController.of(context);

    return Positioned(
      top: 0,
      right: 0,
      width: mapController.camera.nonRotatedSize.width / 1.5,
      height: mapController.camera.nonRotatedSize.height / 1.5,
      child: error,
    );
  }
}

const LatLng kDefaultMapPosition = LatLng(61.497742570, 23.761290078);
