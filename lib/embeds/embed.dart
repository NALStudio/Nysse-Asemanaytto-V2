// TODO: RETHINK THIS THROUGH
// I want an immutable class for embed settings
// And I want to link them with a builder I suppose...
// Embeds should be linked as well through a definition, but no idea how.

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/settings/components/settings_form.dart';

class EmbedDefinition<T extends EmbedSettings> {
  /// Must be unique between embeds.
  final String name;

  EmbedDefinition({required this.name});
}

abstract class EmbedSettings {
  EmbedSettings.deserialize(String serialized);
  String serialize();
}
