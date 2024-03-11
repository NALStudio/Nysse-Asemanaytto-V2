import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class BusMarkerPainter extends CustomPainter {
  final Color borderColor;
  final double borderWidth;

  /// radians
  final double bearing;

  /// The minimum font size of lineNumber before it is displayed.
  final double? lineNumberMinSize;
  final String? lineNumber;

  final Size maxSize;

  BusMarkerPainter({
    super.repaint,
    required this.borderColor,
    required this.borderWidth,
    required this.bearing,
    this.lineNumber,
    this.lineNumberMinSize,
    required this.maxSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // English is too hard so I'll write this in Finnish

    // Ympyrän tangenttisuorien välinen kulma (tangenttikulma) α = 90°
    // Tällöin ympyrän keskuskulma: β = 180° - α = 180° - 90° = 90°

    // Olkoon nuolen suunta (asteina) γ
    // Tangenttisuorien ja ympyrän välinen leikkauspiste on tällöin suunnassa γ + ±45°
    // jolloin kun 0° on oikealle, voidaan leikkauspisteen paikka laskea: x = r*cos(γ ± 45°) ja y = r*sin(γ ± 45°)
    // haluamme kuitenkin 0° ylös, jolloin x = r*cos(γ ± 45° - 90°) ja y = r*sin(γ ± 45° - 90°)

    // Tangenttisuorien ja ympyrän välisten leikkauspisteiden kulma on 90°
    // Keskuskulman todettiin olevan 90°
    // Haluttu tangenttisuorien välinen kulma on määritelty α:ksi.
    // Meillä on neljä 90° ja siitä ei voi syntyä muuta kuin neliö.
    // Tämän neliön sivun pituus on r, jolloin vastakkaisten kulmien etäisyys:
    // d = r * sqrt(2)
    // Tämä vastaa ympyrän keskipisteen ja tangenttisuorien leikkauspisteen välistä etäisyyttä.
    // Tämän paikka on siis (0° on ylös):
    // x = d*cos(γ - 90°) ja y = d*sin(γ - 90°)

    // Nuolen piirtämiseksi tarvitaan siis kolmio, joka kulkee pisteiden:
    // (d*cos(γ - 90°), d*sin(γ - 90°))
    // (r*cos(γ - 45°), r*sin(γ - 45°))
    // (r*cos(γ - 135°), r*sin(γ - 135°))
    // kautta (täytyy myös muistaa offsettaa pisteet ympyrän keskeltä)

    double cSize = math.min(size.width, size.height);
    double cMaxSize = math.min(maxSize.width, maxSize.height);
    Offset center = Offset(cSize / 2, cSize / 2);

    double arrowDistanceFromCenter = cSize;
    // d = r * sqrt(2) => r = d / sqrt(2)
    double radius = arrowDistanceFromCenter / math.sqrt2;

    const double deg45inRad = math.pi / 4;
    const double deg90inRad = math.pi / 2;
    const double deg135inRad = (3 * math.pi) / 4;

    Path trianglePath = Path();
    trianglePath.addPolygon(
      [
        Offset(
          center.dx +
              (arrowDistanceFromCenter * math.cos(bearing - deg90inRad)),
          center.dy +
              (arrowDistanceFromCenter * math.sin(bearing - deg90inRad)),
        ),
        Offset(
          center.dx + (radius * math.cos(bearing - deg45inRad)),
          center.dy + (radius * math.sin(bearing - deg45inRad)),
        ),
        Offset(
          center.dx + (radius * math.cos(bearing - deg135inRad)),
          center.dy + (radius * math.sin(bearing - deg135inRad)),
        ),
      ],
      true,
    );

    final Paint paint = Paint();

    // Outer circle and arrow => (the border)
    paint.color = borderColor;
    canvas.drawPath(trianglePath, paint);
    canvas.drawCircle(center, radius, paint);

    // Inner circle => (not the border)
    paint.color = Colors.white;
    canvas.drawCircle(
      center,
      radius - borderWidth,
      paint,
    );

    if (lineNumber != null) {
      const double textBorderPadding = 1;
      final double fontSizePadding =
          (2 * borderWidth) - (2 * textBorderPadding);
      final double fontSize = cSize - fontSizePadding;
      final double maxFontSize = cMaxSize - fontSizePadding;

      if (lineNumberMinSize == null || fontSize > lineNumberMinSize!) {
        final ui.Image textImage = _textImage(renderSize: maxFontSize);
        paintImage(
          canvas: canvas,
          rect: Rect.fromCenter(
            center: center,
            width: (textImage.width / textImage.height) * fontSize,
            height: fontSize,
          ),
          image: textImage,
        );
      }
    }
  }

  ui.Image _textImage({required double renderSize}) {
    final recorder = ui.PictureRecorder();
    final textCanvas = Canvas(recorder);

    final textSpan = TextSpan(
      text: lineNumber,
      style: TextStyle(
        color: Colors.black,
        fontSize: renderSize,
        height: 1,
        fontWeight: FontWeight.bold,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(textCanvas, Offset.zero);

    final ui.Picture pic = recorder.endRecording();
    final ui.Image img = pic.toImageSync(
      textPainter.width.round(),
      textPainter.height.round(),
    );

    return img;
  }

  @override
  bool shouldRepaint(covariant BusMarkerPainter oldDelegate) {
    return borderColor != oldDelegate.borderColor ||
        borderWidth != oldDelegate.borderWidth ||
        bearing != oldDelegate.bearing ||
        lineNumber != oldDelegate.lineNumber ||
        maxSize != oldDelegate.maxSize;
  }
}
