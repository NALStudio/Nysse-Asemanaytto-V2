import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/settings/components/settings_form.dart';

abstract class StatelessEmbed<T extends EmbedSettings> extends StatelessWidget {
  const StatelessEmbed({super.key});
}

abstract class StatefulEmbed<T extends EmbedSettings> extends StatefulWidget {
  const StatefulEmbed({super.key});
}

class EmbedInfo {
  /// Must be unique between embeds.
  final String name;
  final EmbedSettings settings;

  EmbedInfo({required this.name, required this.settings});
}

abstract class EmbedSettings {
  SettingsForm build(BuildContext context);
}
