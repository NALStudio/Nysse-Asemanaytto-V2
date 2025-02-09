import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/components/nysse_tile.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'dart:math' as math;

class MainLayoutStoptime extends StatelessWidget {
  final DigitransitStoptime stoptime;

  const MainLayoutStoptime({super.key, required this.stoptime});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    String time;
    if (stoptime.realtimeState == DigitransitRealtimeState.canceled) {
      // Temporary, this will be seen so rarely that I can't be bothered to implement it right now.
      time = "PERUTTU";
    } else if (stoptime.realtime == true) {
      final int nowSinceEpochMs = DateTime.now().millisecondsSinceEpoch;
      final int departureSinceEpochMs =
          stoptime.realtimeDepartureDateTime!.millisecondsSinceEpoch;
      final int deltaMs = departureSinceEpochMs - nowSinceEpochMs;
      time = math.max((deltaMs / 60000).floor(), 0).toString();
      // ^^ ms to min => toString, floor seems to yield better results
    } else {
      final DateTime departure = stoptime.scheduledDepartureDateTime!;
      final String hour = departure.hour.toString().padLeft(2, '0');
      final String minute = departure.minute.toString().padLeft(2, '0');
      time = "$hour:$minute";
    }

    final TextStyle headsignStyle = layout.shrinkedLabelStyle;

    return NysseTile(
      leading: Text(
        stoptime.routeShortName ?? "<null>",
        style: layout.labelStyle,
      ),
      content: Text(
        stoptime.headsign ?? "<null>",
        maxLines: 1,
        style: headsignStyle.copyWith(
          fontWeight: FontWeight.normal,
          height: layout.labelStyle.fontSize! / headsignStyle.fontSize!,
        ),
      ),
      trailing: Text(
        time,
        style: layout.labelStyle,
      ),
    );
  }
}
