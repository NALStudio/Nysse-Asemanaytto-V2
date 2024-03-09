import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

class Test2Embed extends Embed {
  const Test2Embed({required super.name});

  @override
  EmbedWidgetMixin<Test2Embed> createEmbed(
          covariant Test2EmbedSettings settings) =>
      Test2EmbedWidget(settings: settings);

  @override
  EmbedSettings<Embed> createDefaultSettings() =>
      Test2EmbedSettings(text: "testiteksti");
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

  Test2EmbedSettings({required this.text});

  @override
  EmbedSettingsForm<Test2EmbedSettings> createForm(
    covariant Test2EmbedSettings defaultSettings,
  ) =>
      Test2EmbedForm(parentSettings: this, defaultSettings: defaultSettings);

  @override
  String serialize() => text;

  @override
  void deserialize(String serialized) => text = serialized;
}

class Test2EmbedForm extends EmbedSettingsForm<Test2EmbedSettings> {
  Test2EmbedForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: parentSettings.text,
      decoration: InputDecoration(hintText: defaultSettings.text),
      onSaved: (newValue) {
        if (newValue?.isNotEmpty == true) {
          parentSettings.text = newValue!;
        } else {
          parentSettings.text = defaultSettings.text;
        }
      },
    );
  }

  @override
  Color get displayColor => Colors.orange;

  @override
  String get displayName => "Test 2 Embed";
}
