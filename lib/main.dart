import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/main/main_layout.dart';
import 'package:nysse_asemanaytto/nysse/_colors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Nysse Asemanäyttö",
      home: AppServices(),
    );
  }
}

class AppServices extends StatelessWidget {
  const AppServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      info: LayoutData(mediaQueryData: MediaQuery.of(context)),
      child: const AppCanvas(),
    );
  }
}

class AppCanvas extends StatelessWidget {
  const AppCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: NysseColors.mediumBlue,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MainCanvas(),
          EmbedCanvas(),
        ],
      ),
    );
  }
}

class MainCanvas extends StatelessWidget {
  const MainCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Layout.of(context).widePadding),
      child: const MainLayout(),
    );
  }
}

class EmbedCanvas extends StatelessWidget {
  const EmbedCanvas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: ColoredBox(
        color: Colors.orange,
      ),
    );
  }
}
