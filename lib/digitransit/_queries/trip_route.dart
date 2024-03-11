import 'dart:collection';

import 'package:nysse_asemanaytto/digitransit/_models/gtfs_id.dart';

class DigitransitTripRouteQuery {
  static const String query = """
query getTripRoute(\$tripId: String!)
{
  trip(id: \$tripId) {
    route {
      gtfsId
    }
    pattern {
      stops {
        lat
        lon
      }
      patternGeometry {
        points
      }
    }
  }
}
""";

  final GtfsId routeGtfsId;
  final DigitransitPattern pattern;

  DigitransitTripRouteQuery({
    required this.routeGtfsId,
    required this.pattern,
  });

  static DigitransitTripRouteQuery parse(Map<String, dynamic> data) {
    final Map<String, dynamic> map = data["trip"];

    final String routeGtfsId = map["route"]["gtfsId"];

    return DigitransitTripRouteQuery(
      routeGtfsId: GtfsId(routeGtfsId),
      pattern: DigitransitPattern._parse(map["pattern"]),
    );
  }
}

class DigitransitPattern {
  final List<DigitransitPatternStop> stops;

  /// List of coordinates in a Google encoded polyline format
  final String? patternGeometry;

  DigitransitPattern({
    required this.stops,
    required this.patternGeometry,
  });

  static DigitransitPattern _parse(Map<String, dynamic> map) {
    final List<dynamic> stops = map["stops"];
    return DigitransitPattern(
      stops: UnmodifiableListView(
        stops
            .map((e) => DigitransitPatternStop._parse(e))
            .toList(growable: false),
      ),
      patternGeometry: map["patternGeometry"]?["points"] as String?,
    );
  }
}

class DigitransitPatternStop {
  final double lat;
  final double lon;

  DigitransitPatternStop({
    required this.lat,
    required this.lon,
  });

  static DigitransitPatternStop _parse(Map<String, dynamic> map) {
    return DigitransitPatternStop(
      lat: map["lat"],
      lon: map["lon"],
    );
  }
}
