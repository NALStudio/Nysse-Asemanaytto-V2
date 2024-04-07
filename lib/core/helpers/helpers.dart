import 'package:flutter/material.dart';

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

// Format time with leading zeroes on all parts.
String formatTime(int hour, int minute, [int? second]) {
  final List<int?> parts = [hour, minute, second];
  return parts.nonNulls.map((prt) => prt.toString().padLeft(2, '0')).join(':');
}

// Format time with leading zeroes on all parts except the first.
String formatTime2(int hour, int minute, [int? second]) {
  final List<int?> parts = [hour, minute, second];
  return parts.nonNulls.indexed.map((x) {
    final (int index, int part) = x;

    String s = part.toString();
    if (index > 0) {
      s = s.padLeft(2, '0');
    }

    return s;
  }).join(':');
}

// Convert snakeCase to a sentence with capitalized words.
String snakeCase2Sentence(String snakeCase) {
  final List<String> output = List.empty(growable: true);

  // first character isn't upper-case in camelCase
  // But we want to take the portion from start to the first upper-case character
  // So we set this as 0 at start.
  int lastUpperIndex = 0;
  for (final (int index, String char) in snakeCase.characters.indexed) {
    if (char == char.toUpperCase()) {
      // Take the portion between these upper characters, end exclusive.
      String word = snakeCase.substring(lastUpperIndex, index);
      if (lastUpperIndex == 0) {
        // first character is lower-case in camelCase
        word = word[0].toUpperCase() + word.substring(1);
      }

      output.add(word);
      lastUpperIndex = index;
    }
  }
  // Add the rest of the name
  if (lastUpperIndex == 0) {
    output.add(snakeCase[0].toUpperCase() + snakeCase.substring(1));
  } else {
    output.add(snakeCase.substring(lastUpperIndex));
  }

  return output.join(' ');
}

bool isSuccessStatusCode(int statusCode) {
  return (statusCode >= 200) && (statusCode <= 299);
}
