import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/routes.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:nysse_asemanaytto/settings/components/settings_titled.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.keyboard.addHandler(_onKey);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.keyboard.removeHandler(_onKey);
    super.dispose();
  }

  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent &&
        (event.physicalKey == PhysicalKeyboardKey.f1 ||
            event.physicalKey == PhysicalKeyboardKey.escape)) {
      Navigator.popUntil(
        context,
        (route) => route.settings.name != Routes.settings,
      );
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return Scaffold(
      backgroundColor: NysseColors.darkBlue,
      body: ListView(
        children: [
          _SettingsTextField(
            initialValue: config.digitransitSubscriptionKey,
            hint: "Digitransit API Key",
            onSubmitted: (String key) =>
                config.digitransitSubscriptionKey = key.isNotEmpty ? key : null,
          ),
          _SettingsTextField(
            initialValue: config.stopId,
            hint: "Stop Id",
            onSubmitted: (String id) =>
                config.stopId = id.isNotEmpty ? id : null,
          ),
        ],
      ),
    );
  }
}

class _MainSettings extends StatefulWidget {
  @override
  State<_MainSettings> createState() => _MainSettingsState();
}

class _MainSettingsState extends State<_MainSettings> {
  late TextEditingController _keyController;
  late TextEditingController _stopIdController;

  @override
  void initState() {
    super.initState();

    final Config config = Config.of(context);
    _keyController = TextEditingController(
      text: config.digitransitSubscriptionKey,
    );
    _stopIdController = TextEditingController(
      text: config.digitransitSubscriptionKey,
    );
  }

  @override
  void dispose() {
    _keyController.dispose();
    _stopIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsTitled(
          title: "Digitransit API Key",
          child: TextField(
            controller: _keyController,
            autocorrect: false,
          ),
        ),
      ],
    );
  }
}
