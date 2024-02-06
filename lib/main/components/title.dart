import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';

class MainLayoutTitle extends StatelessWidget {
  const MainLayoutTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(
          color: Colors.white,
          thickness: 2 * layout.logicalPixelSize,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                "Turtola",
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
        Divider(
          color: Colors.white,
          thickness: 2 * layout.logicalPixelSize,
        ),
      ],
    );
  }
}
