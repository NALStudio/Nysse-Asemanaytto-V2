import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/settings/controls/settings_control.dart';

/// Visual only, does not actually provide any [Form] functionality.
class SettingsForm extends StatelessWidget {
  final Widget title;
  final List<SettingsControl> controls;
  final bool childPadding;
  final bool dividers;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const SettingsForm({
    super.key,
    required this.title,
    required this.controls,
    this.childPadding = true,
    this.dividers = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  static List<Widget> _addDividers({required List<Widget> children}) {
    int trueIndex = -1;
    return List.generate(
      (2 * children.length) - 1,
      (index) {
        if (index % 2 == 1) {
          return const Divider();
        }

        trueIndex++;
        return children[trueIndex];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    // Add dividers between children.
    List<Widget> children = controls;
    if (childPadding) {
      children = children.map((c) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: layout.padding,
          ),
          child: c,
        );
      }).toList();
    }
    if (dividers) {
      children = _addDividers(children: children);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: layout.padding,
            bottom: layout.halfPadding,
          ),
          child: DefaultTextStyle(
            style: layout.labelStyle.copyWith(color: Colors.black),
            child: title,
          ),
        ),
        Material(
          elevation: 2,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: layout.halfPadding,
            ),
            child: Column(
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
