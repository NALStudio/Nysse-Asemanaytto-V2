import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';

import 'embeds.dart';

class TestEmbed extends Embed {
  const TestEmbed({required super.name});

  @override
  EmbedWidgetMixin<TestEmbed> createEmbed(TestEmbedSettings settings) =>
      TestEmbedWidget();

  @override
  EmbedSettings<TestEmbed> deserializeSettings(String? serialized) =>
      TestEmbedSettings.deserialize(serialized);
}

class TestEmbedWidget extends StatelessWidget with EmbedWidgetMixin<TestEmbed> {
  TestEmbedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.red,
      child: Center(
        child: ClockWidget(
          textStyle: TextStyle(fontSize: 128, fontWeight: FontWeight.bold),
          displaySeconds: true,
        ),
      ),
    );
  }

  @override
  Duration? getDuration() => const Duration(seconds: 15);

  @override
  void onDisable() {}

  @override
  void onEnable() {}
}

class TestEmbedSettings extends EmbedSettings<TestEmbed> {
  TestEmbedSettings.deserialize(super.serialized) : super.deserialize();

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm() =>
      TestEmbedSettingsForm(settingsParent: this);

  @override
  String serialize() {
    return "";
  }
}

class TestEmbedSettingsForm extends EmbedSettingsForm {
  TestEmbedSettingsForm({required super.settingsParent});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("No Settings."),
    );
  }

  @override
  Color get displayColor => Colors.red;

  @override
  String get displayName => "Test Embed";
}
