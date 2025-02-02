import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:nysse_asemanaytto/settings/_embeds_form_field.dart';
import 'package:nysse_asemanaytto/settings/_settings_darken_slider_form_field.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';
import 'package:nysse_asemanaytto/settings/settings_switch_form_field.dart';

class MainSettings extends SettingsForm {
  @override
  final displayName = "Asemanäyttö";

  @override
  final displayColor = NysseColors.mediumBlue;

  int? _stoptimesCount;

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);
    _stoptimesCount ??= config.stoptimesCount;

    const List<DigitransitRoutingEndpoint> endpoints = [
      DigitransitRoutingEndpoint.waltti,
      DigitransitRoutingEndpoint.hsl,
      DigitransitRoutingEndpoint.finland,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<DigitransitRoutingEndpoint>(
          value: config.endpoint,
          items: endpoints
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e == Config.defaultConfig.endpoint
                        ? "${e.value} (default)"
                        : e.value,
                  ),
                ),
              )
              .toList(growable: false),
          decoration: const InputDecoration(labelText: "Endpoint"),
          onChanged: (value) {},
          onSaved: (newValue) => config.endpoint = newValue,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: "Digitransit API Key",
          ),
          initialValue: config.digitransitSubscriptionKey,
          onSaved: (newValue) => config.digitransitSubscriptionKey = newValue,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Stop ID",
            hintText: Config.defaultConfig.stopId.id,
          ),
          initialValue: config.stopId.id,
          onSaved: (newValue) {
            if (newValue?.isEmpty == true) {
              config.stopId = null; // empty = null
            } else {
              config.stopId = newValue != null ? GtfsId(newValue) : null;
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SettingsDarkenSliderFormField(
            initialValue: config.screenDarkenStrength,
            onSaved: (newValue) => config.screenDarkenStrength = newValue,
          ),
        ),
        SettingsSwitchFormField(
          initialValue: config.digitransitMqttProviderEnabled,
          titleText: "MQTT Provider",
          subtitleText:
              "Enable MQTT Provider for enhanced embed functionality.",
          onSaved: (newValue) =>
              config.digitransitMqttProviderEnabled = newValue!,
        ),
        const SizedBox(height: 16),
        Text(
          "Stoptime count: $_stoptimesCount",
          style: const TextStyle(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 4),
        EmbedsFormField(
          initialValue: UnmodifiableListView(
            config.embeds.map((e) => e.embed).toList(),
          ),
          onChanged: (list) {
            if (list != null && list.isNotEmpty) {
              _stoptimesCount = 6;
            } else {
              _stoptimesCount = 10;
            }
          },
          onSaved: (newValue) {
            if (newValue != null && newValue.isNotEmpty) {
              config.setEmbeds(newValue);
              config.stoptimesCount = 6;
            } else {
              config.setEmbeds(List.empty());
              config.stoptimesCount = 10;
            }
          },
        ),
      ],
    );
  }
}
