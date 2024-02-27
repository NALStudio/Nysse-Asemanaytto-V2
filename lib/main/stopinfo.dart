import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/ratelimits.dart';
import 'package:nysse_asemanaytto/core/widgets/query_error.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class StopInfo extends StatefulWidget {
  final Widget child;

  const StopInfo({super.key, required this.child});

  @override
  State<StopInfo> createState() => _StopInfoState();

  static DigitransitStopInfoQuery? of(BuildContext context) {
    final _StopInfoInherited? si =
        context.dependOnInheritedWidgetOfExactType<_StopInfoInherited>();
    assert(si != null, "No stop info found in context.");
    return si!.stopInfo;
  }
}

class _StopInfoState extends State<StopInfo> {
  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return Query(
      options: QueryOptions(
        document: gql(DigitransitStopInfoQuery.query),
        variables: {
          "stopId": config.stopId.value,
        },
        pollInterval: Ratelimits.stopInfoRequest,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return QueryError(errorMsg: result.exception.toString());
        }

        final Map<String, dynamic>? data = result.data;
        final DigitransitStopInfoQuery? parsed =
            DigitransitStopInfoQuery.parse(data);

        return _StopInfoInherited(
          stopInfo: parsed,
          child: widget.child,
        );
      },
    );
  }
}

class _StopInfoInherited extends InheritedWidget {
  final DigitransitStopInfoQuery? stopInfo;

  const _StopInfoInherited({required super.child, required this.stopInfo});

  @override
  bool updateShouldNotify(covariant _StopInfoInherited oldWidget) {
    return stopInfo != oldWidget.stopInfo;
  }
}
