import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

class QueryError extends StatelessWidget {
  final String errorMsg;

  const QueryError({super.key, required this.errorMsg});

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
