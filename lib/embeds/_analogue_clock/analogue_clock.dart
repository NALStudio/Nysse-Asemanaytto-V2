import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/helpers/helpers.dart';
import 'package:nysse_asemanaytto/settings/settings_switch_form_field.dart';
import '../embeds.dart';
import '_painter.dart';
import 'dart:math' as math;

final math.Random _random = math.Random();

GlobalKey<_ClockEmbedWidgetState> _clockKey = GlobalKey();

class ClockEmbed extends Embed {
  const ClockEmbed({required super.name});

  @override
  EmbedWidgetMixin<ClockEmbed> createEmbed(ClockEmbedSettings settings) =>
      ClockEmbedWidget(key: _clockKey, settings: settings);

  @override
  EmbedSettings<Embed> createDefaultSettings() =>
      ClockEmbedSettings(showDigitalClock: false);
}

class ClockEmbedWidget extends StatefulWidget
    with EmbedWidgetMixin<ClockEmbed> {
  final ClockEmbedSettings settings;

  ClockEmbedWidget({super.key, required this.settings});

  @override
  State<ClockEmbedWidget> createState() => _ClockEmbedWidgetState();

  @override
  Duration? getDuration() {
    return durationFromDouble(
      seconds: 10 + (10 * _random.nextDouble()),
    );
  }

  @override
  void onDisable() {
    _clockKey.currentState?.onDisable();
  }

  @override
  void onEnable() {
    _clockKey.currentState?.onEnable();
  }
}

class _ClockEmbedWidgetState extends State<ClockEmbedWidget>
    with SingleTickerProviderStateMixin {
  late Ticker ticker;
  Duration? enabledTime;
  late Duration currentTime;

  @override
  void initState() {
    super.initState();

    ticker = Ticker(onTick);
    currentTime = Duration.zero;
  }

  void onEnable() {
    ticker.start();

    final now = DateTime.now();
    enabledTime = Duration(
      hours: now.hour,
      minutes: now.minute,
      seconds: now.second,
      milliseconds: now.millisecond,
      microseconds: now.microsecond,
    );
  }

  void onDisable() {
    ticker.stop();
    enabledTime = null;
  }

  // elapsed is the time after ticker.start()
  // basically time after enabledTime
  // we calculate the sum to set for the current time to save on spamming the system with DateTime.now() calls
  // the inaccuracy shouldn't be visible in the short time this embed is visible
  void onTick(Duration elapsed) {
    setState(() {
      currentTime = enabledTime! + elapsed;
    });
  }

  @override
  void dispose() {
    ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(Layout.of(context).padding),
      child: CustomPaint(
        painter: AnalogClockPainter(
          secondsAfterMidnight:
              currentTime.inMicroseconds / Duration.microsecondsPerSecond,
          showDigitalClock: widget.settings.showDigitalClock,
        ),
      ),
    );
  }
}

class ClockEmbedSettings extends EmbedSettings<ClockEmbed> {
  bool showDigitalClock;

  ClockEmbedSettings({required this.showDigitalClock});

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
    covariant ClockEmbedSettings defaultSettings,
  ) =>
      ClockEmbedSettingsForm(
        parentSettings: this,
        defaultSettings: defaultSettings,
      );

  @override
  String serialize() {
    final Map<String, dynamic> map = {
      "showDigitalClock": showDigitalClock,
    };
    return json.encode(map);
  }

  @override
  void deserialize(String serialized) {
    // backwards compat for when clock embed didn't have settings
    if (serialized.isEmpty) return;

    final Map<String, dynamic> map = json.decode(serialized);

    showDigitalClock = map["showDigitalClock"];
  }
}

class ClockEmbedSettingsForm extends EmbedSettingsForm<ClockEmbedSettings> {
  ClockEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsSwitchFormField(
          initialValue: parentSettings.showDigitalClock,
          titleText: "Show Digital Clock",
          onSaved: (newValue) => parentSettings.showDigitalClock = newValue!,
        ),
      ],
    );
  }

  @override
  Color get displayColor => Colors.redAccent;

  @override
  String get displayName => "Clock Embed";
}
