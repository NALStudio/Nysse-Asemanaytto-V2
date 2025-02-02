import 'package:flutter/material.dart';

class SettingsDarkenSliderFormField extends FormField<double?> {
  const SettingsDarkenSliderFormField({
    super.key,
    super.initialValue,
    super.onSaved,
  }) : super(
          builder: _buildFormField,
        );

  static Widget _buildFormField(FormFieldState<double?> state) {
    final theme = Theme.of(state.context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Auto Dim Screen",
          style: theme.listTileTheme.titleTextStyle,
        ),
        Text(
          "Enable automatic dimming capability for enhanced embed functionality.",
          style: theme.listTileTheme.subtitleTextStyle,
        ),
        Slider(
          value: state.value ?? 0,
          label: state.value != null
              ? "${(state.value! * 100).round()} %"
              : "Disabled",
          min: 0,
          max: 0.9,
          divisions: 9,
          onChanged: (x) => state.didChange(_convertValue(x)),
        ),
      ],
    );
  }

  static double? _convertValue(double value) {
    if (value == 0) {
      return null;
    } else {
      return value;
    }
  }
}
