import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/widgets/query_error.dart';
import 'package:nysse_asemanaytto/digitransit/queries.dart';
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
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(DigitransitStoptimeQuery.query),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return QueryError(errorMsg: result.exception.toString());
        }

        final Map<String, dynamic>? data = result.data;
        final DigitransitStoptimeQuery? parsed =
            data != null ? DigitransitStoptimeQuery.parse(data) : null;

        return _StoptimesList(
          shrinkWrap: widget.shrinkWrap,
          stoptimes: parsed?.stoptimesWithoutPatterns ?? List.empty(),
        );
      },
    );
  }
}

class _StoptimesList extends StatefulWidget {
  final bool shrinkWrap;
  final List<DigitransitStoptime> stoptimes;

  const _StoptimesList({
    required this.shrinkWrap,
    required this.stoptimes,
  });

  @override
  State<_StoptimesList> createState() => _StoptimesListState();
}

class _StoptimeInfo {
  final String tripGtfsId;
  final GlobalKey<DismissibleState> key;
  final DigitransitStoptime stoptime;

  _StoptimeInfo({
    required this.tripGtfsId,
    required this.key,
    required this.stoptime,
  });
}

class _StoptimesListState extends State<_StoptimesList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  List<_StoptimeInfo> animatedStoptimes = List.empty(growable: true);
  AnimatedListState get animatedList => _listKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final childCount = Config.of(context).displayedStoptimesCount;

    final layout = Layout.of(context);
    final double childTotalSize = layout.tileHeight + layout.widePadding;

    return SizedBox(
      height: childCount * childTotalSize,
      child: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, ___) => SizedBox(
          height: childTotalSize,
          // TODO: Switch away from dismissibles
          child: Dismissible(
            key: animatedStoptimes[index].key,
            child: const MainLayoutStoptime(),
          ),
        ),
        initialItemCount: 0,
        shrinkWrap: widget.shrinkWrap,
      ),
    );
  }
}
