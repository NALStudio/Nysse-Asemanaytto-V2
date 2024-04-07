class DateTimeHelpers {
  static bool isLocalDateTime(DateTime dt) {
    return dt.timeZoneName == dt.toLocal().timeZoneName;
  }

  static bool isDateOnly(DateTime dt) {
    return dt.hour == 0 &&
        dt.minute == 0 &&
        dt.second == 0 &&
        dt.millisecond == 0 &&
        dt.microsecond == 0;
  }

  /// Returns the provided datetime with hour, minute, second, millisecond and nanosecond info stripped out.
  static DateTime getDate(DateTime dt) {
    return dt.copyWith(
      hour: 0,
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  /// Returns the provided datetime with minute, second, millisecond and nanosecond info stripped out.
  static DateTime getHour(DateTime dt) {
    return dt.copyWith(
      minute: 0,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  /// Returns the provided datetime with second, millisecond and nanosecond info stripped out.
  static DateTime getMinute(DateTime dt) {
    return dt.copyWith(
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );
  }

  /// Returns the provided datetime with millisecond and nanosecond info stripped out.
  static DateTime getSecond(DateTime dt) {
    return dt.copyWith(
      millisecond: 0,
      microsecond: 0,
    );
  }
}
