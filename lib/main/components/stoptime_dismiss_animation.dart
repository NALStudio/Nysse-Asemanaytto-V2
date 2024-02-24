import 'package:flutter/material.dart';

const Curve _kTranslationCurve = Interval(0.0, 0.6, curve: Curves.easeIn);
const Curve _kSizeCurve = Interval(0.5, 1.0, curve: Curves.easeInOut);

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
  double progress = 0.0;

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
      // goes from 1 to 0 for some reason
      progress = 1.0 - widget.animation.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double trans = _kTranslationCurve.transform(progress);
    double height = _kSizeCurve.transform(progress);

    return Align(
      alignment: Alignment.topLeft,
      heightFactor: 1.0 - height,
      child: FractionalTranslation(
        translation: Offset(trans, 0.0),
        child: widget.child,
      ),
    );
  }
}
