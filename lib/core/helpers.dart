double remapDouble(
    double value, double min1, double max1, double min2, double max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

Duration durationFromDouble({
  double? seconds,
  double? milliseconds,
  double? microseconds,
}) {
  seconds ??= 0;
  milliseconds ??= 0;
  microseconds ??= 0;

  int trueSeconds = seconds.toInt();

  milliseconds += (seconds - trueSeconds) * Duration.millisecondsPerSecond;
  int trueMillis = milliseconds.toInt();

  microseconds +=
      (milliseconds - trueMillis) * Duration.microsecondsPerMillisecond;
  int trueMicros = microseconds.toInt();

  return Duration(
    seconds: trueSeconds,
    milliseconds: trueMillis,
    microseconds: trueMicros,
  );
}
