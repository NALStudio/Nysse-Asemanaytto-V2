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
        const MainLayoutHeader(),
        SizedBox(height: layout.padding),
        Padding(
          padding: EdgeInsets.symmetric(vertical: layout.halfPadding),
          child: const MainLayoutTitle(),
        ),
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
    const int childVisibleCount = 6;

    final layout = Layout.of(context);
    final double childTotalSize = layout.tileHeight + layout.widePadding;

    return SizedBox(
      height: childVisibleCount * childTotalSize,
      child: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, ___) => SizedBox(
          height: childTotalSize,
          child: Dismissible(
            key: Key("stoptime_$index"),
            child: const MainLayoutStoptime(),
          ),
        ),
        initialItemCount: 6, // TODO: Implement stoptime fetching
        shrinkWrap: widget.shrinkWrap,
      ),
    );
  }
}
