import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/main/components/header.dart';
import 'package:nysse_asemanaytto/main/components/stoptime_list.dart';
import 'package:nysse_asemanaytto/main/components/title.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return Column(
      children: [
        const MainLayoutHeader(),
        SizedBox(height: layout.padding),
        Padding(
          padding: EdgeInsets.symmetric(vertical: layout.halfPadding),
          child: const MainLayoutTitle(),
        ),
        const MainLayoutStoptimeList(
          shrinkWrap: true,
        ),
      ],
    );
  }
}
