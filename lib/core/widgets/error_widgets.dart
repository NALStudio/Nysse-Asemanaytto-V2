import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

/// Quick and dirty way to display internal errors without crashing the whole application.
class ErrorWidget extends StatelessWidget {
  final String errorMsg;
  const ErrorWidget({super.key, required this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: NysseColors.orange,
      child: AutoSizeText(
        errorMsg,
        maxLines: 4,
        style: const TextStyle(
          color: NysseColors.white,
          fontSize: 30,
        ),
      ),
    );
  }
}

class QueryErrorWidget extends ErrorWidget {
  QueryErrorWidget(Exception exc, {super.key})
      : super(errorMsg: exc.toString());
}

class MqttOfflineErrorWidget extends ErrorWidget {
  const MqttOfflineErrorWidget({super.key}) : super(errorMsg: "MQTT OFFLINE");
}
