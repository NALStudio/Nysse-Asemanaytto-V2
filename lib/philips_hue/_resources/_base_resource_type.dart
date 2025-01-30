import 'dart:collection';

import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';

enum HueResourceType {
  light("light"),
  entertainmentConfiguration("entertainment_configuration");

  const HueResourceType(this._type);

  final String _type;

  String get name => _type;

  static final Map<String, HueResourceType> _fromString = UnmodifiableMapView(
    Map.fromEntries(HueResourceType.values.map((e) => MapEntry(e.name, e))),
  );

  static const Map<HueResourceType, HueResource Function(Map)> _jConst = {
    light: HueLight.fromJson,
    entertainmentConfiguration: HueEntertainmentConfiguration.fromJson,
  };

  static HueResourceType? fromString(String s) => _fromString[s];

  HueResource convertJson(Map json) {
    HueResource Function(Map)? converter = _jConst[this];
    if (converter == null) {
      throw UnimplementedError("This type cannot be converted yet.");
    }
    return converter(json);
  }
}
