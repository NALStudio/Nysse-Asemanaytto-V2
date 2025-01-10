import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:nysse_asemanaytto/core/helpers/datetime.dart';

import '_forecast.dart';

Uri _buildUri({
  required String storedQuery,
  required Map<String, String> parameters,
}) {
  return Uri.https(
    "opendata.fmi.fi",
    "wfs",
    {
      "service": "WFS",
      "version": "2.0.0",
      "request": "getFeature",
      "storedquery_id": storedQuery,
      ...parameters,
    },
  );
}

Future<Forecast> getForecast(
  LatLng latlon, {
  DateTime? startTime,
  DateTime? endTime,

  /// Durations under a minute are handled identically to [Duration.inMinutes].
  Duration? timestep,
}) async {
  final Map<String, String> params = {
    "latlon": "${latlon.latitude},${latlon.longitude}",
    "parameters": "Temperature,SmartSymbol",
  };

  if (startTime != null) {
    params["starttime"] = DateTimeHelpers.toIso8601StringWithOffset(startTime);
  }
  if (endTime != null) {
    params["endtime"] = DateTimeHelpers.toIso8601StringWithOffset(endTime);
  }
  // Dart converts to UTC anyway
  // if (timezone != null) {
  //   params["timezone"] = timezone;
  // }
  if (timestep != null) {
    params["timestep"] = timestep.inMinutes.toString();
  }

  final response = await http.get(_buildUri(
    storedQuery:
        "fmi::forecast::edited::weather::scandinavia::point::timevaluepair",
    parameters: params,
  ));

  return Forecast.parse(response.body);
}
