import 'package:flutter/material.dart';

const Curve _kTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);

class StoptimeDismissAnimation extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;

  const StoptimeDismissAnimation({
    required Key key,
    required this.animation,
    required this.child,
  }) : super(key: key);

  @override
  State<StoptimeDismissAnimation> createState() =>
      _StoptimeDismissAnimationState();
}

class _StoptimeDismissAnimationState extends State<StoptimeDismissAnimation> {
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    widget.animation.addListener(_update);
  }

  @override
  void dispose() {
    widget.animation.removeListener(_update);
    super.dispose();
  }

  void _update() {
    setState(() {
      // reversed for some fucking reason
      opacity = widget.animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromRGBO(255, 0, 0, opacity),
      child: widget.child,
    );
  }
}
