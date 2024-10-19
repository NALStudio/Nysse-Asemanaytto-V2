export '_topics/positioning.dart';

import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';

const String digitransitMqttEndpoint = "mqtt.digitransit.fi";

class DigitransitMqtt extends StatefulWidget {
  final Widget child;

  const DigitransitMqtt({super.key, required this.child});

  @override
  State<DigitransitMqtt> createState() => DigitransitMqttState();

  static DigitransitMqttState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_DigitransitMqttInherited>()
        ?.parent;
  }

  static DigitransitMqttState of(BuildContext context) {
    final DigitransitMqttState? result = maybeOf(context);
    assert(result != null, "No digitransit MQTT found in context.");
    return result!;
  }
}

class UnknownDigitransitMqttConnectionError implements Exception {
  @override
  String toString() => "Unknown Digitransit MQTT Connection Error.";
}

class DigitransitMqttState extends State<DigitransitMqtt> {
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Exception? _connectionError;
  Exception? get connectionError => _connectionError;

  late MqttServerClient _client;

  final LinkedHashSet<DigitransitMqttSubscription> _subscriptions =
      LinkedHashSet();

  @override
  Widget build(BuildContext context) {
    return _DigitransitMqttInherited(parent: this, child: widget.child);
  }

  @override
  void initState() {
    super.initState();

    _client = MqttServerClient(digitransitMqttEndpoint, RequestInfo.userAgent);
    _client.keepAlivePeriod = 30;

    _client.onDisconnected = _onDisconnected;

    _connect();
  }

  void _listen(List<MqttReceivedMessage<MqttMessage>> event) {
    for (MqttReceivedMessage<MqttMessage> message in event) {
      final MqttPublicationTopic messageTopic =
          MqttPublicationTopic(message.topic);

      final MqttPublishMessage payload = message.payload as MqttPublishMessage;
      final msgBuffer = payload.payload.message!;

      final DigitransitMqttMessage digitransitMessage = DigitransitMqttMessage(
        bytes: Uint8List.view(msgBuffer.buffer).asUnmodifiableView(),
      );

      for (final DigitransitMqttSubscription sub in _subscriptions) {
        if (sub._anyTopicHasMatch(messageTopic)) {
          sub._newData(digitransitMessage);
        }
      }
    }
  }

  @override
  void dispose() {
    _disconnect();

    super.dispose();
  }

  void _connect() async {
    try {
      await _client.connect();
    } on Exception catch (e) {
      assert(!isConnected);
      _connectionError = e;
      _disconnect();
      return;
    }

    if (_client.connectionStatus!.state == MqttConnectionState.connected) {
      _isConnected = true;
      _client.updates.listen(_listen);
    } else {
      _connectionError = UnknownDigitransitMqttConnectionError();
      assert(!isConnected);
      _disconnect();
    }
  }

  void _disconnect() {
    _isConnected = false;
    _client.disconnect();
  }

  void _onDisconnected() {
    _isConnected = false;
  }

  DigitransitMqttSubscription? subscribe(String topic, MqttQos qosLevel) {
    final MqttSubscription? sub = _client.subscribe(topic, qosLevel);
    if (sub == null) {
      return null;
    }

    final digitransitSub = DigitransitMqttSubscription._create(sub);
    _subscriptions.add(digitransitSub);

    return digitransitSub;
  }

  DigitransitMqttSubscription? subscribeAll(
    Iterable<String> topics,
    MqttQos qosLevel,
  ) {
    final List<MqttSubscription> topicSubs =
        topics.map((t) => MqttSubscription(MqttSubscriptionTopic(t))).toList();

    final List<MqttSubscription>? subs =
        _client.subscribeWithSubscriptionList(topicSubs);
    if (subs == null) {
      return null;
    }

    final DigitransitMqttSubscription digitransitSub =
        DigitransitMqttSubscription._createCombined(subs);
    _subscriptions.add(digitransitSub);

    return digitransitSub;
  }

  void unsubscribe(DigitransitMqttSubscription subscription) {
    _subscriptions.remove(subscription);
    _client.unsubscribeSubscriptionList(subscription.__subscriptions);
  }
}

class _DigitransitMqttInherited extends InheritedWidget {
  final DigitransitMqttState parent;

  const _DigitransitMqttInherited({
    required this.parent,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}

class DigitransitMqttMessage {
  final Uint8List bytes;

  DigitransitMqttMessage({required this.bytes});
}

class DigitransitMqttSubscription {
  final List<MqttSubscription> __subscriptions;

  void Function(DigitransitMqttMessage msg)? onMessageReceived;

  bool _anyTopicHasMatch(MqttPublicationTopic topic) =>
      __subscriptions.any((e) => e.topic.matches(topic));

  DigitransitMqttSubscription._create(MqttSubscription subscription)
      : __subscriptions = [subscription];
  DigitransitMqttSubscription._createCombined(
      List<MqttSubscription> subsciptions)
      : __subscriptions = subsciptions;

  void _newData(DigitransitMqttMessage msg) {
    if (onMessageReceived != null) {
      onMessageReceived!(msg);
    }
  }
}
