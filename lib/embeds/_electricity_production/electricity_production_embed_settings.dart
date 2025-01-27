import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/settings/settings_switch_form_field.dart';

import 'electricity_production_embed.dart';

class ElectricityProductionEmbedSettings
    extends EmbedSettings<ElectricityProductionEmbed> {
  String? apiKey;
  double pollRateMinutes;
  bool showPieChartTitles;

  ElectricityProductionEmbedSettings({
    required this.apiKey,
    required this.pollRateMinutes,
    required this.showPieChartTitles,
  });

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
    covariant ElectricityProductionEmbedSettings defaultSettings,
  ) =>
      ElectricityProductionEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );

  @override
  String serialize() {
    final Map<String, dynamic> map = {
      "apiKey": apiKey,
      "pollRate": pollRateMinutes,
      "showTitles": showPieChartTitles,
    };
    return json.encode(map);
  }

  @override
  void deserialize(String serialized) {
    final Map<String, dynamic> map = json.decode(serialized);

    apiKey = map["apiKey"];

    final double? pollRate = map["pollRate"];
    if (pollRate != null) {
      pollRateMinutes = pollRate;
    }

    final bool? showTitle = map["showTitles"];
    if (showTitle != null) {
      showPieChartTitles = showTitle;
    }
  }
}

class ElectricityProductionEmbedSettingsForm
    extends EmbedSettingsForm<ElectricityProductionEmbedSettings> {
  ElectricityProductionEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  String? _formatValue(num number) {
    String suffix;
    if (number == 1) {
      suffix = "minute";
    } else {
      suffix = "minutes";
    }

    return "$number $suffix";
  }

  double? _tryParseDouble(String? value) {
    if (value == null) return null;

    String? number = value.split(' ').firstOrNull;
    if (number == null) return null;

    return double.tryParse(number);
  }

  /// min and max are inclusive
  String? _doubleValidate(
    String? value, {
    double? minValue = 0,
    double? maxValue,
  }) {
    if (value?.isNotEmpty != true) {
      return null;
    }

    final double? number = _tryParseDouble(value);
    if (number == null) {
      return "Not a valid decimal number.";
    }
    if (minValue != null && number < minValue) {
      return "Value cannot be less than $minValue";
    }
    if (maxValue != null && number > maxValue) {
      return "Value cannot be more than $maxValue";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: parentSettings.apiKey,
          decoration: const InputDecoration(labelText: "Fingrid API Key"),
          onSaved: (newValue) {
            if (newValue?.isNotEmpty == true) {
              parentSettings.apiKey = newValue;
            } else {
              parentSettings.apiKey = null;
            }
          },
        ),
        TextFormField(
          initialValue: _formatValue(parentSettings.pollRateMinutes),
          decoration: InputDecoration(
            labelText: "Poll Rate",
            hintText: _formatValue(defaultSettings.pollRateMinutes),
          ),
          validator: (value) => _doubleValidate(value, minValue: 1),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.pollRateMinutes = defaultSettings.pollRateMinutes;
            } else {
              parentSettings.pollRateMinutes = _tryParseDouble(newValue)!;
            }
          },
        ),
        SettingsSwitchFormField(
          initialValue: parentSettings.showPieChartTitles,
          titleText: "Show Pie Chart Titles",
          subtitleText: "This setting might not update immediately.",
          onSaved: (newValue) => parentSettings.showPieChartTitles = newValue!,
        )
      ],
    );
  }

  @override
  String get displayName => "Electricity Production Embed";

  @override
  Color get displayColor => Colors.orange;
}
