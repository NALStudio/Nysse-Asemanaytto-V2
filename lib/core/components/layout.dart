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

  double get padding => _mq.size.width * 0.025;
  double get widePadding => 2 * padding;

  double get indent => 7 * padding;
  double get tileHeight => 3 * padding;
}
