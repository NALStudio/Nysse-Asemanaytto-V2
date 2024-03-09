import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/clock.dart';

import 'embeds.dart';

class TestEmbed extends Embed {
  const TestEmbed({required super.name});

  @override
  EmbedWidgetMixin<TestEmbed> createEmbed(TestEmbedSettings settings) =>
      TestEmbedWidget();

  @override
  EmbedSettings<Embed> createDefaultSettings() => const TestEmbedSettings();
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
  const TestEmbedSettings();

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
    covariant TestEmbedSettings defaultSettings,
  ) =>
      TestEmbedSettingsForm(
          parentSettings: this, defaultSettings: defaultSettings);

  @override
  String serialize() {
    return "";
  }

  @override
  void deserialize(String serialized) {}
}

class TestEmbedSettingsForm extends EmbedSettingsForm {
  TestEmbedSettingsForm({
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
  Color get displayColor => Colors.red;

  @override
  String get displayName => "Test Embed";
}
