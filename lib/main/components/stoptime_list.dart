import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/ratelimits.dart';
import 'package:nysse_asemanaytto/core/widgets/query_error.dart';
import 'package:nysse_asemanaytto/digitransit/queries/queries.dart';
import 'package:nysse_asemanaytto/main/components/stoptime.dart';

class MainLayoutStoptimeList extends StatefulWidget {
  final bool shrinkWrap;

  const MainLayoutStoptimeList({super.key, this.shrinkWrap = false});

  @override
  State<MainLayoutStoptimeList> createState() => _MainLayoutStoptimeListState();
}

class _MainLayoutStoptimeListState extends State<MainLayoutStoptimeList> {
  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return Query(
      options: QueryOptions(
        document: gql(DigitransitStoptimeQuery.query),
        variables: {
          "stopId": config.stopId,
          "numberOfDepartures": config.stoptimesCount,
        },
        pollInterval: Ratelimits.stoptimesRequest,
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

class _StoptimesListState extends State<_StoptimesList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  AnimatedListState get _animatedList => _listKey.currentState!;

  final List<DigitransitStoptime> _internalList = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final childCount = Config.of(context).stoptimesCount;

    final layout = Layout.of(context);
    final double childTotalSize = layout.tileHeight + layout.widePadding;

    // Remove trips that have left the station
    Set<String> tripIds = widget.stoptimes.map((e) => e.tripGtfsId).toSet();
    int removeIndex = 0;
    while (removeIndex < _internalList.length) {
      final DigitransitStoptime st = _internalList[removeIndex];
      if (tripIds.contains(st.tripGtfsId)) {
        removeIndex++;
        continue;
      }

      final DigitransitStoptime removed = _internalList.removeAt(removeIndex);
      _animatedList.removeItem(
        removeIndex,
        (context, animation) => _buildAnimatedListStoptime(
          context,
          stoptime: removed,
          height: childTotalSize,
          animationProgress: animation.value,
        ),
      );
    }

    // Set new trips to correct indexes
    for (int i = 0; i < widget.stoptimes.length; i++) {
      final DigitransitStoptime st = widget.stoptimes[i];
      if (i < _internalList.length) {
        _internalList[i] = st;
      } else {
        _internalList.insert(i, st);
        _animatedList.insertItem(i);
      }
    }

    // Remove overflowing items
    while (_internalList.length > widget.stoptimes.length) {
      int lastIndex = _internalList.length - 1;
      final DigitransitStoptime removed = _internalList.removeAt(lastIndex);
      _animatedList.removeItem(
        lastIndex,
        (context, animation) => _buildAnimatedListStoptime(
          context,
          stoptime: removed,
          height: childTotalSize,
          animationProgress: animation.value,
        ),
      );
    }

    return SizedBox(
      height: childCount * childTotalSize,
      child: AnimatedList(
        key: _listKey,
        itemBuilder: (context, index, ___) => _buildAnimatedListStoptime(
          context,
          stoptime: _internalList[index],
          height: childTotalSize,
        ),
        shrinkWrap: widget.shrinkWrap,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}

Widget _buildAnimatedListStoptime(
  BuildContext context, {
  required DigitransitStoptime stoptime,
  required double height,
  double? animationProgress,
}) {
  Widget widget = SizedBox(
    height: height,
    child: MainLayoutStoptime(stoptime: stoptime),
  );

  if (animationProgress != null) {
    widget = FractionalTranslation(
      translation: Offset(animationProgress, 0),
      child: widget,
    );
  }

  return widget;
}
