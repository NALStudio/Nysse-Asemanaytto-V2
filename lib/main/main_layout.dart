import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/ratelimits.dart';
import 'package:nysse_asemanaytto/core/widgets/query_error.dart';
import 'package:nysse_asemanaytto/digitransit/queries/queries.dart';
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
        _StopInfoQuery(
          childBuilder: (context, stopInfo) => Column(
            children: [
              MainLayoutHeader(stopInfo: stopInfo),
              SizedBox(height: layout.padding),
              Padding(
                padding: EdgeInsets.symmetric(vertical: layout.halfPadding),
                child: MainLayoutTitle(stopInfo: stopInfo),
              ),
            ],
          ),
        ),
        const MainLayoutStoptimeList(
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class _StopInfoQuery extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    DigitransitStopInfoQuery? stopInfo,
  ) childBuilder;

  const _StopInfoQuery({required this.childBuilder});

  @override
  Widget build(BuildContext context) {
    final Config config = Config.of(context);

    return Query(
      options: QueryOptions(
        document: gql(DigitransitStopInfoQuery.query),
        variables: {
          "stopId": config.stopId,
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

        return childBuilder(context, parsed);
      },
    );
  }
}
