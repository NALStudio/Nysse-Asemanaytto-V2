import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/embeds/_analogue_clock/analogue_clock.dart';
import 'package:nysse_asemanaytto/embeds/_electricity_embed/electricity_embed.dart';
import 'package:nysse_asemanaytto/embeds/_hue_embed/hue_embed.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/embed.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/embed.dart';
import 'package:nysse_asemanaytto/embeds/_alerts_embed.dart';
import 'package:nysse_asemanaytto/embeds/_weather_embed/weather_embed.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';
import '_electricity_production/electricity_production_embed.dart';

/// DO NOT INSTANTIATE OUTSIDE OF [Embed.allEmbeds]
@immutable
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
    AlertsEmbed(name: "alerts"),
    MapVehiclesEmbed(name: "mapVehicles"),
    MapLinesEmbed(name: "mapLines"),
    WeatherEmbed(name: "weather"),
    ElectricityEmbed(name: "electricityPrices"),
    ElectricityProductionEmbed(name: "electricityProduction"),
    ClockEmbed(name: "clock"),
    HueEmbed(name: "hue"),
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

  static Widget buildNoSettingsWidget(BuildContext context) {
    return const Center(
      child: Text("No Settings."),
    );
  }
}
