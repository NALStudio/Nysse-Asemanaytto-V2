import 'package:flutter/material.dart';

class MqttOfflineErrorWidget extends ErrorWidget {
  MqttOfflineErrorWidget() : super.withDetails(message: "MQTT OFFLINE");
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
