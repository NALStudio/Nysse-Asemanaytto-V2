import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';
import 'package:nysse_asemanaytto/digitransit/schema.graphql.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

class MainLayoutHeader extends StatelessWidget {
  final Enum$Mode stopVehicleMode;

  const MainLayoutHeader({
    super.key,
    required this.stopVehicleMode,
  });

  @override
  Widget build(BuildContext context) {
    return NysseTile(
      leading: SvgPicture(
        NyssePictograms.getModePictogram(stopVehicleMode!),
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