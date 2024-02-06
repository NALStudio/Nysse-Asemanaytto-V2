import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/main/components/header.dart';
import 'package:nysse_asemanaytto/main/components/stoptime.dart';
import 'package:nysse_asemanaytto/main/components/title.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    return Column(
      children: [
        MainLayoutHeader(),
        SizedBox(height: layout.padding),
        const MainLayoutTitle(),
        SizedBox(height: layout.padding),
        const _Stoptimes(
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class _Stoptimes extends StatefulWidget {
  final bool shrinkWrap;

  const _Stoptimes({this.shrinkWrap = false});

  @override
  State<_Stoptimes> createState() => _StoptimesState();
}

class _StoptimesState extends State<_Stoptimes> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  AnimatedListState get _list => _listKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final double childSpacing = Layout.of(context).padding;

    return AnimatedList(
      key: _listKey,
      itemBuilder: (context, index, ___) => Padding(
        padding: EdgeInsets.only(bottom: childSpacing),
        child: MainLayoutStoptime(),
      ),
      initialItemCount: 6,
      shrinkWrap: widget.shrinkWrap,
    );
  }
}
