import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/digitransit/schema.graphql.dart';
import 'package:nysse_asemanaytto/digitransit/stop.graphql.dart';
import 'package:nysse_asemanaytto/main/components/header.dart';
import 'package:nysse_asemanaytto/main/components/stoptime.dart';
import 'package:nysse_asemanaytto/main/components/title.dart';
import 'package:nysse_asemanaytto/nysse/nysse.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _StopinfoQueryLayout(),
        const _Stoptimes(
          shrinkWrap: true,
        ),
      ],
    );
  }
}

class _StopinfoQueryLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query<Query$FetchStopInfo>(
      options: QueryOptions(
        document: documentNodeQueryFetchStopInfo,
        pollInterval: const Duration(days: 1),
      ),
      builder: (result, {fetchMore, refetch}) {
        final layout = Layout.of(context);

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        Enum$Mode? vehicleMode;
        String? stopName;
        if (!result.isLoading) {
          vehicleMode = result.parsedData?.stop?.vehicleMode;
          stopName = result.parsedData?.stop?.name;
        }
        vehicleMode ??= Enum$Mode.BUS;
        stopName ??= "< LOADING >";

        return Column(
          children: [
            MainLayoutHeader(
              stopVehicleMode: vehicleMode,
            ),
            SizedBox(height: layout.padding),
            Padding(
              padding: EdgeInsets.symmetric(vertical: layout.halfPadding),
              child: MainLayoutTitle(
                stopName: stopName,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StoptimeRecord {
  final String lineNumber;
  final String headsign;
  final DateTime arrivalTime;

  _StoptimeRecord.fromQuery(
      Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns stoptimes):lineNumber = stoptimes.
}

class _StoptimeQueryLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Query<Query$FetchStopStoptimes>(
      options: QueryOptions(
        document: documentNodeQueryFetchStopStoptimes,
        pollInterval: const Duration(seconds: 30),
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        final stoptimes = result.parsedData?.stop?.stoptimesWithoutPatterns;
      },
    );
  }
}

class _Stoptimes extends StatefulWidget {
  final List<Query$FetchStopStoptimes$stop$stoptimesWithoutPatterns> stoptimes;
  final bool shrinkWrap;

  const _Stoptimes({this.shrinkWrap = false, required this.stoptimes});

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
