import 'package:flutter/material.dart';

class SettingsSwitchFormField extends FormField<bool> {
  final String? titleText;
  final String? subtitleText;

  const SettingsSwitchFormField({
    super.key,
    required super.initialValue,
    this.titleText,
    this.subtitleText,
    super.onSaved,
    super.validator,
  }) : super(builder: _buildFormField);
}

Widget _buildFormField(FormFieldState<bool> state) {
  final SettingsSwitchFormField widget =
      state.widget as SettingsSwitchFormField;

  return SwitchListTile(
    value: state.value!,
    onChanged: (value) => state.didChange(value),
    title: widget.titleText != null ? Text(widget.titleText!) : null,
    subtitle: widget.subtitleText != null ? Text(widget.subtitleText!) : null,
  );
}
