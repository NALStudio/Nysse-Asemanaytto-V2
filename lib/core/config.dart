import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigWidget extends StatefulWidget {
  final SharedPreferences _prefs;
  final Widget child;

  const ConfigWidget({
    super.key,
    required SharedPreferences prefs,
    required this.child,
  }) : _prefs = prefs;

  @override
  State<ConfigWidget> createState() => Config();
}

class Config extends State<ConfigWidget> {
  String? get digitransitSubscriptionKey =>
      widget._prefs.getString("digitransitSubscriptionKey");
  set digitransitSubscriptionKey(String? key) =>
      _setStringOrNull("digitransitSubscriptionKey", key);

  DigitransitRoutingEndpoint get endpoint {
    String? endpoint = widget._prefs.getString("endpoint");
    if (endpoint == null) {
      return DigitransitRoutingEndpoint.waltti;
    }
    return DigitransitRoutingEndpoint(endpoint);
  }

  set endpoint(DigitransitRoutingEndpoint endpoint) =>
      widget._prefs.setString("endpoint", endpoint.value);

  String get stopId => widget._prefs.getString("stopId") ?? "tampere:3522";
  set stopId(String id) => widget._prefs.setString("stopId", id);

  String get stopFeedId {
    final List<String> stopIdParts = stopId.split(':');
    if (stopIdParts.length != 2) throw StateError("Invalid stopId");
    return stopIdParts[0];
  }

  String get stopGtfsId {
    final List<String> stopIdParts = stopId.split(':');
    if (stopIdParts.length != 2) throw StateError("Invalid stopId");
    return stopIdParts[1];
  }

  // set stopFeedId(String id) {
  //   List<String> idParts = stopId.split(':');
  //   if (idParts.isEmpty) throw StateError("Invalid stopId");
  //   idParts[0] = id;
  //   stopId = idParts.join(':');
  // }

  Future<void> _setStringOrNull(String key, String? value) {
    if (value != null) {
      return widget._prefs.setString(key, value);
    } else {
      return widget._prefs.remove(key);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ConfigInherited(
      config: this,
      child: widget.child,
    );
  }

  static Config? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ConfigInherited>()
        ?.config;
  }

  static Config of(BuildContext context) {
    final Config? result = maybeOf(context);
    assert(result != null, "No config data found in context.");
    return result!;
  }
}

class _ConfigInherited extends InheritedWidget {
  final Config config;

  const _ConfigInherited({required super.child, required this.config});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
