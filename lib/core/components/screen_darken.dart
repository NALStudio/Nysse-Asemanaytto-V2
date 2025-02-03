import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

class ScreenDarkenHandle {
  double? _strength;
  double? get strength => _strength;

  final ScreenDarkenWidgetState _parent;

  ScreenDarkenHandle._({required ScreenDarkenWidgetState parent})
      : _parent = parent;

  void activate({double? strength}) {
    _strength = strength;
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
  final double defaultStrength;
  final Widget child;

  const ScreenDarkenWidget({
    super.key,
    required this.child,
    required this.defaultStrength,
  }) : assert(defaultStrength > 0 && defaultStrength < 1);

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

  double? _strength;
  double _overlayOpacity = 1.0;
  bool _omitOverlay = true;

  @override
  void initState() {
    super.initState();

    _opacityController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _opacityController.addListener(_updateOpacityFromDarken);
    _opacityController.addStatusListener(_onAnimationStateUpdated);
  }

  void _updateOpacityFromDarken() {
    double t = Curves.easeInOut.transform(_opacityController.value);
    double opacity = lerpDouble(0.0, _strength, t)!;

    setState(() {
      _overlayOpacity = opacity;
    });
  }

  void _onAnimationStateUpdated(AnimationStatus status) {
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
      // Only update strength if darken is true
      // so that the animation doesn't bug out during disable
      _updateDarkenStrength();

      if (!_opacityController.isCompleted) {
        _opacityController.forward();
      }
    } else {
      if (!_opacityController.isDismissed) {
        _opacityController.reverse();
      }
    }
  }

  void _updateDarkenStrength() {
    double strength =
        _activeHandles.lastOrNull?.strength ?? widget.defaultStrength;
    if (_strength != strength) {
      _strength = strength;
      // Always force update opacity if darkness strength changes
      _updateOpacityFromDarken();
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
