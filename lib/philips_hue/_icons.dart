// Manually matched by viewing the hue_icons.ttf on https://fontdrop.info/
// with help from https://github.com/arallsopp/hass-hue-icons
import 'package:flutter/widgets.dart';

class _HueIcon extends IconData {
  const _HueIcon(super.codePoint) : super(fontFamily: "HueIcons");
}

class HueIcons {
  static const IconData hue = _HueIcon(0xE039);
  static const IconData bridge = _HueIcon(0xE032);
  static const IconData questionMark = _HueIcon(0xE065);

  static IconData? findArchetype(String archetype) {
    int? codePoint = _archetypeLookup[archetype];
    if (codePoint != null) {
      return _HueIcon(codePoint);
    } else {
      return null;
    }
  }

  static const Map<String, int> _archetypeLookup = {
    "classic_bulb": 0xE017,
    "sultan_bulb": 0xE028,
    "flood_bulb": 0xE01C,
    "spot_bulb": 0xE027,
    "candle_bulb": 0xE015,
    // "luster_bulb": ,
    "pendant_round": 0xE009,
    "pendant_long": 0xE008,
    "ceiling_round": 0xE001,
    "ceiling_square": 0xE002,
    "floor_shade": 0xE006,
    "floor_lantern": 0xE005,
    "table_shade": 0xE00D,
    "recessed_ceiling": 0xE00A,
    "recessed_floor": 0xE00B,
    "single_spot": 0xE00C,
    "double_spot": 0xE004,
    "table_wash": 0xE00E,
    "wall_lantern": 0xE00F,
    "wall_shade": 0xE010,
    // "flexible_lamp": ,
    "ground_spot": 0xE007,
    "wall_spot": 0xE011,
    "plug": 0xE04F,
    "hue_go": 0xE06B,
    "hue_lightstrip": 0xE06E,
    "hue_iris": 0xE06D,
    "hue_bloom": 0xE066,
    "bollard": 0xE000,
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
    "hue_centris": 0xE067,
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
