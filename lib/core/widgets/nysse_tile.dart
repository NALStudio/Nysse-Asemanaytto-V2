import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';

class NysseTile extends StatelessWidget {
  final Widget leading;
  final Widget content;
  final Widget trailing;

  const NysseTile({
    super.key,
    required this.leading,
    required this.content,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return SizedBox(
      height: layout.tileHeight,
      child: Row(
        children: [
          SizedBox(
            width: layout.indent,
            child: Align(
              alignment: Alignment.centerLeft,
              child: leading,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: content,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
