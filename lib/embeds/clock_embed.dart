import 'package:flutter/material.dart';

import 'embeds.dart';

class ClockEmbed extends Embed {
  ClockEmbed({required super.name});

  @override
  EmbedWidget<Embed> createEmbed(covariant ClockEmbedSettings settings) =>
      ClockEmbedWidget(settings: settings);

  @override
  EmbedSettings<Embed> deserializeSettings(String? serialized) =>
      ClockEmbedSettings.deserialize(serialized);
}

class ClockEmbedSettings extends EmbedSettings {
  @override
  String serialize() {
    return "";
  }

  ClockEmbedSettings.deserialize(super.serialized) : super.deserialize();

  @override
  EmbedSettingsForm<ClockEmbedSettings> createForm() =>
      ClockEmbedForm(settings: this);
}

class ClockEmbedForm extends EmbedSettingsForm<ClockEmbedSettings> {
  ClockEmbedForm({required super.settings});

  @override
  String get displayName => "Clock embed";
  @override
  Color get displayColor => Colors.purple;

  @override
  Widget build(BuildContext context) {
    return Text(displayName);
  }
}

class ClockEmbedWidget extends EmbedWidget<ClockEmbed> {
  ClockEmbedWidget({required super.settings});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.red,
      child: Text("Testi"),
    );
  }
}
