import 'dart:ui';

import '../digitransit.dart';

class DigitransitRoute {
  final GtfsId gtfsId;
  final String? shortName;
  final String? longName;
  final Color? color;
  final DigitransitMode? mode;

  DigitransitRoute({
    required this.gtfsId,
    required this.shortName,
    required this.longName,
    required this.color,
    required this.mode,
  });

  factory DigitransitRoute.parse(Map<String, dynamic> map) {
    final GtfsId gtfsId = GtfsId(map["gtfsId"] as String);

    String? colorHex = map["color"];
    int? color;
    if (colorHex != null) {
      assert(colorHex.length == 6);
      color = int.parse("ff$colorHex", radix: 16);
    }

    final String? mode = map["mode"];

    return DigitransitRoute(
      gtfsId: gtfsId,
      shortName: map["shortName"] as String?,
      longName: map["longName"] as String?,
      color: color != null ? Color(color) : null,
      mode: mode != null ? DigitransitMode(mode) : null,
    );
  }
}
