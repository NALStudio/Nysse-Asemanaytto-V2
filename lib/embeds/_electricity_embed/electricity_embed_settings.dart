import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/_electricity_embed/electricity_embed_widget.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

class ElectricityEmbedSettings extends EmbedSettings<ElectricityEmbed> {
  const ElectricityEmbedSettings();

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
    covariant ElectricityEmbedSettings defaultSettings,
  ) =>
      ElectricityEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );

  @override
  String serialize() {
    return "";
  }

  @override
  void deserialize(String serialized) {}
}

class ElectricityEmbedSettingsForm extends EmbedSettingsForm {
  ElectricityEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Settings."),
    );
  }

  @override
  Color get displayColor => Colors.yellow;

  @override
  String get displayName => "Test Embed";
}
