import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/_enums.dart';
import 'package:nysse_asemanaytto/digitransit/_models/gtfs_id.dart';

class DigitransitStopInfoQuery {
  static const String query = """
query getStopInfo(\$stopId: String!)
{
  stop(id: \$stopId) {
    name
    vehicleMode
    lat
    lon
    patterns {
      code
      stops {
        gtfsId
        lat
        lon
      }
      patternGeometry {
        length
        points
      }
      route {
        gtfsId
      }
    }
    routes {
      gtfsId
      shortName
      longName
      color
    }
  }
}
""";
  final String name;
  final DigitransitMode? vehicleMode;
  final double lat;
  final double lon;
  final Map<String, DigitransitStopInfoPattern> patterns;
  final Map<GtfsId, DigitransitStopInfoRoute> routes;

  const DigitransitStopInfoQuery({
    required this.name,
    required this.vehicleMode,
    required this.lat,
    required this.lon,
    required this.patterns,
    required this.routes,
  });

  static DigitransitStopInfoQuery? parse(Map<String, dynamic>? data) {
    final Map<String, dynamic>? stop = data?["stop"];
    if (stop == null) return null;

    final String? vehicleMode = stop["vehicleMode"];
    return DigitransitStopInfoQuery(
      name: stop["name"],
      vehicleMode: vehicleMode != null ? DigitransitMode(vehicleMode) : null,
      lat: stop["lat"],
      lon: stop["lon"],
      patterns: UnmodifiableMapView(parsePatterns(stop["patterns"])),
      routes: UnmodifiableMapView(parseRoutes(stop["routes"])),
    );
  }

  static Map<String, DigitransitStopInfoPattern> parsePatterns(
      List<dynamic> patterns) {
    return Map.fromEntries(patterns.map((e) {
      final Map<String, dynamic> map = e;
      String code = map["code"];
      return MapEntry(code, DigitransitStopInfoPattern._parse(map));
    }));
  }

  static Map<GtfsId, DigitransitStopInfoRoute> parseRoutes(
    List<dynamic> routes,
  ) {
    return Map.fromEntries(
      routes.map((e) {
        final Map<String, dynamic> map = e;
        GtfsId gtfsId = GtfsId(map["gtfsId"] as String);

        return MapEntry(gtfsId, DigitransitStopInfoRoute._parse(map));
      }),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DigitransitStopInfoQuery &&
        name == other.name &&
        vehicleMode == other.vehicleMode &&
        lat == other.lat &&
        lon == other.lon;
  }

  @override
  int get hashCode => Object.hash(name, vehicleMode, lat, lon);
}

class DigitransitStopInfoRoute {
  final String shortName;
  final String longName;
  final Color color;

  DigitransitStopInfoRoute({
    required this.shortName,
    required this.longName,
    required this.color,
  });

  static DigitransitStopInfoRoute _parse(Map<String, dynamic> map) {
    String colorHex = map["color"];
    assert(colorHex.length == 6);
    int color = int.parse("ff$colorHex", radix: 16);

    return DigitransitStopInfoRoute(
      shortName: map["shortName"] as String,
      longName: map["longName"] as String,
      color: Color(color),
    );
  }
}

class DigitransitStopInfoPattern {
  final List<DigitransitStopInfoPatternStop> stops;
  final DigitransitPatternGeometry patternGeometry;
  final GtfsId routeGtfsId;

  DigitransitStopInfoPattern({
    required this.stops,
    required this.patternGeometry,
    required this.routeGtfsId,
  });

  static DigitransitStopInfoPattern _parse(Map<String, dynamic> map) {
    final List<dynamic> stops = map["stops"];
    final Map<String, dynamic> route = map["route"];
    return DigitransitStopInfoPattern(
      stops: UnmodifiableListView(
        stops
            .map((e) => DigitransitStopInfoPatternStop._parse(e))
            .toList(growable: false),
      ),
      patternGeometry: DigitransitPatternGeometry._parse(
        map["patternGeometry"],
      ),
      routeGtfsId: GtfsId(route["gtfsId"] as String),
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

class DigitransitStopInfoPatternStop {
  final GtfsId gtfsId;
  final double lat;
  final double lon;

  DigitransitStopInfoPatternStop({
    required this.gtfsId,
    required this.lat,
    required this.lon,
  });

  static DigitransitStopInfoPatternStop _parse(Map<String, dynamic> map) {
    final String gtfsId = map["gtfsId"];
    return DigitransitStopInfoPatternStop(
      gtfsId: GtfsId(gtfsId),
      lat: map["lat"],
      lon: map["lon"],
    );
  }
}
