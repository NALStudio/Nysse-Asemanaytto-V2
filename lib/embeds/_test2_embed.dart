import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

class Test2Embed extends Embed {
  const Test2Embed({required super.name});

  @override
  EmbedWidgetMixin<Test2Embed> createEmbed(
          covariant Test2EmbedSettings settings) =>
      Test2EmbedWidget(settings: settings);

  @override
  EmbedSettings<Test2Embed> deserializeSettings(String? serialized) =>
      Test2EmbedSettings.deserialize(serialized);
}

class Test2EmbedWidget extends StatelessWidget
    implements EmbedWidgetMixin<Test2Embed> {
  final Test2EmbedSettings settings;

  const Test2EmbedWidget({super.key, required this.settings});

  @override
  Duration? getDuration() => const Duration(seconds: 5);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.orange,
      child: Text(
        settings.text,
        style: const TextStyle(fontSize: 64),
      ),
    );
  }

  @override
  void onDisable() {}

  @override
  void onEnable() {}
}

class Test2EmbedSettings extends EmbedSettings<Test2Embed> {
  String text;

  Test2EmbedSettings.deserialize(super.serialized)
      : text = serialized ?? "test",
        super.deserialize();

  @override
  EmbedSettingsForm<Test2EmbedSettings> createForm() =>
      Test2EmbedForm(settingsParent: this);

  @override
  String serialize() => text;
}

class Test2EmbedForm extends EmbedSettingsForm<Test2EmbedSettings> {
  Test2EmbedForm({required super.settingsParent});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: settingsParent.text,
      onSaved: (newValue) => settingsParent.text = newValue!,
    );
  }

  @override
  Color get displayColor => Colors.orange;

  @override
  String get displayName => "Test 2 Embed";
}
