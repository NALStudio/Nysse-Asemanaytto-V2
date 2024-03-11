import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
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
    retinaMode: true,
    tileProvider: CancellableNetworkTileProvider(silenceExceptions: true),
    userAgentPackageName: RequestInfo.packageName,
  );
}
