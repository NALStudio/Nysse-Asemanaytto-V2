import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';
import 'package:nysse_asemanaytto/nysse/_pictograms.dart';

class MainLayoutHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NysseTile(
      leading: SvgPicture(
        NyssePictograms.tram.borderless,
        colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        alignment: Alignment.centerLeft,
      ),
      content: FractionallySizedBox(
        heightFactor: 0.7,
        child: SvgPicture.asset(
          "assets/images/logo_nysse_yhdistettypolku.svg",
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          alignment: Alignment.centerLeft,
        ),
      ),
      trailing: FittedBox(
        fit: BoxFit.fill,
        child: ClockWidget(
          displaySeconds: true,
          textStyle: Layout.of(context).labelStyle,
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
