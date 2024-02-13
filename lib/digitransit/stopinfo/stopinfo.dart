import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/digitransit/enums.dart';

class StopInfo extends StatefulWidget {
  final Widget child;

  const StopInfo({super.key, required this.child});

  @override
  State<StopInfo> createState() => StopInfoState();

  static StopInfoState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_StopInfoInherited>()
        ?.parent;
  }

  static StopInfoState of(BuildContext context) {
    final StopInfoState? result = maybeOf(context);
    assert(result != null, "No StopInfo found in context");
    return result!;
  }
}

class StopInfoState extends State<StopInfo> {
  int? _stopCode;
  int? get stopCode => _stopCode;
  set stopCode(int? value) => setState(() => _stopCode = value);

  StopMeta? _stopMeta;
  StopMeta? get stopMeta => _stopMeta;

  @override
  Widget build(BuildContext context) {
    return _StopInfoInherited(
      parent: this,
      child: widget.child,
    );
  }
}

class _StopInfoInherited extends InheritedWidget {
  final StopInfoState parent;

  const _StopInfoInherited({required super.child, required this.parent});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class StopMeta {
  final String gtfsId;
  final String name;
  final String? code;

  final double? lat;
  final double? lon;

  final DigitransitMode? mode;

  const StopMeta({
    required this.gtfsId,
    required this.name,
    required this.code,
    required this.lat,
    required this.lon,
    required this.mode,
  });
}

class Stoptime {
  final int? scheduledDeparture;
  final int? realtimeDeparture;
  final int? serviceDay;

  final bool? realtime;
  final DigitransitRealtimeState? realtimeState;

  /// Trip headsigns can change during the trip (e.g. on routes which run on loops),
  /// so this value should be used instead of the trip's headsign.
  final String? headsign;

  Stoptime({
    required this.scheduledDeparture,
    required this.realtimeDeparture,
    required this.serviceDay,
    required this.realtime,
    required this.realtimeState,
    required this.headsign,
  });

  DateTime? get scheduledDepartureDateTime =>
      getMixinDateTime(scheduledDeparture);
  DateTime? get realtimeDepartureDateTime =>
      getMixinDateTime(realtimeDeparture);

  DateTime? getMixinDateTime(int? mix) {
    if (mix != null && serviceDay != null) {
      final int totalSeconds = serviceDay! + mix;

      return DateTime.fromMillisecondsSinceEpoch(
        totalSeconds * 1000,
        isUtc: false,
      );
    }

    return null;
  }
}

String getQuery({required bool fetchStopMeta}) {
  String stopMetaArgs;
  if (fetchStopMeta) {
    stopMetaArgs = """
      gtfsId
      name
      code
      lat
      lon
      vehicleMode
""";
  } else {
    stopMetaArgs = "";
  }

  // TODO: A robust way to query only the data required.
  String query = """
    {
      stop(id: \$stopId) {
        $stopMetaArgs
        stoptimesWithoutPatterns(numberOfDepartures: \$numberOfDepartures, omitNonPickups: \$omitNonPickups, omitCanceled: \$omitCanceled) {
          scheduledDeparture
          realtimeDeparture
          serviceDay
          realtime
          realtimeState
          headsign
        }
      }
    }
""";

  return query.replaceAll(' ', "").replaceAll('\n', ' ');
}
