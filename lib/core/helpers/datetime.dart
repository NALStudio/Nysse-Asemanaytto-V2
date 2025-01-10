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

  static DateTime roundToNearestHour(DateTime dt) {
    DateTime rounded = getHour(dt);
    if (dt.minute < 30) {
      return rounded;
    } else {
      return rounded.add(const Duration(hours: 1));
    }
  }

  /// Formats the [DateTime] into the ISO8601 representation.
  /// The timezone offset is included in the output, the milliseconds are not.
  // https://github.com/dart-lang/sdk/issues/43391#issuecomment-1954335465
  static String toIso8601StringWithOffset(DateTime dt) {
    // Get offset
    final timeZoneOffset = dt.timeZoneOffset;
    final sign = timeZoneOffset.isNegative ? '-' : '+';
    final hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    final minutes =
        timeZoneOffset.inMinutes.abs().remainder(60).toString().padLeft(2, '0');
    final offsetString = '$sign$hours:$minutes';

    // Get first part of properly formatted ISO 8601 date
    final formattedDate = dt.toIso8601String().split('.').first;

    return '$formattedDate$offsetString';
  }
}
