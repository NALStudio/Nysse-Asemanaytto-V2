import 'package:nysse_asemanaytto/digitransit/enums.dart';

class DigitransitStoptimeQuery {
  static const String query = """
{
  stop(id: \$stopId) {
    stoptimesWithoutPatterns(numberOfDepartures: \$numberOfDepartures, omitNonPickups: true, omitCanceled: false) {
      scheduledDeparture
      realtimeDeparture
      serviceDay
      realtime
      realtimeState
      headsign
      trip {
        gtfsId
      }
    }
  }
}
""";
  final List<DigitransitStoptime>? stoptimesWithoutPatterns;

  DigitransitStoptimeQuery({required this.stoptimesWithoutPatterns});

  static DigitransitStoptimeQuery parse(Map<String, dynamic> data) {
    List<dynamic>? stoptimes = data["stoptimesWithoutPatterns"];
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

  final bool? realtime;
  final DigitransitRealtimeState? realtimeState;

  /// Trip headsigns can change during the trip (e.g. on routes which run on loops),
  /// so this value should be used instead of the trip's headsign.
  final String? headsign;

  final String tripGtfsId;

  DigitransitStoptime({
    required this.scheduledDeparture,
    required this.realtimeDeparture,
    required this.serviceDay,
    required this.realtime,
    required this.realtimeState,
    required this.headsign,
    required this.tripGtfsId,
  });

  static DigitransitStoptime parse(Map<String, dynamic> data) {
    return DigitransitStoptime(
      scheduledDeparture: data["scheduledDeparture"],
      realtimeDeparture: data["realtimeDeparture"],
      serviceDay: data["serviceDay"],
      realtime: data["realtime"],
      realtimeState: data["realtimeState"],
      headsign: data["headsign"],
      tripGtfsId: data["trip"]?["gtfsId"],
    );
  }
}
