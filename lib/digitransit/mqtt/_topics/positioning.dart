import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class DigitransitPositioningTopic {
  static const List<String?> _defaultTopic = [
    "gtfsrt", // feed_format
    "vp", // type
    null, // feed_id
    null, // agency_id
    null, // agency_name
    null, // mode
    null, // route_id
    null, // direction_id
    null, // trip_headsign
    null, // trip_id
    null, // next_stop
    // ^^ We have implemented these values up to here
    // null, // start_time
    // null, // vehicle_id
    // null, // geohash_head
    // null, // geohash_firstdeg
    // null, // geohash_seconddeg
    // null, // geohash_thirddeg
    // null, // short_name
    // null, // color
  ];

  final List<String?> _parts;

  String get feedFormat => _parts[0]!;
  String get type => _parts[1]!;

  String? get feedId => _parts[2];
  set feedId(String? value) => _parts[2] = value;

  String? get agencyId => _parts[3];
  String? get agencyName => _parts[4];

  DigitransitMode? get mode => maybe(_parts[5], (x) => DigitransitMode(x));
  set mode(DigitransitMode? mode) => _parts[5] = mode?.value;

  String? get routeId => _parts[6];
  set routeId(String? value) => _parts[6] = value;

  int? get directionId => maybe(_parts[7], (x) => int.parse(x));
  set directionId(int? value) => _parts[7] = value?.toString();

  String? get tripHeadsign => _parts[8];
  set tripHeadsign(String? value) => _parts[8] = value;

  String? get tripId => _parts[9];
  set tripId(String? value) => _parts[9] = value;

  String? get vehicleId => _parts[10];
  set vehicleId(String? value) => _parts[10] = value;

  DigitransitPositioningTopic()
      : _parts = _defaultTopic.toList(growable: false);

  DigitransitPositioningTopic.route(GtfsId routeId)
      : _parts = _defaultTopic.toList(growable: false) {
    feedId = routeId.feedId;
    this.routeId = routeId.rawId;
  }

  DigitransitPositioningTopic.trip(GtfsId tripId)
      : _parts = _defaultTopic.toList(growable: false) {
    feedId = tripId.feedId;
    this.tripId = tripId.rawId;
  }

  DigitransitPositioningTopic.fromString(String topic)
      : _parts = _topicToList(topic);

  static T? maybe<T>(String? value, T Function(String value) factory) {
    if (value == null) {
      return null;
    } else {
      return factory(value);
    }
  }

  static List<String?> _topicToList(String topic) {
    if (!topic.startsWith('/')) {
      throw ArgumentError("Topic must start with a slash.");
    }

    // Cannot cast straight to String?
    List<String> split = topic.split(MqttTopic.topicSeparator);

    final List<String?> parts =
        List.filled(_defaultTopic.length, null, growable: true);

    // The starting slash means an empty value at the start, this will be removed during copy
    assert(split[0] == '');

    if (split.length <= parts.length) {
      List.copyRange(parts, 0, split, 1);
    } else {
      List.copyRange(parts, 0, split, 1, parts.length);
    }

    // Remove wildcards
    for (int i = 0; i < parts.length; i++) {
      String? part = parts[i];
      if (part == MqttTopic.wildcard || part == MqttTopic.multiWildcard) {
        parts[i] = null;
      } else {
        // agency_id, agency_name, etc. are all empty
        // assert(part.isNotEmpty);
      }
    }

    assert(parts.length == _defaultTopic.length);
    return parts;
  }

  MqttSubscriptionTopic buildTopic() {
    final String topic = _buildTopicString();
    return MqttSubscriptionTopic(topic);
  }

  String _buildTopicString() {
    int end = _parts.length;
    while (end > 0 && _parts[end - 1] == null) {
      end--;
    }

    Iterable<String> data = _parts.take(end).map((e) => e ?? '+');
    return '/${data.join('/')}/#';
  }
}
