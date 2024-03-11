/// a GTFS ID where the feed is specified (i.e. tampere:XXXXXXXXX)
/// This class should not be used to store GTFS IDs which do not have a feed designator. (use a String instead)
class GtfsId {
  final String id;

  GtfsId(this.id) {
    // Check if there is a feed:id divider
    assert(id.contains(':'));

    // Check that there is only one feed:id divider
    assert(id.indexOf(':') == id.lastIndexOf(':'));
  }
  GtfsId.combine(String feedId, String rawId) : this("$feedId:$rawId");

  String get feedId {
    int colonIndex = id.indexOf(':');
    return id.substring(0, colonIndex);
  }

  // This GTFS ID without Feed ID.
  String get rawId {
    int colonIndex = id.indexOf(':');
    return id.substring(colonIndex + 1);
  }

  @override
  operator ==(Object other) {
    return other is GtfsId && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
