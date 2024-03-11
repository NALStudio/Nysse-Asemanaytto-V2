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
        length
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
    final String routeGtfsId = data["route"]["gtfsId"];

    return DigitransitTripRouteQuery(
      routeGtfsId: GtfsId(routeGtfsId),
      pattern: DigitransitPattern._parse(data["pattern"]),
    );
  }
}

class DigitransitPattern {
  final List<DigitransitPatternStop> stops;
  final DigitransitPatternGeometry patternGeometry;

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
      patternGeometry: DigitransitPatternGeometry._parse(
        map["patternGeometry"],
      ),
    );
  }
}

/// pattern encoded in Google polyline format
class DigitransitPatternGeometry {
  final int length;
  final String points;

  DigitransitPatternGeometry({required this.length, required this.points});

  static DigitransitPatternGeometry _parse(Map<String, dynamic> map) {
    return DigitransitPatternGeometry(
      length: map["length"],
      points: map["points"],
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
