import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/settings/components/settings_titled.dart';

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
    return SettingsTitled(
      title: title,
      child: child,
    );
  }

  @override
  String get name => child.name;

  @override
  T get value => child.value;
}
