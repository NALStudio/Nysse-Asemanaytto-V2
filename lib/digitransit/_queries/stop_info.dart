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
    routes {
      gtfsId
      shortName
      color
    }
  }
}
""";
  final String name;
  final DigitransitMode? vehicleMode;
  final double lat;
  final double lon;
  final Map<GtfsId, DigitransitStopInfoRoute> routes;

  const DigitransitStopInfoQuery({
    required this.name,
    required this.vehicleMode,
    required this.lat,
    required this.lon,
    required this.routes,
  });

  static DigitransitStopInfoQuery? parse(Map<String, dynamic>? data) {
    final Map<String, dynamic>? stop = data?["stop"];
    if (stop == null) return null;

    final List<dynamic> routes = stop["routes"];
    final Map<GtfsId, DigitransitStopInfoRoute> parsedRoutes = Map.fromEntries(
      routes.map((e) {
        final Map<String, dynamic> map = e;
        GtfsId gtfsId = GtfsId(map["gtfsId"] as String);

        String colorHex = map["color"];
        assert(colorHex.length == 6);
        int color = int.parse("ff$colorHex", radix: 16);
        return MapEntry(
          gtfsId,
          DigitransitStopInfoRoute(
            shortName: map["shortName"] as String,
            color: Color(color),
          ),
        );
      }),
    );

    final String? vehicleMode = stop["vehicleMode"];
    return DigitransitStopInfoQuery(
      name: stop["name"],
      vehicleMode: vehicleMode != null ? DigitransitMode(vehicleMode) : null,
      lat: stop["lat"],
      lon: stop["lon"],
      routes: UnmodifiableMapView(parsedRoutes),
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
  final Color color;

  DigitransitStopInfoRoute({required this.shortName, required this.color});
}
