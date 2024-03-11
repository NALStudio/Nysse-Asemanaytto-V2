import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/embed.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/settings/settings_switch_form_field.dart';

class MapLinesEmbedSettings extends EmbedSettings<MapLinesEmbed> {
  MapEmbedTileProvider tileProvider;
  bool showStops;
  bool showRouteInfo;

  MapLinesEmbedSettings({
    required this.tileProvider,
    required this.showStops,
    required this.showRouteInfo,
  });

  @override
  void deserialize(String serialized) {
    final Map<String, dynamic> map = json.decode(serialized);

    final String tileProviderStr = map["tileProvider"];
    tileProvider = MapEmbedTileProvider.values
        .firstWhere((element) => element.name == tileProviderStr);

    final bool? showStops = map["showStops"];
    if (showStops != null) {
      this.showStops = showStops;
    }

    final bool? showRouteInfo = map["showRouteInfo"];
    if (showRouteInfo != null) {
      this.showRouteInfo = showRouteInfo;
    }
  }

  @override
  String serialize() {
    final Map<String, dynamic> map = {
      "tileProvider": tileProvider.name,
      "showStops": showStops,
      "showRouteInfo": showRouteInfo,
    };
    return json.encode(map);
  }

  @override
  EmbedSettingsForm<MapLinesEmbedSettings> createForm(
    covariant MapLinesEmbedSettings defaultSettings,
  ) =>
      MapLinesEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );
}

class MapLinesEmbedSettingsForm
    extends EmbedSettingsForm<MapLinesEmbedSettings> {
  MapEmbedTileProvider? _tileProviderSetting;

  MapLinesEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  String _formatEnumName(Enum value) => snakeCase2Sentence(value.name);

  List<DropdownMenuItem<T?>> _buildDropdownMenuItems<T extends Enum>(
    List<T> enumValues, {
    required T defaultValue,
    required Map<T, String>? tooltips,
  }) {
    return enumValues.map((e) {
      String formattedName = _formatEnumName(e);
      if (e == defaultValue) {
        formattedName += " (default)";
      }

      Widget text = Text(formattedName);

      String? tip = tooltips?[e];
      if (tip != null) {
        text = Tooltip(
          message: tip,
          child: text,
        );
      }

      return DropdownMenuItem(
        value: e,
        child: text,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    _tileProviderSetting ??= parentSettings.tileProvider;

    return Column(
      children: [
        DropdownButtonFormField<MapEmbedTileProvider?>(
          decoration: InputDecoration(
            labelText: "Tile Provider",
            hintText: _formatEnumName(defaultSettings.tileProvider),
          ),
          items: _buildDropdownMenuItems(
            MapEmbedTileProvider.values,
            defaultValue: defaultSettings.tileProvider,
            tooltips: null,
          ),
          value: _tileProviderSetting,
          onChanged: (value) => _tileProviderSetting = value,
          onSaved: (newValue) => parentSettings.tileProvider =
              newValue ?? defaultSettings.tileProvider,
        ),
        SettingsSwitchFormField(
          initialValue: parentSettings.showStops,
          titleText: "Show Line Stops",
          onSaved: (newValue) => parentSettings.showStops = newValue!,
        ),
        SettingsSwitchFormField(
          initialValue: parentSettings.showRouteInfo,
          titleText: "Show Route Info",
          onSaved: (newValue) => parentSettings.showRouteInfo = newValue!,
        ),
      ],
    );
  }

  @override
  Color get displayColor => Colors.green;

  @override
  String get displayName => "Map Embed";
}
