import 'package:flutter/material.dart';

class SettingsSwitchFormField extends FormField<bool> {
  final String? titleText;
  final String? subtitleText;

  final bool disabled;
  final bool? disabledValue;

  const SettingsSwitchFormField({
    super.key,
    required super.initialValue,
    this.titleText,
    this.subtitleText,
    this.disabled = false,
    this.disabledValue,
    super.onSaved,
    super.validator,
  }) : super(builder: _buildFormField);
}

Widget _buildFormField(FormFieldState<bool> state) {
  final SettingsSwitchFormField widget =
      state.widget as SettingsSwitchFormField;

  bool value = state.value!;
  if (widget.disabled && widget.disabledValue != null) {
    value = widget.disabledValue!;
  }

  return SwitchListTile(
    value: value,
    onChanged: !widget.disabled ? (value) => state.didChange(value) : null,
    title: widget.titleText != null ? Text(widget.titleText!) : null,
    subtitle: widget.subtitleText != null ? Text(widget.subtitleText!) : null,
  );
}
