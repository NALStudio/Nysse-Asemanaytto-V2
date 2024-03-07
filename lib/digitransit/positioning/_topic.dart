import 'package:nysse_asemanaytto/digitransit/_enums.dart';

/// TODO: Subscribe to topics in mqtt.digitransit.fi

class PositioningTopic {
  final String feedId;

  /// Not implemented yet but will be any string or empty
  final String? agencyId;

  /// Not implemented yet but will be any string or empty
  final String? agencyName;

  /// [DigitransitMode.bus], [DigitransitMode.ferry], [DigitransitMode.funicular], [DigitransitMode.rail], [DigitransitMode.tram] or null.
  /// (there might be more possible values in the future)
  final DigitransitMode? mode;

  final String? routeId;

  /// 0, 1 or null
  final int? directionId;

  final String? tripHeadsign;

  final String? tripId;

  final String? nextStop;

  final String? startTime;

  final String? vehicleId;

  PositioningTopic({
    required this.feedId,
    this.agencyId,
    this.agencyName,
    this.mode,
    this.routeId,
    this.directionId,
    this.tripHeadsign,
    this.tripId,
    this.nextStop,
    this.startTime,
    this.vehicleId,
  });

  String buildTopicString() {
    List<String?> data = [
      "gtfsrt",
      "vp",
      feedId,
      agencyId,
      agencyName,
      mode?.value,
      routeId,
      directionId?.toString(),
      tripHeadsign,
      tripId,
      nextStop,
      startTime,
      vehicleId,
    ];
    while (data.last == null) {
      data.removeLast();
    }
    Iterable<String> dataWithWildCards = data.map((e) => e ?? '+');
    return '/${dataWithWildCards.join('/')}/#';
  }
}
