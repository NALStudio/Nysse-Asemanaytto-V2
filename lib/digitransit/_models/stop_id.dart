class StopId {
  final String value;

  StopId(this.value);

  String get stopFeedId {
    int colonIndex = value.indexOf(':');
    return value.substring(0, colonIndex);
  }

  String get stopGtfsId {
    int colonIndex = value.indexOf(':');
    return value.substring(colonIndex + 1);
  }
}
