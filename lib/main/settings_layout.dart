import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nysse_asemanaytto/core/routes.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

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
    return const Scaffold(
      backgroundColor: NysseColors.darkBlue,
    );
  }
}
