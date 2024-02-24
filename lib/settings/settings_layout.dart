import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nysse_asemanaytto/core/config.dart';
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

class _SettingsTextField extends StatefulWidget {
  final String? initialValue;
  final String? hint;
  final void Function(String)? onSubmitted;
  final bool autocorrect;

  const _SettingsTextField({
    required this.initialValue,
    this.hint,
    this.onSubmitted,
    // ignore: unused_element
    this.autocorrect = false,
  });

  @override
  State<_SettingsTextField> createState() => _SettingsTextFieldState();
}

class _SettingsTextFieldState extends State<_SettingsTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: widget.onSubmitted,
      autocorrect: widget.autocorrect,
      decoration: InputDecoration(
        hintText: widget.hint,
      ),
    );
  }
}
