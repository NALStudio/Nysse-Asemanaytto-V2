import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';

class NysseTile extends StatelessWidget {
  final Widget leading;
  final AlignmentGeometry leadingAlignment;

  final Widget content;
  final AlignmentGeometry contentAlignment;

  final Widget trailing;
  final AlignmentGeometry trailingAlignment;

  const NysseTile({
    super.key,
    required this.leading,
    this.leadingAlignment = Alignment.centerLeft,
    required this.content,
    this.contentAlignment = Alignment.centerLeft,
    required this.trailing,
    this.trailingAlignment = Alignment.centerRight,
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
              alignment: leadingAlignment,
              child: leading,
            ),
          ),
          Expanded(
            child: Align(
              alignment: contentAlignment,
              child: content,
            ),
          ),
          Align(
            alignment: trailingAlignment,
            child: trailing,
          ),
        ],
      ),
    );
  }
}
