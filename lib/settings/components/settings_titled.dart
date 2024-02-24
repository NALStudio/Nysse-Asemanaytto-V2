import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';

class SettingsTitled extends StatelessWidget {
  final String title;
  final Widget child;

  const SettingsTitled({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Layout.of(context).labelStyle.copyWith(color: Colors.grey),
        ),
        child,
      ],
    );
  }
}
