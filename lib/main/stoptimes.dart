import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/core/components/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';

class Stoptimes extends StatefulWidget {
  final Widget child;

  const Stoptimes({super.key, required this.child});

  @override
  State<Stoptimes> createState() => _StoptimesState();

  static DigitransitStoptimeQuery? of(BuildContext context) {
    final _StoptimesInherited? si =
        context.dependOnInheritedWidgetOfExactType<_StoptimesInherited>();
    assert(si != null, "No stoptimes found in context.");
    return si!.stoptimes;
  }
}

class _StoptimesState extends State<Stoptimes> {
  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return Query(
      options: QueryOptions(
        document: gql(DigitransitStoptimeQuery.query),
        variables: {
          "stopId": config.stopId.id,
          "numberOfDepartures": config.stoptimesCount,
        },
        pollInterval: RequestInfo.ratelimits.stoptimesRequest,
      ),
      builder: (result, {fetchMore, refetch}) {
        DigitransitStoptimeQuery? parsed;
        if (!result.hasException) {
          final Map<String, dynamic>? data = result.data;
          if (data != null) {
            parsed = DigitransitStoptimeQuery.parse(data);
          }
        }

        final Widget child = _StoptimesInherited(
          stoptimes: parsed,
          child: widget.child,
        );

        if (result.hasException) {
          return FloatingErrorWidget(
            error: ErrorWidget(result.exception!),
            child: child,
          );
        } else {
          return child;
        }
      },
    );
  }
}

class _StoptimesInherited extends InheritedWidget {
  final DigitransitStoptimeQuery? stoptimes;

  const _StoptimesInherited({required super.child, required this.stoptimes});

  @override
  bool updateShouldNotify(covariant _StoptimesInherited oldWidget) {
    return stoptimes != oldWidget.stoptimes;
  }
}
