import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/helpers.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_vehicles_embed/embed.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';

enum MapEmbedCameraFit {
  fixed,
  fitArrivingVehicles,
  fitVehicles,
}

const Map<MapEmbedCameraFit, String> _mapEmbedCameraFitNotes = {
  MapEmbedCameraFit.fitVehicles:
      "Only the vehicle positions received during 'Wait before animation' are considered when fitting the camera.",
  MapEmbedCameraFit.fitArrivingVehicles:
      "Only the vehicle positions received during 'Wait before animation' are considered when fitting the camera.",
};

enum MapEmbedVehicles {
  allRoutes,
  scheduledTrips,
  arrivingOnly,
}

const Map<MapEmbedVehicles, String> _mapEmbedVehiclesNotes = {
  MapEmbedVehicles.allRoutes:
      "This setting may have performance issues on stops with multiple routes.",
};

class MapEmbedSettings extends EmbedSettings<MapVehiclesEmbed> {
  double beforeAnimationSeconds;
  double animationDurationSeconds;
  double afterAnimationSeconds;

  MapEmbedTileProvider tileProvider;
  MapEmbedCameraFit cameraFit;
  MapEmbedVehicles vehicles;

  MapEmbedSettings({
    required this.beforeAnimationSeconds,
    required this.animationDurationSeconds,
    required this.afterAnimationSeconds,
    required this.tileProvider,
    required this.cameraFit,
    required this.vehicles,
  });

  @override
  void deserialize(String serialized) {
    final Map<String, dynamic> map = json.decode(serialized);
    beforeAnimationSeconds = (map["waitBeforeAnim"] as num).toDouble();
    animationDurationSeconds = (map["animDuration"] as num).toDouble();
    afterAnimationSeconds = (map["waitAfterAnim"] as num).toDouble();

    final String tileProviderStr = map["tileProvider"];
    final String cameraFitStr = map["cameraFit"];
    final String vehiclesStr = map["vehicles"];
    tileProvider = MapEmbedTileProvider.values
        .firstWhere((element) => element.name == tileProviderStr);
    cameraFit = MapEmbedCameraFit.values
        .firstWhere((element) => element.name == cameraFitStr);
    vehicles = MapEmbedVehicles.values
        .firstWhere((element) => element.name == vehiclesStr);
    // as num cast so that if there is an integer in the json,
    // it is still saved as double. (aka doesn't crash)
  }

  @override
  String serialize() {
    final Map<String, dynamic> map = {
      "waitBeforeAnim": beforeAnimationSeconds,
      "animDuration": animationDurationSeconds,
      "waitAfterAnim": afterAnimationSeconds,
      "tileProvider": tileProvider.name,
      "cameraFit": cameraFit.name,
      "vehicles": vehicles.name,
    };
    return json.encode(map);
  }

  @override
  EmbedSettingsForm<MapEmbedSettings> createForm(
    covariant MapEmbedSettings defaultSettings,
  ) =>
      MapEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );
}

class MapEmbedSettingsForm extends EmbedSettingsForm<MapEmbedSettings> {
  MapEmbedTileProvider? _tileProviderSetting;
  MapEmbedCameraFit? _cameraFitSetting;
  MapEmbedVehicles? _vehicleSetting;

  MapEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  String? _formatValue(num number) {
    String suffix;
    if (number == 1) {
      suffix = "second";
    } else {
      suffix = "seconds";
    }

    return "$number $suffix";
  }

  double? _tryParseDouble(String? value) {
    if (value == null) return null;

    String? number = value.split(' ').firstOrNull;
    if (number == null) return null;

    return double.tryParse(number);
  }

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

  String? _doubleValidate(
    String? value, {
    bool allowNegativeNumbers = false,
  }) {
    if (value?.isNotEmpty != true) {
      return null;
    }

    final double? number = _tryParseDouble(value);
    if (number == null) {
      return "Not a valid decimal number.";
    }
    if (!allowNegativeNumbers && number < 0) {
      return "Value cannot be negative.";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    _tileProviderSetting ??= parentSettings.tileProvider;
    _cameraFitSetting ??= parentSettings.cameraFit;
    _vehicleSetting ??= parentSettings.vehicles;

    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Wait before animation",
            hintText: _formatValue(defaultSettings.beforeAnimationSeconds),
          ),
          initialValue: _formatValue(parentSettings.beforeAnimationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.beforeAnimationSeconds =
                  defaultSettings.beforeAnimationSeconds;
            } else {
              parentSettings.beforeAnimationSeconds =
                  _tryParseDouble(newValue)!;
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Animation duration",
            hintText: _formatValue(defaultSettings.animationDurationSeconds),
          ),
          initialValue: _formatValue(parentSettings.animationDurationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.animationDurationSeconds =
                  defaultSettings.animationDurationSeconds;
            } else {
              parentSettings.animationDurationSeconds =
                  _tryParseDouble(newValue)!;
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Wait after animation",
            hintText: _formatValue(defaultSettings.afterAnimationSeconds),
          ),
          initialValue: _formatValue(parentSettings.afterAnimationSeconds),
          validator: (value) => _doubleValidate(value),
          onSaved: (newValue) {
            if (newValue == null || newValue.isEmpty) {
              parentSettings.afterAnimationSeconds =
                  defaultSettings.afterAnimationSeconds;
            } else {
              parentSettings.afterAnimationSeconds = _tryParseDouble(newValue)!;
            }
          },
        ),
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
        DropdownButtonFormField<MapEmbedCameraFit?>(
          decoration: InputDecoration(
            labelText: "Camera Fit",
            hintText: _formatEnumName(defaultSettings.vehicles),
          ),
          items: _buildDropdownMenuItems(
            MapEmbedCameraFit.values,
            defaultValue: defaultSettings.cameraFit,
            tooltips: _mapEmbedCameraFitNotes,
          ),
          value: _cameraFitSetting,
          onChanged: (value) => _cameraFitSetting = value,
          onSaved: (newValue) =>
              parentSettings.cameraFit = newValue ?? defaultSettings.cameraFit,
        ),
        DropdownButtonFormField<MapEmbedVehicles?>(
          decoration: InputDecoration(
            labelText: "Vehicles",
            hintText: _formatEnumName(defaultSettings.vehicles),
          ),
          items: _buildDropdownMenuItems(
            MapEmbedVehicles.values,
            defaultValue: defaultSettings.vehicles,
            tooltips: _mapEmbedVehiclesNotes,
          ),
          value: _vehicleSetting,
          onChanged: (value) => _vehicleSetting = value,
          onSaved: (newValue) =>
              parentSettings.vehicles = newValue ?? defaultSettings.vehicles,
        ),
      ],
    );
  }

  @override
  Color get displayColor => Colors.green;

  @override
  String get displayName => "Map Embed";
}
