import 'dart:collection';

import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/digitransit/_enums.dart';
import 'package:nysse_asemanaytto/digitransit/_models/gtfs_id.dart';
import 'package:nysse_asemanaytto/digitransit/_models/route.dart';

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
      longName
      color
      mode
    }
  }
}
""";
  final String name;
  final DigitransitMode? vehicleMode;
  final Map<GtfsId, DigitransitRoute> routes;
  final double? lat;
  final double? lon;

  LatLng? get latlon => lat != null && lon != null ? LatLng(lat!, lon!) : null;

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

    final String? vehicleMode = stop["vehicleMode"];
    return DigitransitStopInfoQuery(
      name: stop["name"],
      vehicleMode: vehicleMode != null ? DigitransitMode(vehicleMode) : null,
      lat: stop["lat"],
      lon: stop["lon"],
      routes: UnmodifiableMapView(parseRoutes(stop["routes"])),
    );
  }

  static Map<GtfsId, DigitransitRoute> parseRoutes(
    List<dynamic> routes,
  ) {
    return Map.fromEntries(
      routes.map((e) {
        final Map<String, dynamic> map = e;
        final DigitransitRoute route = DigitransitRoute.parse(map);
        return MapEntry(route.gtfsId, route);
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
