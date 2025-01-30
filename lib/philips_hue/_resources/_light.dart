import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';

class HueLightMetadata implements HueBase {
  String name;
  String archetype;
  int? fixedMired;
  String function;

  HueLightMetadata.fromJson(Map json)
      : name = json["name"],
        archetype = json["archetype"],
        fixedMired = json["fixed_mired"],
        function = json["function"];

  @override
  void update(Map? json) {
    if (json == null) return;

    name = json.containsKey("name") ? json["name"] : name;
    archetype = json.containsKey("archetype") ? json["archetype"] : archetype;
    fixedMired =
        json.containsKey("fixed_mired") ? json["fixed_mired"] : fixedMired;
    function = json.containsKey("function") ? json["function"] : function;
  }
}

class HueLightDimming implements HueBase {
  /// Brightness percentage. value cannot be 0, writing 0 changes it to lowest possible brightness
  double brightness;

  /// Percentage of the maximum lumen the device outputs on minimum brightness
  double? minDimLevel;

  HueLightDimming.fromJson(Map json)
      : brightness = json["brightness"],
        minDimLevel = json["min_dim_level"];

  @override
  void update(Map? json) {
    if (json == null) return;

    brightness =
        json.containsKey("brightness") ? json["brightness"] : brightness;

    minDimLevel =
        json.containsKey("min_dim_level") ? json["min_dim_level"] : minDimLevel;
  }
}

class HueLightGamut implements HueBase {
  HueXY red;
  HueXY green;
  HueXY blue;

  HueLightGamut.fromJson(Map json)
      : red = HueXY.fromJson(json["red"]),
        green = HueXY.fromJson(json["green"]),
        blue = HueXY.fromJson(json["blue"]);

  @override
  void update(Map? json) {
    if (json == null) return;

    red.update(json["red"]);
    green.update(json["green"]);
    blue.update(json["blue"]);
  }
}

class HueLightColor implements HueBase {
  HueXY xy;
  HueLightGamut? gamut;
  String gamutType;

  HueLightColor.fromJson(Map json)
      : xy = HueXY.fromJson(json["xy"]),
        gamut = HueBase.fromJsonNullable(HueLightGamut.fromJson, json["gamut"]),
        gamutType = json["gamut_type"];

  @override
  void update(Map? json) {
    if (json == null) return;

    xy.update(json["xy"]);
    gamut = HueBase.updateNullable(gamut, HueLightGamut.fromJson, json);

    gamutType = json.containsKey("gamut_type") ? json["gamut_type"] : gamutType;
  }
}

class HueLight extends HueResource {
  /// Owner of the service, in case the owner service is deleted, the service also gets deleted
  HueOwner owner;

  /// additional metadata including a user given name
  HueLightMetadata metadata;

  bool isOn;
  HueLightDimming dimming;
  HueLightColor color;

  HueLight.fromJson(super.json)
      : owner = HueOwner.fromJson(json["owner"]),
        metadata = HueLightMetadata.fromJson(json["metadata"]),
        isOn = json["on"]["on"],
        dimming = HueLightDimming.fromJson(json["dimming"]),
        color = HueLightColor.fromJson(json["color"]),
        super.fromJson();

  @override
  void update(Map? json) {
    super.update(json);

    if (json == null) return;

    owner.update(json["owner"]);
    metadata.update(json["metadata"]);

    if (json.containsKey("on")) {
      Map on = json["on"];
      if (on.containsKey("on")) {
        isOn = on["on"];
      }
    }

    dimming.update(json["dimming"]);
    color.update(json["color"]);
  }
}
