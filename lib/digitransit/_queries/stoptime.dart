import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class DigitransitStoptimeQuery {
  static const String query = """
query getStoptimes(\$stopId: String!, \$numberOfDepartures: Int)
{
  stop(id: \$stopId) {
    stoptimesWithoutPatterns(
      numberOfDepartures: \$numberOfDepartures
      omitNonPickups: true
      omitCanceled: false
    ) {
      scheduledDeparture
      realtimeDeparture
      serviceDay
      realtime
      realtimeState
      headsign
      trip {
        gtfsId
        route {
          gtfsId
          shortName
        }
      }
    }
  }
}
""";
  final List<DigitransitStoptime>? stoptimesWithoutPatterns;

  DigitransitStoptimeQuery({required this.stoptimesWithoutPatterns});

  static DigitransitStoptimeQuery parse(Map<String, dynamic> data) {
    List<dynamic>? stoptimes = data["stop"]?["stoptimesWithoutPatterns"];
    return DigitransitStoptimeQuery(
      stoptimesWithoutPatterns: stoptimes
          ?.map((d) => DigitransitStoptime.parse(d))
          .toList(growable: false),
    );
  }
}

class DigitransitStoptime {
  final int? scheduledDeparture;
  final int? realtimeDeparture;
  final int? serviceDay;

  DateTime? get scheduledDepartureDateTime =>
      _mergeMixedDateTime(scheduledDeparture);
  DateTime? get realtimeDepartureDateTime =>
      _mergeMixedDateTime(realtimeDeparture);

  final bool? realtime;
  final DigitransitRealtimeState? realtimeState;

  /// Trip headsigns can change during the trip (e.g. on routes which run on loops),
  /// so this value should be used instead of the trip's headsign.
  final String? headsign;
  final String? routeShortName;

  final GtfsId? tripGtfsId;
  final GtfsId? routeGtfsId;

  DateTime? _mergeMixedDateTime(int? timeMix) {
    if (timeMix != null && serviceDay != null) {
      final int totalSeconds = serviceDay! + timeMix;
      return DateTime.fromMillisecondsSinceEpoch(
        totalSeconds * 1000,
        isUtc: false,
      );
    }

    return null;
  }

  DigitransitStoptime({
    required this.scheduledDeparture,
    required this.realtimeDeparture,
    required this.serviceDay,
    required this.realtime,
    required this.realtimeState,
    required this.headsign,
    required this.routeShortName,
    required this.tripGtfsId,
    required this.routeGtfsId,
  });

  static DigitransitStoptime parse(Map<String, dynamic> data) {
    final String? realtimeState = data["realtimeState"];
    final Map<String, dynamic>? trip = data["trip"];
    final Map<String, dynamic>? route = trip?["route"];

    final String? gtfsId = trip?["gtfsId"];

    return DigitransitStoptime(
      scheduledDeparture: data["scheduledDeparture"],
      realtimeDeparture: data["realtimeDeparture"],
      serviceDay: data["serviceDay"],
      realtime: data["realtime"],
      realtimeState: realtimeState != null
          ? DigitransitRealtimeState(realtimeState)
          : null,
      headsign: data["headsign"],
      routeShortName: route?["shortName"],
      tripGtfsId: gtfsId != null ? GtfsId(gtfsId) : null,
      routeGtfsId: route != null ? GtfsId(route["gtfsId"] as String) : null,
    );
  }
}
