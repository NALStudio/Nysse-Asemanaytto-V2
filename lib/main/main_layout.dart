import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return NysseTile(
      leading: SvgPicture(
        NyssePictograms.bus.borderless,
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
      trailing: const ClockWidget(displaySeconds: true),
    );
  }
}
