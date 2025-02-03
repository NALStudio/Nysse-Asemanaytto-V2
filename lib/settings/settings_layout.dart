import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nysse_asemanaytto/core/components/screen_darken.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import '_settings_form.dart';
import 'package:nysse_asemanaytto/core/routes.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';
import 'package:nysse_asemanaytto/settings/settings.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late List<SettingsForm> _staticForms;

  late GlobalKey<FormState> _formKey;
  final List<bool?> _formExpanded = [];

  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.keyboard.addHandler(_onKey);

    _staticForms = [
      MainSettings(),
    ];

    _formKey = GlobalKey();
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
      if (!_isDirty) {
        Navigator.popUntil(
          context,
          ModalRoute.withName(Routes.home),
        );
      } else {
        _cannotNavigateBack();
      }
    }

    return false;
  }

  void _cannotNavigateBack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Settings haven't been saved, cannot navigate back.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    List<EmbedSettingsForm> embedForms = config.embeds
        .map((e) => e.settings.createForm(e.embed.createDefaultSettings()))
        .toList(growable: false);

    final formCount = _staticForms.length + embedForms.length;
    while (_formExpanded.length > formCount) {
      _formExpanded.removeLast();
    }
    while (_formExpanded.length < formCount) {
      _formExpanded.add(null);
    }

    // For settings darken slider preview
    return ScreenDarkenWidget(
      defaultStrength: 0.5,
      child: Scaffold(
        backgroundColor: NysseColors.white,
        appBar: AppBar(
          title: const Text("Settings"),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_backup_restore),
              onPressed: _isDirty
                  ? () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _isDirty = false;
                      });
                    }
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }

                _formKey.currentState!.save();

                for (final EmbedRecord embed in config.embeds) {
                  config.saveEmbedSettings(embed.embed);
                }

                setState(() {
                  _formKey = GlobalKey();
                  _isDirty = false;
                });
              },
            ),
          ],
        ),
        body: Form(
          key: _formKey,
          canPop: !_isDirty,
          onChanged: () {
            setState(() => _isDirty = true);
          },
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop) {
              _cannotNavigateBack();
            }
          },
          child: ListView.builder(
            itemCount: formCount,
            itemBuilder: (context, index) => _buildListItem(
              context,
              index,
              embedForms: embedForms,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    int index, {
    required List<EmbedSettingsForm> embedForms,
  }) {
    final SettingsForm form;
    final bool isEmbedForm;
    int? formIndex;
    if (index < _staticForms.length) {
      form = _staticForms[index];
      isEmbedForm = false;
    } else {
      formIndex = index - _staticForms.length;
      form = embedForms[formIndex];
      isEmbedForm = true;
    }

    final Color formColor = form.displayColor;
    final Widget constructedForm = form.build(context);
    assert(constructedForm is! Form,
        "Settings form constructed widget cannot be a Form");

    return ExpansionTile(
      initiallyExpanded: _formExpanded[index] ?? !isEmbedForm,
      onExpansionChanged: (value) => _formExpanded[index] = value,
      maintainState: true,
      title: Text(
        formIndex == null
            ? form.displayName
            : "($formIndex) ${form.displayName}",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      backgroundColor: Color.alphaBlend(Colors.white.withAlpha(196), formColor),
      textColor: Colors.black,
      collapsedBackgroundColor: formColor,
      collapsedTextColor:
          formColor.computeLuminance() >= 0.5 ? Colors.black : Colors.white,
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 16.0,
          ),
          child: constructedForm,
        )
      ],
    );
  }
}
