import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';

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
    retinaMode: retina,
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
      top: 0,
      right: 0,
      width: mapController.camera.nonRotatedSize.x / 2.5,
      height: mapController.camera.nonRotatedSize.y / 2.5,
      child: error,
    );
  }
}

const LatLng kDefaultMapPosition = LatLng(61.497742570, 23.761290078);
