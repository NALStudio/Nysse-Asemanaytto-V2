import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmbedRecord {
  final Embed embed;
  final EmbedSettings settings;

  EmbedRecord({required this.embed, required this.settings});
}

abstract class Config {
  static final defaultConfig = _DefaultConfig();

  String? get digitransitSubscriptionKey;
  set digitransitSubscriptionKey(String? key);

  DigitransitRoutingEndpoint get endpoint;
  set endpoint(DigitransitRoutingEndpoint? endpoint);

  StopId get stopId;
  set stopId(StopId? id);

  int get stoptimesCount;
  set stoptimesCount(int? count);

  UnmodifiableListView<EmbedRecord> get embeds;
  void addEmbed(Embed embed, EmbedSettings settings);
  void removeEmbed(Embed embed);
  void moveEmbed(Embed embed, int index);
  EmbedSettings? getEmbedSettings(Embed embed);

  static Config? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ConfigInherited>()
        ?.parent;
  }

  static Config of(BuildContext context) {
    final Config? result = maybeOf(context);
    assert(result != null, "No config found in context.");
    return result!;
  }
}

class _DefaultConfig implements Config {
  void _throw() => throw StateError("Cannot modify default config.");

  @override
  final String? digitransitSubscriptionKey = null;
  @override
  set digitransitSubscriptionKey(String? key) => _throw();

  @override
  final DigitransitRoutingEndpoint endpoint = DigitransitRoutingEndpoint.waltti;
  @override
  set endpoint(DigitransitRoutingEndpoint? endpoint) => _throw();

  @override
  final StopId stopId = StopId("tampere:3522");
  @override
  set stopId(StopId? id) => _throw();

  @override
  final int stoptimesCount = 6;
  @override
  set stoptimesCount(int? count) => _throw();

  @override
  UnmodifiableListView<EmbedRecord> get embeds =>
      UnmodifiableListView(const Iterable.empty());
  @override
  EmbedSettings? getEmbedSettings(Embed embed) => null;
  @override
  void addEmbed(Embed embed, EmbedSettings<Embed> settings) => _throw();
  @override
  void removeEmbed(Embed embed) => _throw();
  @override
  void moveEmbed(Embed embed, int index) => _throw();
}

class ConfigWidget extends StatefulWidget {
  final Widget child;
  final SharedPreferences _prefs;

  const ConfigWidget({
    super.key,
    required SharedPreferences prefs,
    required this.child,
  }) : _prefs = prefs;

  @override
  State<StatefulWidget> createState() => _SharedPrefsConfig();
}

class _InternalEmbedRecord {
  int index;
  EmbedSettings settings;

  _InternalEmbedRecord({required this.index, required this.settings});
}

class _SharedPrefsConfig extends State<ConfigWidget> implements Config {
  SharedPreferences get _prefs => widget._prefs;

  late List<EmbedRecord> _embeds;
  late Map<String, _InternalEmbedRecord> _embedByName;

  @override
  void initState() {
    super.initState();

    final List<String> embeds =
        _prefs.getStringList(_getEmbedPrefName(null)) ?? List.empty();

    _embeds = [];
    _embedByName = {};
    for (int i = 0; i < embeds.length; i++) {
      final String embedName = embeds[i];

      List<Embed> matching =
          Embed.allEmbeds.where((e) => e.name == embedName).toList();
      if (matching.length > 1) {
        throw StateError("Multiple embed definitions for: $embedName");
      }

      final Embed embed = matching.first;
      final EmbedSettings settings =
          embed.deserializeSettings(_prefs.getString(_getEmbedPrefName(embed)));
      _embeds.add(EmbedRecord(embed: embed, settings: settings));
      _embedByName[embedName] =
          _InternalEmbedRecord(index: i, settings: settings);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigInherited(
      parent: this,
      child: widget.child,
    );
  }

  // null for root (used to store the embed list)
  String _getEmbedPrefName(Embed? embed) {
    String name = "embeds";
    if (embed != null) {
      name += ".${embed.name}";
    }
    return name;
  }

  @override
  String? get digitransitSubscriptionKey =>
      _prefs.getString("digitransitSubscriptionKey");
  @override
  set digitransitSubscriptionKey(String? key) {
    setState(
      () {
        if (key != null) {
          _prefs.setString("digitransitSubscriptionKey", key);
        } else {
          _prefs.remove("digitransitSubscriptionKey");
        }
      },
    );
  }

  @override
  DigitransitRoutingEndpoint get endpoint {
    final String? endpoint = _prefs.getString("endpoint");
    if (endpoint == null) return Config.defaultConfig.endpoint;
    return DigitransitRoutingEndpoint(endpoint);
  }

  @override
  set endpoint(DigitransitRoutingEndpoint? endpoint) {
    setState(() {
      _prefs.setString(
        "endpoint",
        (endpoint ?? Config.defaultConfig.endpoint).value,
      );
    });
  }

  @override
  StopId get stopId {
    final String? value = _prefs.getString("stopId");
    if (value == null) return Config.defaultConfig.stopId;
    return StopId(value);
  }

  @override
  set stopId(StopId? id) => setState(() {
        _prefs.setString(
          "stopId",
          (id ?? Config.defaultConfig.stopId).value,
        );
      });

  @override
  int get stoptimesCount =>
      _prefs.getInt("stoptimeCount") ?? Config.defaultConfig.stoptimesCount;
  @override
  set stoptimesCount(int? count) => setState(() {
        _prefs.setInt(
            "stoptimeCount", count ?? Config.defaultConfig.stoptimesCount);
      });

  @override
  void addEmbed(Embed embed, EmbedSettings<Embed> settings) {
    final String embedName = embed.name;

    if (_embedByName.containsKey(embedName)) {
      throw ArgumentError("Embed with name '$embedName' exists already.");
    }

    setState(() {
      _embedByName[embedName] =
          _InternalEmbedRecord(index: _embeds.length, settings: settings);
      _embeds.add(EmbedRecord(embed: embed, settings: settings));
    });
  }

  @override
  UnmodifiableListView<EmbedRecord> get embeds => UnmodifiableListView(_embeds);

  @override
  EmbedSettings<Embed>? getEmbedSettings(Embed embed) =>
      _embedByName[embed.name]?.settings;

  @override
  void moveEmbed(Embed embed, int index) {
    final _InternalEmbedRecord? record = _embedByName[embed.name];
    if (record == null) {
      throw ArgumentError("Embed with name '${embed.name}' does not exist.");
    }

    setState(() {
      final EmbedRecord toMove = _embeds.removeAt(record.index);
      _embeds.insert(index, toMove);
      record.index = index;
    });
  }

  @override
  void removeEmbed(Embed embed) {
    final String embedName = embed.name;
    if (!_embedByName.containsKey(embedName)) {
      throw ArgumentError("Embed with name '${embed.name}' does not exist.");
    }

    setState(() {
      int rmvIndex = _embedByName.remove(embedName)!.index;
      _embeds.removeAt(rmvIndex);
    });
  }
}

class _ConfigInherited extends InheritedWidget {
  final _SharedPrefsConfig parent;

  const _ConfigInherited({required this.parent, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
