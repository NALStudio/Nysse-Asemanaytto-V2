import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/clock_embed.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';

abstract class Embed {
  final String name;

  const Embed({required this.name});

  @factory
  EmbedWidget createEmbed(covariant EmbedSettings settings);

  @factory
  EmbedSettings deserializeSettings(String? serialized);

  @override
  operator ==(Object other) {
    return other is Embed && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  static const List<Embed> allEmbeds = [
    ClockEmbed(name: "clock"),
  ];
}

abstract class EmbedWidget<T extends Embed> {
  final EmbedSettings<Embed> settings;

  EmbedWidget({required this.settings});

  Widget build(BuildContext context);
}

abstract class EmbedSettings<T extends Embed> {
  String serialize();

  EmbedSettings.deserialize(String? serialized);

  @factory
  EmbedSettingsForm createForm();
}

abstract class EmbedSettingsForm<T extends EmbedSettings> extends SettingsForm {
  final T settings;

  EmbedSettingsForm({required this.settings});
}
