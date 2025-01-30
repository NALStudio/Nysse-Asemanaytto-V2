import 'dart:math' as math;
import 'dart:ui';

import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';

/// An immutable version of HueXY
class _XY {
  final double x;
  final double y;

  const _XY(this.x, this.y);
  _XY.cast(HueXY xy)
      : x = xy.x,
        y = xy.y;
}

// Adapted from iOS SDK extract
// https://developers.meethue.com/develop/application-design-guidance/color-conversion-formulas-rgb-to-xy-and-back
class HueColorConverter {
  static Color colorFromXY(HueXY xy) => _colorFromXY(_XY.cast(xy));

  static Color _colorFromXY(_XY xy) {
    // sRGB primaries
    const List<_XY> colorPoints = [
      _XY(0.6400, 0.3300),
      _XY(0.3000, 0.6000),
      _XY(0.1500, 0.0600),
    ];

    // Actually in reach of sRGB, not lamps
    // I just left the variable names from Philips Hue implementation as they were
    bool inReachOfLamps = _checkPointInLampsReach(xy, colorPoints);

    if (!inReachOfLamps) {
      //It seems the colour is out of reach
      //let's find the closest colour we can produce with our lamp and send this XY value out.

      //Find the closest point on each line in the triangle.
      _XY pAB = _getClosestPointToPoints(colorPoints[0], colorPoints[1], xy);
      _XY pAC = _getClosestPointToPoints(colorPoints[2], colorPoints[0], xy);
      _XY pBC = _getClosestPointToPoints(colorPoints[1], colorPoints[2], xy);

      // Get *SQUARED* distances per point and see which point is closer to our Point.
      // NOTE: This is a deviation from the original Philips Hue implementation for optimization reasons
      double dAB = _getSquaredDistanceBetweenTwoPoints(xy, pAB);
      double dAC = _getSquaredDistanceBetweenTwoPoints(xy, pAC);
      double dBC = _getSquaredDistanceBetweenTwoPoints(xy, pBC);

      double lowest = dAB;
      _XY closestPoint = pAB;

      if (dAC < lowest) {
        lowest = dAC;
        closestPoint = pAC;
      }
      if (dBC < lowest) {
        lowest = dBC;
        closestPoint = pBC;
      }

      //Change the xy value to a value which is within the reach of the lamp.
      xy = closestPoint;
    }

    double x = xy.x;
    double y = xy.y;
    double z = 1.0 - x - y;

    double Y = 1.0;
    double X = (Y / y) * x;
    double Z = (Y / y) * z;

    // sRGB D65 conversion
    double r = X * 1.656492 - Y * 0.354851 - Z * 0.255038;
    double g = -X * 0.707196 + Y * 1.655397 + Z * 0.036152;
    double b = X * 0.051713 - Y * 0.121364 + Z * 1.011530;

    if (r > b && r > g && r > 1.0) {
      // red is too big
      g = g / r;
      b = b / r;
      r = 1.0;
    } else if (g > b && g > r && g > 1.0) {
      // green is too big
      r = r / g;
      b = b / g;
      g = 1.0;
    } else if (b > r && b > g && b > 1.0) {
      // blue is too big
      r = r / b;
      g = g / b;
      b = 1.0;
    }

    // Apply gamma correction
    r = r <= 0.0031308
        ? 12.92 * r
        : (1.0 + 0.055) * math.pow(r, (1.0 / 2.4)) - 0.055;
    g = g <= 0.0031308
        ? 12.92 * g
        : (1.0 + 0.055) * math.pow(g, (1.0 / 2.4)) - 0.055;
    b = b <= 0.0031308
        ? 12.92 * b
        : (1.0 + 0.055) * math.pow(b, (1.0 / 2.4)) - 0.055;

    if (r > b && r > g) {
      // red is biggest
      if (r > 1.0) {
        g = g / r;
        b = b / r;
        r = 1.0;
      }
    } else if (g > b && g > r) {
      // green is biggest
      if (g > 1.0) {
        r = r / g;
        b = b / g;
        g = 1.0;
      }
    } else if (b > r && b > g) {
      // blue is biggest
      if (b > 1.0) {
        r = r / b;
        g = g / b;
        b = 1.0;
      }
    }

    return Color.from(
      red: r,
      green: g,
      blue: b,
      alpha: 1.0,
      colorSpace: ColorSpace.sRGB,
    );
  }

  static double _crossProduct(_XY p1, _XY p2) {
    return (p1.x * p2.y - p1.y * p2.x);
  }

  static _XY _getClosestPointToPoints(_XY a, _XY b, _XY p) {
    _XY ap = _XY(p.x - a.x, p.y - a.y);
    _XY ab = _XY(b.x - a.x, b.y - a.y);
    double ab2 = ab.x * ab.x + ab.y * ab.y;
    double apab = ap.x * ab.x + ap.y * ab.y;

    double t = apab / ab2;

    if (t < 0.0) {
      t = 0.0;
    } else if (t > 1.0) {
      t = 1.0;
    }

    return _XY(a.x + ab.x * t, a.y + ab.y * t);
  }

  static double _getSquaredDistanceBetweenTwoPoints(_XY a, _XY b) {
    double dx = a.x - b.x;
    double dy = a.y - b.y;
    return dx * dx + dy * dy;
  }

  static bool _checkPointInLampsReach(_XY p, List<_XY> colorPoints) {
    _XY red = colorPoints[0];
    _XY green = colorPoints[1];
    _XY blue = colorPoints[2];

    _XY v1 = _XY(green.x - red.x, green.y - red.y);
    _XY v2 = _XY(blue.x - red.x, blue.y - red.y);

    _XY q = _XY(p.x - red.x, p.y - red.y);

    double v1v2cross = _crossProduct(v1, v2);

    double s = _crossProduct(q, v2) / v1v2cross;
    double t = _crossProduct(v1, q) / v1v2cross;

    return (s >= 0.0) && (t >= 0.0) && (s + t <= 1.0);
  }
}
