import 'package:flutter/material.dart';

class Layout extends InheritedWidget {
  final LayoutData info;

  const Layout({
    super.key,
    required super.child,
    required this.info,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static LayoutData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Layout>()?.info;
  }

  static LayoutData of(BuildContext context) {
    final LayoutData? result = maybeOf(context);
    assert(result != null, "No Layout data found in context.");
    return result!;
  }
}

class LayoutData {
  final MediaQueryData _mq;

  const LayoutData({required MediaQueryData mediaQueryData})
      : _mq = mediaQueryData;

  double get logicalPixelSize => _mq.size.width / 1080;

  double get halfPadding => padding / 2;
  double get padding => logicalPixelSize * 38;
  double get widePadding => 2 * padding;

  double get indent => logicalPixelSize * 190;
  double get tileHeight => logicalPixelSize * 89;

  /// Doesn't work with multiple lines.
  TextStyle get labelStyle => TextStyle(
        fontFamily: "Lato",
        fontSize: tileHeight,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1, // breaks multiple lines, but makes UI nicer
      );

  /// Doesn't work with multiple lines.
  TextStyle get shrinkedLabelStyle => TextStyle(
        fontFamily: "Lato",
        fontSize: tileHeight * 0.8,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1,
      );
}
