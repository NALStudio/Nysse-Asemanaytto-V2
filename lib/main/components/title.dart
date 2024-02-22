import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/digitransit/queries/queries.dart';

class MainLayoutTitle extends StatelessWidget {
  final DigitransitStopInfoQuery stopInfo;

  const MainLayoutTitle({super.key, required this.stopInfo});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _TitleDivider(),
        SizedBox(height: layout.halfPadding),
        Row(
          children: [
            Expanded(
              child: Text(
                stopInfo.name,
                style: layout.labelStyle.copyWith(height: 1.1),
              ),
            ),
            SvgPicture.asset(
              "assets/images/icon_pysakki.svg",
              colorFilter:
                  const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              alignment: Alignment.centerRight,
              height: layout.tileHeight * 0.75,
            ),
          ],
        ),
        SizedBox(height: layout.halfPadding),
        const _TitleDivider(),
      ],
    );
  }
}

class _TitleDivider extends StatelessWidget {
  const _TitleDivider();

  @override
  Widget build(BuildContext context) {
    final double dividerHeight = 2 * Layout.of(context).logicalPixelSize;

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: dividerHeight,
          ),
        ),
      ),
    );
  }
}
