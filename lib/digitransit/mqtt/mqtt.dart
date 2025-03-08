export '_topics/positioning.dart';

import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/_topics/positioning.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';

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

class DigitransitMqttState extends State<DigitransitMqtt> {
  bool get healthy => connected && _connectionError == null;

  bool get connected =>
      _client.connectionStatus?.state == MqttConnectionState.connected;

  Exception? _connectionError;
  Exception? get connectionError => _connectionError;

  bool disposed = false;

  late final Logger _logger;
  late final Random _random;

  late MqttServerClient _client;

  late final Map<GtfsId, _InternalSubscription?> _subs;
  late final LinkedHashSet<DigitransitMqttSubscription> _digiSubs;

  Timer? _reconnect;

  @override
  Widget build(BuildContext context) {
    return _DigitransitMqttInherited(parent: this, child: widget.child);
  }

  @override
  void initState() {
    super.initState();

    _logger = Logger("DigitransitMqttState");

    _random = Random();
    _client = MqttServerClient(digitransitMqttEndpoint, RequestInfo.userAgent);
    _client.keepAlivePeriod = 30;

    _client.onDisconnected = _callbackDisconnect;

    _client.onSubscribeFail = _callbackSubscribeFailed;
    _client.onSubscribed = _callbackSubscribe;
    _client.onUnsubscribed = _callbackUnsubscribe;

    // ignore: prefer_collection_literals
    _subs = Map();
    _digiSubs = LinkedHashSet();

    _connect();
  }

  @override
  void dispose() {
    disposed = true;
    _disconnect();
    super.dispose();
  }

  Future _connect() async {
    _client.clientIdentifier = RequestInfo.mqttClientId(_random);
    try {
      await _client.connect();
      _client.updates.listen(_callbackUpdate);
      setState(() {
        _connectionError = null;
      });
    } on Exception catch (e) {
      _disconnect();
      setState(() {
        _connectionError = e;
      });

      _scheduleReconnect();
    }

    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      _disconnect();
    }
  }

  void _disconnect() {
    _client.disconnect();
  }

  void _callbackDisconnect() {
    final MqttDisconnectionOrigin? origin =
        _client.connectionStatus?.disconnectionOrigin;

    if (origin == MqttDisconnectionOrigin.solicited) {
      _logger.info("MQTT Disconnect requested by user.");
    } else if (origin == MqttDisconnectionOrigin.brokerSolicited) {
      _logger.info("MQTT Disconnect requested by server.");
    } else if (origin == MqttDisconnectionOrigin.unsolicited) {
      _logger.info("MQTT Disconnected, scheduling reconnect...");
      _scheduleReconnect();
    } else {
      _logger.info("MQTT Disconnected.");
    }
  }

  void _callbackSubscribeFailed(MqttSubscription sub) {
    _logger.warning("MQTT Subscribe failed: '${sub.topic}'");
  }

  void _callbackSubscribe(MqttSubscription sub) {
    _logger.info("MQTT Subscribed: '${sub.topic}'");
  }

  void _callbackUnsubscribe(MqttSubscription sub) {
    _logger.info("MQTT Unsubscribed: '${sub.topic}'");
  }

  void _callbackUpdate(List<MqttReceivedMessage<MqttMessage>> event) {
    for (MqttReceivedMessage<MqttMessage> message in event) {
      // print(message.topic);

      final String? topicString = message.topic;
      if (topicString == null) continue;

      final DigitransitPositioningTopic topic =
          DigitransitPositioningTopic.fromString(topicString);

      final MqttPublishMessage payload = message.payload as MqttPublishMessage;
      final msgBuffer = payload.payload.message!;

      final FeedEntity entity = FeedEntity.fromBuffer(msgBuffer);

      for (final DigitransitMqttSubscription sub in _digiSubs) {
        sub._newData(topic, entity);
      }
    }
  }

  void _scheduleReconnect() {
    assert(_client.connectionStatus?.state != MqttConnectionState.connected);

    if (_reconnect?.isActive == true) {
      return; // A reconnect is already scheduled.
    }

    _reconnect = Timer(RequestInfo.mqttReconnectDelay, _connect);
  }

  DigitransitMqttSubscription? subscribeRoute(GtfsId routeId) =>
      _subscribe(routeId, trip: false);

  DigitransitMqttSubscription? subscribeTrip(GtfsId tripId) =>
      _subscribe(tripId, trip: true);

  _InternalSubscription? _internalSubscribe(
    GtfsId id, {
    required bool trip,
    required int count,
  }) {
    final DigitransitPositioningTopic topic = trip
        ? DigitransitPositioningTopic.trip(id)
        : DigitransitPositioningTopic.route(id);

    final MqttSubscription? sub = _client.subscribeWithSubscription(
      MqttSubscription.withMaximumQos(
        topic.buildTopic(),
        MqttQos.atMostOnce,
      ),
    );

    if (sub != null) {
      return _InternalSubscription(subscription: sub, subscriptionCount: count);
    } else {
      return null;
    }
  }

  DigitransitMqttSubscription? _subscribe(GtfsId id, {required bool trip}) {
    _InternalSubscription? sub = _subs.update(
      id,
      (x) {
        if (x != null) {
          assert(x.subscriptionCount > 0);
          x.subscriptionCount++;
          return x;
        } else {
          return _internalSubscribe(id, trip: trip, count: 1);
        }
      },
      ifAbsent: () {
        return _internalSubscribe(id, trip: trip, count: 1);
      },
    );

    if (sub != null) {
      final DigitransitMqttSubscription digiSub =
          DigitransitMqttSubscription._create(trip: trip, id: id);

      bool added = _digiSubs.add(digiSub);
      assert(added);

      return digiSub;
    } else {
      return null;
    }
  }

  void unsubscribe(DigitransitMqttSubscription subscription) {
    bool removed = _digiSubs.remove(subscription);

    if (!removed) {
      throw ArgumentError("Subscription has already been unsubscribed.");
    }

    _subs.update(
      subscription.id,
      (x) {
        if (x == null) return null;

        x.subscriptionCount--;
        if (x.subscriptionCount < 1) {
          _client.unsubscribeSubscription(x.subscription);
          return null;
        } else {
          return x;
        }
      },
    );

    _subs.removeWhere((key, value) => value == null);
  }

/* Removed due to added complexity
  void unsubscribeAll(Iterable<DigitransitMqttSubscription> subscriptions) {
    _subscriptions.removeAll(subscriptions);
    _client.unsubscribeSubscriptionList(
      _subscriptions.map((s) => s._sub).toList(growable: false),
    );
  }
*/
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

class _InternalSubscription {
  final MqttSubscription subscription;
  int subscriptionCount;

  _InternalSubscription({
    required this.subscription,
    required this.subscriptionCount,
  });
}

class DigitransitMqttSubscription {
  final bool trip;
  final GtfsId id;

  void Function(FeedEntity msg)? onMessageReceived;

  DigitransitMqttSubscription._create({
    required this.trip,
    required this.id,
  });

  bool _topicMatches(DigitransitPositioningTopic topic) {
    String? otherId;
    if (trip) {
      otherId = topic.tripId;
    } else {
      otherId = topic.routeId;
    }

    return id.rawId == otherId;
  }

  void _newData(DigitransitPositioningTopic topic, FeedEntity entity) {
    if (onMessageReceived != null && _topicMatches(topic)) {
      onMessageReceived!(entity);
    }
  }
}
