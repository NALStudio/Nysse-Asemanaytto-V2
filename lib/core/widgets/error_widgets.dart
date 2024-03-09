import 'package:flutter/material.dart';

class MqttOfflineErrorWidget extends ErrorWidget {
  MqttOfflineErrorWidget() : super.withDetails(message: "MQTT OFFLINE");
}
