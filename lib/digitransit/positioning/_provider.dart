import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/digitransit/positioning/_topic.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'dart:developer' as developer;

class PositioningProvider extends StatefulWidget {
  final Widget child;

  const PositioningProvider({super.key, required this.child});

  @override
  State<PositioningProvider> createState() => PositioningProviderState();

  static PositioningProviderState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_PositioningProviderInherited>()
        ?.parent;
  }

  static PositioningProviderState of(BuildContext context) {
    final PositioningProviderState? result = maybeOf(context);
    assert(result != null, "No config found in context.");
    return result!;
  }
}

class PositioningSubscription extends ChangeNotifier {
  final Map<String, VehiclePosition> _positions = {};
  Iterable<VehiclePosition> get vehiclePositions => _positions.values;

  void _update(FeedEntity ent) {
    if (!ent.isDeleted) {
      _positions[ent.id] = ent.vehicle;
    } else {
      _positions.remove(ent.id);
    }
    notifyListeners();
  }
}

class _TopicReference {
  final String topic;
  final List<String> parts;

  _TopicReference(this.topic) : parts = UnmodifiableListView(topic.split('/'));

  bool containsTopic(String otherTopic) {
    List<String> otherParts = otherTopic.split('/');
    assert(otherParts.last != '#');

    if (otherParts.length < parts.length) return false;

    for (int i = 0; i < parts.length; i++) {
      String p1 = parts[i];
      String p2 = otherParts[i];
      if (p1 == '#') {
        // p2 can be anything, iteration stops after this.
        if (i < parts.length - 1) {
          throw StateError("Invalid topic reference state.");
        }
      } else if (p1 == '+') {
        // p2 can be anything
      } else {
        // p1 must equal p2
        if (p1 != p2) return false;
      }
    }

    return true;
  }
}

class PositioningProviderState extends State<PositioningProvider> {
  late MqttServerClient _client;

  final List<String> _yetToSubscribeTopics = [];
  final Map<PositioningSubscription, _TopicReference> _subscriptions = {};

  bool _isListening = false;

  @override
  void initState() {
    super.initState();

    _client = MqttServerClient.withPort(
      "mqtt.digitransit.fi",
      RequestInfo.userAgent,
      1883,
    );
    _client.logging(on: true);
    _client.keepAlivePeriod = 30;
    _client.onConnected = _onConnected;
  }

  void _onConnected() {
    if (!_isListening) {
      _client.updates!.listen(_listen);
      _isListening = true;
    }

    while (_yetToSubscribeTopics.isNotEmpty) {
      // Removing last is more efficient with lists.
      final topic = _yetToSubscribeTopics.removeLast();
      _client.subscribe(topic, MqttQos.exactlyOnce);
    }
  }

  PositioningSubscription subscribe(PositioningTopic topic) {
    String topicString = topic.buildTopicString();
    PositioningSubscription ps = PositioningSubscription();
    _subscriptions[ps] = _TopicReference(topicString);

    final MqttConnectionState? connectionState =
        _client.connectionStatus?.state;

    if (connectionState == MqttConnectionState.connected) {
      _client.subscribe(topicString, MqttQos.exactlyOnce);
    } else {
      _yetToSubscribeTopics.add(topicString);
      if (connectionState != MqttConnectionState.connecting) {
        _client.connect();
      }
    }

    return ps;
  }

  void unsubscribe(PositioningSubscription subscription) {
    final _TopicReference? topic = _subscriptions.remove(subscription);
    if (topic == null) throw ArgumentError("Subscription not found.");

    _client.unsubscribe(topic.topic);

    if (_subscriptions.isEmpty) {
      assert(_yetToSubscribeTopics.isEmpty);
      _client.disconnect();
    }
  }

  void _listen(List<MqttReceivedMessage<MqttMessage>> event) {
    for (MqttReceivedMessage<MqttMessage> received in event) {
      for (final entry in _subscriptions.entries) {
        // We get the payload because at least one person has subscribed to it
        // so we parse it first to save some performance.
        final payload = received.payload as MqttPublishMessage;
        FeedEntity? ent;
        try {
          ent = FeedEntity.fromBuffer(payload.payload.message);
        } on Exception {
          developer.log("Payload of '${received.topic}' could not be parsed.");
          ent = null;
        }

        if (ent != null && entry.value.containsTopic(received.topic)) {
          entry.key._update(ent);
        }
      }
    }
  }

  @override
  void dispose() {
    _client.disconnect();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _PositioningProviderInherited(parent: this, child: widget.child);
  }
}

class _PositioningProviderInherited extends InheritedWidget {
  final PositioningProviderState parent;

  const _PositioningProviderInherited(
      {required this.parent, required super.child});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
