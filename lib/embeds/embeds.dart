import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/_map_embed.dart';
import 'package:nysse_asemanaytto/embeds/_test2_embed.dart';
import 'package:nysse_asemanaytto/embeds/_test_embed.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';

/// DO NOT INSTANTIATE OUTSIDE OF [Embed.allEmbeds]
abstract class Embed {
  final String name;

  const Embed({required this.name});

  @factory
  EmbedWidgetMixin createEmbed(covariant EmbedSettings settings);

  @factory
  EmbedSettings deserializeSettings(String? serialized);

  @override
  operator ==(Object other) {
    return other is Embed && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  static const List<Embed> allEmbeds = [
    MapEmbed(name: "map"),
    TestEmbed(name: "test"),
    Test2Embed(name: "test2"),
  ];
}

mixin EmbedWidgetMixin<T extends Embed> on Widget {
  Duration? getDuration();

  void onEnable();
  void onDisable();
}

abstract class EmbedSettings<T extends Embed> {
  String serialize();

  EmbedSettings.deserialize(String? serialized);

  @factory
  EmbedSettingsForm createForm();
}

abstract class EmbedSettingsForm<T extends EmbedSettings> extends SettingsForm {
  final T settingsParent;

  EmbedSettingsForm({required this.settingsParent});
}
