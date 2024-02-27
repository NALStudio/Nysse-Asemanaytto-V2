import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'package:nysse_asemanaytto/nysse/_pictograms.dart';

class MainLayoutHeader extends StatelessWidget {
  const MainLayoutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return NysseTile(
      leading: SvgPicture(
        NyssePictograms.getModePictogram(
          StopInfo.of(context)?.vehicleMode ?? DigitransitMode.bus,
        ).borderless,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        alignment: Alignment.centerLeft,
      ),
      content: FractionallySizedBox(
        heightFactor: 0.7,
        child: Align(
          alignment: Alignment.topLeft,
          child: SvgPicture.asset(
            "assets/images/logo_nysse_yhdistettypolku.svg",
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            alignment: Alignment.topLeft,
          ),
        ),
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: ClockWidget(
          displaySeconds: false,
          textStyle: Layout.of(context).labelStyle,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
