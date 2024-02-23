import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/ratelimits.dart';
import 'package:nysse_asemanaytto/core/widgets/query_error.dart';
import 'package:nysse_asemanaytto/digitransit/queries/queries.dart';
import 'package:nysse_asemanaytto/main/components/stoptime.dart';
import 'package:nysse_asemanaytto/main/components/stoptime_dismiss_animation.dart';

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

      _removeItem(removeIndex, stoptimeHeight: childTotalSize);
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
      _removeItem(
        _internalList.length - 1,
        stoptimeHeight: childTotalSize,
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

  void _removeItem(int index, {required double stoptimeHeight}) {
    final DigitransitStoptime removed = _internalList.removeAt(index);
    _animatedList.removeItem(
      index,
      (context, animation) => _buildAnimatedListStoptime(
        context,
        stoptime: removed,
        height: stoptimeHeight,
        removeAnimation: animation,
      ),
      duration: const Duration(seconds: 1),
    );
  }
}

Widget _buildAnimatedListStoptime(
  BuildContext context, {
  required DigitransitStoptime stoptime,
  required double height,
  Animation<double>? removeAnimation,
}) {
  Widget widget = SizedBox(
    height: height,
    child: MainLayoutStoptime(stoptime: stoptime),
  );

  if (removeAnimation != null) {
    widget = StoptimeDismissAnimation(
      key: UniqueKey(),
      animation: removeAnimation,
      child: widget,
    );
  }

  return widget;
}
