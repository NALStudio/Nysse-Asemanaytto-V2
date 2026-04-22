// Manually matched by viewing the hue_icons.ttf on https://fontdrop.info/
// with help from https://github.com/arallsopp/hass-hue-icons
import 'package:flutter/widgets.dart';

class HueIcons {
  static const IconData hue = IconData(0xE039, fontFamily: "HueIcons");
  static const IconData bridge = IconData(0xE032, fontFamily: "HueIcons");
  static const IconData questionMark = IconData(0xE065, fontFamily: "HueIcons");

  static IconData? findArchetype(String archetype) {
    return _archetypeLookup[archetype];
  }

  static const Map<String, IconData> _archetypeLookup = {
    "classic_bulb": IconData(0xE017, fontFamily: "HueIcons"),
    "sultan_bulb": IconData(0xE028, fontFamily: "HueIcons"),
    "flood_bulb": IconData(0xE01C, fontFamily: "HueIcons"),
    "spot_bulb": IconData(0xE027, fontFamily: "HueIcons"),
    "candle_bulb": IconData(0xE015, fontFamily: "HueIcons"),
    // "luster_bulb": ,
    "pendant_round": IconData(0xE009, fontFamily: "HueIcons"),
    "pendant_long": IconData(0xE008, fontFamily: "HueIcons"),
    "ceiling_round": IconData(0xE001, fontFamily: "HueIcons"),
    "ceiling_square": IconData(0xE002, fontFamily: "HueIcons"),
    "floor_shade": IconData(0xE006, fontFamily: "HueIcons"),
    "floor_lantern": IconData(0xE005, fontFamily: "HueIcons"),
    "table_shade": IconData(0xE00D, fontFamily: "HueIcons"),
    "recessed_ceiling": IconData(0xE00A, fontFamily: "HueIcons"),
    "recessed_floor": IconData(0xE00B, fontFamily: "HueIcons"),
    "single_spot": IconData(0xE00C, fontFamily: "HueIcons"),
    "double_spot": IconData(0xE004, fontFamily: "HueIcons"),
    "table_wash": IconData(0xE00E, fontFamily: "HueIcons"),
    "wall_lantern": IconData(0xE00F, fontFamily: "HueIcons"),
    "wall_shade": IconData(0xE010, fontFamily: "HueIcons"),
    // "flexible_lamp": ,
    "ground_spot": IconData(0xE007, fontFamily: "HueIcons"),
    "wall_spot": IconData(0xE011, fontFamily: "HueIcons"),
    "plug": IconData(0xE04F, fontFamily: "HueIcons"),
    "hue_go": IconData(0xE06B, fontFamily: "HueIcons"),
    "hue_lightstrip": IconData(0xE06E, fontFamily: "HueIcons"),
    "hue_iris": IconData(0xE06D, fontFamily: "HueIcons"),
    "hue_bloom": IconData(0xE066, fontFamily: "HueIcons"),
    "bollard": IconData(0xE000, fontFamily: "HueIcons"),
    // "wall_washer": ,
    // "hue_play": 0xE06C ,
    // "vintage_bulb": ,
    // "vintage_candle_bulb": ,
    // "ellipse_bulb": ,
    // "triangle_bulb": ,
    // "small_globe_bulb": ,
    // "large_globe_bulb": ,
    // "edison_bulb": ,
    // "christmas_tree": ,
    // "string_light": ,
    "hue_centris": IconData(0xE067, fontFamily: "HueIcons"),
    // "hue_lightstrip_tv": ,
    // "hue_lightstrip_pc": ,
    // "hue_tube": ,
    // "hue_signe": ,
    // "pendant_spot": ,
    // "ceiling_horizontal": ,
    // "ceiling_tube": ,
    // "up_and_down": ,
    // "up_and_down_up": ,
    // "up_and_down_down": ,
    // "hue_floodlight_camera": ,
  };
}
