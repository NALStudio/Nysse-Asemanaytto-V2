import 'dart:async';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  final bool displaySeconds;

  const ClockWidget({
    super.key,
    this.textStyle,
    this.textAlign,
    this.displaySeconds = false,
  });

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _time;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _updateClock();
  }

  @override
  void dispose() {
    super.dispose();

    _timer.cancel();
  }

  void _updateClock() {
    setState(() => _time = DateTime.now());

    final Duration wait = widget.displaySeconds
        ? Duration(milliseconds: 1000 - _time.millisecond)
        : Duration(seconds: 60 - _time.second);
    _timer = Timer(wait, _updateClock);
  }

  @override
  Widget build(BuildContext context) {
    List<int> parts;
    if (widget.displaySeconds) {
      parts = [_time.hour, _time.minute, _time.second];
    } else {
      parts = [_time.hour, _time.minute];
    }

    return Text(
      parts.map((i) => i.toString().padLeft(2, '0')).join(':'),
      style: widget.textStyle,
      textAlign: widget.textAlign,
      maxLines: 1,
    );
  }
}
