import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';

class MainLayoutStoptime extends StatelessWidget {
  const MainLayoutStoptime({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return NysseTile(
      leading: Text(
        "3",
        style: layout.labelStyle,
      ),
      content: Text(
        "Hervanta",
        style: layout.labelStyle.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
      trailing: Text(
        "8",
        style: layout.labelStyle,
      ),
    );
  }
}
