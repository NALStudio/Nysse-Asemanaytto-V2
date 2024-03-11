import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/embed.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/embed.dart';
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
  EmbedSettings createDefaultSettings();

  @override
  operator ==(Object other) {
    return other is Embed && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;

  static const List<Embed> allEmbeds = [
    MapVehiclesEmbed(name: "mapVehicles"),
    MapLinesEmbed(name: "mapLines"),
    TestEmbed(name: "test"),
    Test2Embed(name: "test2"),
  ];
}

mixin EmbedWidgetMixin<T extends Embed> on Widget {
  /// Return null or [Duration.zero] to skip displaying this embed.
  Duration? getDuration();

  void onEnable();
  void onDisable();
}

abstract class EmbedSettings<T extends Embed> {
  const EmbedSettings();

  String serialize();
  // Deserialize string into this instance of EmbedSettings.
  void deserialize(String serialized);

  @factory
  EmbedSettingsForm createForm(covariant EmbedSettings defaultSettings);
}

abstract class EmbedSettingsForm<T extends EmbedSettings> extends SettingsForm {
  final T defaultSettings;
  final T parentSettings;

  EmbedSettingsForm({
    required this.parentSettings,
    required this.defaultSettings,
  });
}
