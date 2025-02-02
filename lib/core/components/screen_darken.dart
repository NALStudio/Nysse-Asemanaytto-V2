import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenDarkenHandle {
  final ScreenDarkenWidgetState _parent;

  ScreenDarkenHandle._({required ScreenDarkenWidgetState parent})
      : _parent = parent;

  void activate() {
    _parent._activate(this);
  }

  void deactivate() {
    _parent._deactivate(this);
  }

  void dispose() {
    deactivate();
  }
}

class ScreenDarkenWidget extends StatefulWidget {
  final double strength;
  final Widget child;

  const ScreenDarkenWidget({
    super.key,
    required this.child,
    required this.strength,
  }) : assert(strength > 0 && strength < 1);

  @override
  State<ScreenDarkenWidget> createState() => ScreenDarkenWidgetState();

  static ScreenDarkenWidgetState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ScreenDarkenInheritedWidget>()
        ?.parent;
  }

  // static ScreenDarkenWidgetState of(BuildContext context) {
  //   final ScreenDarkenWidgetState? result = maybeOf(context);
  //   assert(result != null, "No screen darken found in context.");
  //   return result!;
  // }
}

class ScreenDarkenWidgetState extends State<ScreenDarkenWidget>
    with SingleTickerProviderStateMixin {
  final HashSet<ScreenDarkenHandle> _activeHandles = HashSet();
  late AnimationController _opacityController;
  bool _disposed = false;

  double _overlayOpacity = 1.0;
  bool _omitOverlay = true;

  @override
  void initState() {
    super.initState();

    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityController.addListener(onAnimationUpdated);
    _opacityController.addStatusListener(onAnimationStateUpdated);
  }

  void onAnimationUpdated() {
    double t = Curves.easeInOut.transform(_opacityController.value);
    double opacity = lerpDouble(0.0, widget.strength, t)!;

    setState(() {
      _overlayOpacity = opacity;
    });
  }

  void onAnimationStateUpdated(AnimationStatus status) {
    bool omit = status.isDismissed;
    if (_omitOverlay != omit) {
      setState(() {
        _omitOverlay = omit;
      });
    }
  }

  ScreenDarkenHandle createHandle() => ScreenDarkenHandle._(parent: this);

  bool _activate(ScreenDarkenHandle handle) {
    if (_disposed) {
      throw ArgumentError("Cannot add handle to a disposed state.");
    }

    bool added = _activeHandles.add(handle);
    _updateDarken();
    return added;
  }

  bool _deactivate(ScreenDarkenHandle handle) {
    bool removed = _activeHandles.remove(handle);
    _updateDarken();
    return removed;
  }

  void _updateDarken() {
    bool darken = _activeHandles.isNotEmpty;
    if (darken) {
      if (!_opacityController.isCompleted) {
        _opacityController.forward();
      }
    } else {
      if (!_opacityController.isDismissed) {
        _opacityController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ScreenDarkenInheritedWidget(
      parent: this,
      child: _buildOverlay(widget.child),
    );
  }

  Widget _buildOverlay(Widget child) {
    List<Widget> children = [child];
    if (!_omitOverlay) {
      children.add(
        ColoredBox(
          color: Color.fromRGBO(0, 0, 0, _overlayOpacity),
        ),
      );
    }

    // always return stack so that we don't lose the state of any
    // child components
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: children,
    );
  }

  @override
  void dispose() {
    _disposed = true;
    _opacityController.dispose();
    super.dispose();
  }
}

class _ScreenDarkenInheritedWidget extends InheritedWidget {
  final ScreenDarkenWidgetState parent;

  const _ScreenDarkenInheritedWidget({
    required this.parent,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant _ScreenDarkenInheritedWidget oldWidget) =>
      !identical(parent, oldWidget.parent);
}
