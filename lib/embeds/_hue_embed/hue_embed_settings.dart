import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_hue_embed/_hue_onboarding.dart';
import 'package:nysse_asemanaytto/philips_hue/_bridge.dart';
import 'package:nysse_asemanaytto/philips_hue/_icons.dart';

class HueEmbedSettings extends EmbedSettings {
  HueBridge? bridge;

  HueEmbedSettings({required this.bridge});

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
          covariant HueEmbedSettings defaultSettings) =>
      _HueEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );

  @override
  void deserialize(String serialized) {
    final Map<String, dynamic> data = json.decode(serialized);

    final Map<String, dynamic>? bridge = data["bridge"];
    if (bridge != null) {
      this.bridge = HueBridge.fromJson(bridge);
    } else {
      this.bridge = null;
    }
  }

  @override
  String serialize() {
    final Map<String, dynamic> data = {"bridge": bridge?.toJson()};
    return json.encode(data);
  }
}

class _HueEmbedSettingsForm extends EmbedSettingsForm<HueEmbedSettings> {
  _HueEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField<HueBridge?>(
        initialValue: parentSettings.bridge,
        onSaved: (newValue) => parentSettings.bridge = newValue,
        builder: (field) {
          return Row(
            spacing: 24,
            children: [
              ..._buildBridgeDisplay(context, field.value),
              TextButton(
                onPressed: () => changeBridge(context, field),
                child: Text("Change"),
              )
            ],
          );
        },
      ),
    );
  }

  Iterable<Widget> _buildBridgeDisplay(
    BuildContext context,
    HueBridge? bridge,
  ) sync* {
    if (bridge != null) {
      yield Icon(HueIcons.bridge);
    }

    yield Text(
      bridge != null ? "Bridge at ${bridge.ipAddress}" : "No bridge selected.",
      style: DefaultTextStyle.of(context).style.copyWith(
            color: bridge == null ? Colors.grey : null,
          ),
    );
  }

  Future changeBridge(
    BuildContext context,
    FormFieldState<HueBridge?> state,
  ) async {
    HueBridge? bridge = await showDialog(
      context: context,
      builder: (context) => Dialog(
        child: PhilipsHueOnboardingDialog(),
      ),
    );
    state.didChange(bridge);
  }

  @override
  Color get displayColor => Colors.purple;

  @override
  String get displayName => "Philips Hue Embed";
}
