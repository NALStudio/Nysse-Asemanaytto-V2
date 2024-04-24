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

  // currently padding - (padding / 4)
  double get shrinkedPadding => padding - quarterPadding;

  double get quarterPadding => padding / 4;
  double get halfPadding => padding / 2;

  double get padding => logicalPixelSize * 28;
  double get doublePadding => 2 * padding;

  // currently padding + halfPadding
  double get widePadding => logicalPixelSize * 42;
  double get doubleWidePadding => 2 * widePadding;

  double get indent => logicalPixelSize * 190;
  double get tileHeight => logicalPixelSize * 88;

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
        fontSize: tileHeight * 0.9,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1,
      );

  /// Doesn't work with multiple lines.
  TextStyle get smallLabelStyle => TextStyle(
        fontFamily: "Lato",
        fontSize: tileHeight * 0.85,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        height: 1,
      );
}
