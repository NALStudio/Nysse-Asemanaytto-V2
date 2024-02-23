import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

class NysseWavePainter extends CustomPainter {
  final Offset start;
  final double waveStartOffset;

  final double directionX;
  final double directionY;

  /// [waveSize] does not equal amplitude.
  final double waveSize;
  final double waveLength;

  final bool invert;

  const NysseWavePainter({
    super.repaint,
    required this.start,
    this.waveStartOffset = 0,
    required this.directionX,
    required this.directionY,
    required this.waveLength,
    required this.waveSize,
    this.invert = false,
  });

  NysseWavePainter.fromAngle({
    Listenable? repaint,
    required Offset start,
    double waveStartOffset = 0,
    required double angleRadians,
    required double waveLength,
    required double waveSize,
    bool invert = false,
  }) : this(
          repaint: repaint,
          start: start,
          waveStartOffset: waveStartOffset,
          directionX: cos(angleRadians),
          directionY: sin(angleRadians),
          waveLength: waveLength,
          waveSize: waveSize,
          invert: invert,
        );

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = NysseColors.darkBlue;

    final double advance = waveLength / 2;

    bool inverted = invert;
    double progress = 0;

    final Path path = Path();
    final moveToAtStart = _calcPos(progress);
    path.moveTo(moveToAtStart.x, moveToAtStart.y);

    while (true) {
      final source = _calcPos(progress);
      progress += advance;
      final target = _calcPos(progress);

      // control point on the line
      double controlX = (source.x + target.x) / 2;
      double controlY = (source.y + target.y) / 2;

      // offset control point away from centre
      double controlMult = inverted ? 1 : -1;
      controlX += -directionY * controlMult * waveSize;
      controlY += directionX * controlMult * waveSize;

      path.quadraticBezierTo(controlX, controlY, target.x, target.y);

      if (target.x < 0 && directionX < 0) {
        break;
      }
      if (target.x > size.width && directionX > 0) {
        break;
      }
      if (target.y < 0 && directionY < 0) {
        break;
      }
      if (target.y > size.width && directionY > 0) {
        break;
      }
      inverted = !inverted;
    }

    final lineToAtEnd = _calcPos(progress);
    path.lineTo(lineToAtEnd.x, moveToAtStart.y);
    path.close();

    canvas.drawPath(path, paint);
  }

  Point<double> _calcPos(double progress) {
    double x = start.dx + progress * directionX;
    x -= directionX * waveStartOffset * waveLength;

    double y = start.dy + progress * directionY;
    y -= directionY * waveStartOffset * waveLength;

    return Point(x, y);
  }

  @override
  bool shouldRepaint(covariant NysseWavePainter oldDelegate) {
    return start != oldDelegate.start ||
        waveStartOffset != oldDelegate.waveStartOffset ||
        directionX != oldDelegate.directionX ||
        directionY != oldDelegate.directionY ||
        waveSize != oldDelegate.waveSize ||
        waveLength != oldDelegate.waveLength ||
        invert != oldDelegate.invert;
  }
}
