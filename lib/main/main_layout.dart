import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/widgets/nysse_tile.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return const NysseTile(
      leading: Text("RAT"),
      title: Text("NYSSE"),
      trailing: Text(TimeOfDay.now()),
    );
  }
}
