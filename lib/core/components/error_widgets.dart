import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';

class MqttOfflineErrorWidget extends ErrorWidget {
  MqttOfflineErrorWidget(DigitransitMqttState? mqtt)
      : super.withDetails(message: _constructMessage(mqtt));

  static String _constructMessage(DigitransitMqttState? mqtt) {
    String output = "MQTT OFFLINE";
    String? error;
    if (mqtt == null) {
      error = "Digitransit MQTT provider is missing.";
    } else {
      Exception? connectionError = mqtt.connectionError;
      if (connectionError != null) {
        error = connectionError.toString();
      }
    }

    if (error != null) {
      output += "\n$error";
    }

    return output;
  }
}

/// Keeps the state of child widgets by overlaying the error on top of all content.
class FloatingErrorWidget extends StatelessWidget {
  final ErrorWidget error;
  final Widget child;

  const FloatingErrorWidget({
    super.key,
    required this.error,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      children: [child, error],
    );
  }
}
