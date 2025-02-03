import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/screen_darken.dart';

class SettingsDarkenSlider extends StatefulWidget {
  final double? initialValue;
  final void Function(double? value)? onSaved;

  const SettingsDarkenSlider({
    super.key,
    this.initialValue,
    this.onSaved,
  });

  @override
  State<SettingsDarkenSlider> createState() => _SettingsDarkenSliderState();
}

class _SettingsDarkenSliderState extends State<SettingsDarkenSlider> {
  ScreenDarkenHandle? _darkenHandle;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _darkenHandle = ScreenDarkenWidget.maybeOf(context)?.createHandle();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<double>(
      initialValue: widget.initialValue,
      onSaved: widget.onSaved,
      builder: _buildFormField,
    );
  }

  Widget _buildFormField(FormFieldState<double?> state) {
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
          onChanged: (value) {
            _updateDarken(value);
            state.didChange(_convertValue(value));
          },
          onChangeStart: _updateDarken,
          onChangeEnd: (value) => _darkenHandle?.deactivate(),
        ),
      ],
    );
  }

  void _updateDarken(double value) {
    double? x = _convertValue(value);
    if (x != null) {
      _darkenHandle?.activate(strength: x);
    } else {
      _darkenHandle?.deactivate();
    }
  }

  static double? _convertValue(double value) {
    if (value == 0) {
      return null;
    } else {
      return value;
    }
  }
}
