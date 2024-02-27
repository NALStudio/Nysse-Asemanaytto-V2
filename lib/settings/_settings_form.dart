import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';

class MainSettings extends SettingsForm {
  @override
  final displayName = "Asemanäyttö";

  @override
  final displayColor = NysseColors.mediumBlue;

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

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
            hintText: Config.defaultConfig.stopId.value,
          ),
          initialValue: config.stopId.value,
          onSaved: (newValue) {
            if (newValue?.isEmpty == true) {
              config.stopId = null; // empty = null
            } else {
              config.stopId = newValue != null ? StopId(newValue) : null;
            }
          },
        ),
        const SizedBox(height: 16),
        Text("Stoptime count: ${config.stoptimesCount}"),
      ],
    );
  }
}
