import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';

class MainLayoutStoptime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return NysseTile(
      leading: Text(
        "3",
        style: layout.labelStyle,
      ),
      content: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          "Pyynikintori",
          style: layout.shrinkedLabelStyle.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      trailing: Align(
        alignment: Alignment.bottomRight,
        child: Text(
          "4",
          style: layout.shrinkedLabelStyle,
        ),
      ),
    );
  }
}
