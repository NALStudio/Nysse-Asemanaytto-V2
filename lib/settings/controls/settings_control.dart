import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';

abstract class SettingsControl<T> extends StatelessWidget {
  const SettingsControl({super.key});

  String get name;
  T get value;

  SettingsControl<T> withTitle(String title) {
    return _TitledSettingsControl(
      title: title,
      child: this,
    );
  }
}

class _TitledSettingsControl<T> extends SettingsControl<T> {
  final String title;
  final SettingsControl<T> child;

  const _TitledSettingsControl({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return _SettingsTitled(
      title: title,
      child: child,
    );
  }

  @override
  String get name => child.name;

  @override
  T get value => child.value;
}

class _SettingsTitled extends StatelessWidget {
  final String title;
  final Widget child;

  const _SettingsTitled({super.key, required this.title, required this.child});

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
