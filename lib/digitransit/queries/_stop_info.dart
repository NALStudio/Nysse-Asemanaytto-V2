import 'package:nysse_asemanaytto/digitransit/enums.dart';

class DigitransitStopInfoQuery {
  static const String query = """
query getStopInfo(\$stopId: String!)
{
  stop(id: \$stopId) {
    name
    vehicleMode
  }
}
""";
  final String name;
  final DigitransitMode? vehicleMode;

  const DigitransitStopInfoQuery({
    required this.name,
    required this.vehicleMode,
  });

  static DigitransitStopInfoQuery? parse(Map<String, dynamic>? data) {
    final Map<String, dynamic>? stop = data?["stop"];
    if (stop == null) return null;

    final String? vehicleMode = stop["vehicleMode"];
    return DigitransitStopInfoQuery(
      name: stop["name"],
      vehicleMode: vehicleMode != null ? DigitransitMode(vehicleMode) : null,
    );
  }
}
