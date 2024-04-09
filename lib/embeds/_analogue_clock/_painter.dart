import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:nysse_asemanaytto/core/helpers/helpers.dart';

const double _kTextScaleFactor = 1.0;

const int _kHoursPerClockCycle = 12;

class AnalogClockPainter extends CustomPainter {
  final double seconds;

  final bool showDigitalClock;

  static const double _kBaseSize = 320.0;

  static const double _kHandPinHoleSize = 12.0;
  static const double _kHandPinHoleInnerSize = 2.0;

  static const double _kMainStrokeWidth = 8.0;
  static const double _kSubStrokeWidth = 5.0;
  static const double _kSecondStrokeWidth = 2.0;

  AnalogClockPainter({
    required double secondsAfterMidnight,
    this.showDigitalClock = false,
  }) : seconds = secondsAfterMidnight;

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.shortestSide / _kBaseSize;

    _paintTickMarks(canvas, size, scaleFactor);
    _drawIndicators(canvas, size, scaleFactor);

    if (showDigitalClock) {
      _paintDigitalClock(canvas, size, scaleFactor);
    }

    _paintClockHands(canvas, size, scaleFactor);
    _paintPinHole(canvas, size, scaleFactor);
  }

  @override
  bool shouldRepaint(AnalogClockPainter oldDelegate) {
    return seconds != oldDelegate.seconds ||
        showDigitalClock != oldDelegate.showDigitalClock;
  }

  void _paintPinHole(Canvas canvas, Size size, double scaleFactor) {
    Paint p = Paint();

    canvas.drawCircle(
      size.center(Offset.zero),
      (_kHandPinHoleSize / 2) * scaleFactor,
      p..color = Colors.redAccent,
    );
    canvas.drawCircle(
      size.center(Offset.zero),
      (_kHandPinHoleInnerSize / 2) * scaleFactor,
      p..color = Colors.black,
    );
  }

  void _drawIndicators(Canvas canvas, Size size, double scaleFactor) {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 18.0 * scaleFactor * _kTextScaleFactor,
    );
    // base padding + ticks
    double padding = 8.0 + 24.0;

    double r = size.shortestSide / 2;
    double distanceFromCenter = r - (padding * scaleFactor);

    for (var h = 0; h < 12; h += 3) {
      double angle = (h * math.pi / 6) - math.pi / 2; //+ pi / 2;
      Offset offset = Offset(distanceFromCenter * math.cos(angle),
          distanceFromCenter * math.sin(angle));
      TextSpan span = TextSpan(style: style, text: h.toString());
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, size.center(offset - tp.size.center(Offset.zero)));
    }
  }

  Offset _getHandDir(double percentage) {
    final radians = 2 * math.pi * percentage;
    final angle = -math.pi / 2.0 + radians;

    return Offset(math.cos(angle), math.sin(angle));
  }

  // ref: https://www.codenameone.com/blog/codename-one-graphics-part-2-drawing-an-analog-clock.html
  void _paintTickMarks(Canvas canvas, Size size, double scaleFactor) {
    double r = size.shortestSide / 2;
    double tick = 5 * scaleFactor,
        mediumTick = 2.0 * tick,
        longTick = 3.0 * tick;
    double padding = longTick + 4 * scaleFactor;
    Paint tickPaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0 * scaleFactor;

    for (int i = 1; i <= 60; i++) {
      // default tick length is short
      double len = tick;
      if (i % 15 == 0) {
        // Longest tick on quarters (every 15 ticks)
        len = longTick;
      } else if (i % 5 == 0) {
        // Medium ticks on the '5's (every 5 ticks)
        len = mediumTick;
      }
      // Get the angle from 12 O'Clock to this tick (radians)
      double angleFrom12 = i / 60.0 * 2.0 * math.pi;

      // Get the angle from 3 O'Clock to this tick
      // Note: 3 O'Clock corresponds with zero angle in unit circle
      // Makes it easier to do the math.
      double angleFrom3 = math.pi / 2.0 - angleFrom12;

      canvas.drawLine(
        size.center(
          Offset(
            math.cos(angleFrom3) * (r + len - padding),
            math.sin(angleFrom3) * (r + len - padding),
          ),
        ),
        size.center(
          Offset(
            math.cos(angleFrom3) * (r - padding),
            math.sin(angleFrom3) * (r - padding),
          ),
        ),
        tickPaint,
      );
    }
  }

  void _paintClockHands(Canvas canvas, Size size, double scaleFactor) {
    double r = size.shortestSide / 2;

    final double mainHandWidth = _kMainStrokeWidth * scaleFactor;
    final double subHandWidth = _kSubStrokeWidth * scaleFactor;
    final double secondHandWidth = _kSecondStrokeWidth * scaleFactor;

    // second hand stretches to the end of medium tick
    double secondHandLength = r - (9 * scaleFactor) - (secondHandWidth / 2);
    // minute hand stretches to the start of ticks (a small gap left for clarity, mathematically correct multiplier would be 19)
    double minuteHandLength = r - (20 * scaleFactor) - (mainHandWidth / 2);
    double hourHandLength = secondHandLength * 0.5;

    final Paint mainHandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = mainHandWidth
      ..color = Colors.black;
    final Paint subHandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = subHandWidth
      ..color = Colors.white;
    final Paint secondHandPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.bevel
      ..strokeWidth = secondHandWidth
      ..color = Colors.redAccent;

    final double subHandStart = r * 0.25;
    final double secondHandBitStart = -(r * (0.25 / 2));
    final double secondHandBitEnd = r * (0.25 / 4);

    final double minutes = seconds / Duration.secondsPerMinute;
    final double hours = seconds / Duration.secondsPerHour;

    // second progress
    // sin and cos make sure that the seconds that are wrapped around a bunch of times correlate to the correct direction
    final Offset secDir = _getHandDir(seconds / Duration.secondsPerMinute);
    final Offset minDir = _getHandDir(minutes / Duration.minutesPerHour);
    final Offset hrDir = _getHandDir(hours / _kHoursPerClockCycle);

    // hour hand
    canvas.drawLine(
      size.center(Offset.zero),
      size.center(hrDir * hourHandLength),
      mainHandPaint,
    );
    canvas.drawLine(
      size.center(hrDir * subHandStart),
      size.center(hrDir * hourHandLength),
      subHandPaint,
    );

    // minute hand
    canvas.drawLine(
      size.center(Offset.zero),
      size.center(minDir * minuteHandLength),
      mainHandPaint,
    );
    canvas.drawLine(
      size.center(minDir * subHandStart),
      size.center(minDir * minuteHandLength),
      subHandPaint,
    );

    // second hand
    canvas.drawLine(
      size.center(Offset.zero),
      size.center(secDir * secondHandLength),
      secondHandPaint,
    );
    secondHandPaint.strokeWidth = subHandWidth;
    canvas.drawLine(
      size.center(secDir * secondHandBitStart),
      size.center(secDir * secondHandBitEnd),
      secondHandPaint,
    );
  }

  void _paintDigitalClock(Canvas canvas, Size size, double scaleFactor) {
    final int hour =
        (seconds / Duration.secondsPerHour).floor() % Duration.hoursPerDay;
    final int minute =
        (seconds / Duration.secondsPerMinute).floor() % Duration.minutesPerHour;
    final int second = seconds.floor() % Duration.secondsPerMinute;

    TextSpan digitalClockSpan = TextSpan(
      style: TextStyle(
        color: Colors.black,
        fontSize: 18 * scaleFactor * _kTextScaleFactor,
      ),
      text: formatTime(hour, minute, second),
    );

    TextPainter digitalClockTP = TextPainter(
      text: digitalClockSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    digitalClockTP.layout();
    digitalClockTP.paint(
      canvas,
      size.center(
        -digitalClockTP.size.center(Offset(0.0, -size.shortestSide / 6)),
      ),
    );
  }
}
