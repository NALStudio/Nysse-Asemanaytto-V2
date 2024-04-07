import 'dart:collection';

import 'package:flutter/services.dart';
import 'dart:developer' as developer;

Map<int, String>? _weatherSymbols;
Future<void>? _loadFuture;
Future<Map<int, String>> loadWeatherSymbols(AssetBundle bundle) async {
  if (_weatherSymbols == null) {
    _loadFuture ??= _loadWeatherSymbols(bundle);
    await _loadFuture;
  }

  return UnmodifiableMapView(_weatherSymbols!);
}

Future<void> _loadWeatherSymbols(AssetBundle bundle) async {
  developer.log(
    "Loading weather symbols...",
    name: "_weather_embed._weather_symbol_provider",
  );

  AssetManifest manifest = await AssetManifest.loadFromAssetBundle(bundle);

  Map<int, String> map = {};
  for (String asset in manifest.listAssets()) {
    const String prefix = "assets/images/fmi_weather_symbols/";
    const String suffix = ".svg";

    if (!asset.startsWith(prefix)) continue;
    assert(asset.endsWith(suffix));

    String symbolId = asset.substring(
      prefix.length,
      asset.length - suffix.length,
    );

    map[int.parse(symbolId)] = asset;
  }

  _weatherSymbols = map;
}
