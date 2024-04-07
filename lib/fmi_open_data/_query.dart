import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '_enum.dart';
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
  ForecastModel model = ForecastModel.edited,
  DateTime? startTime,
  DateTime? endTime,

  /// default: UTC
  String? timezone,

  /// Durations under a minute are handled identically to [Duration.inMinutes].
  Duration? timestep,
}) async {
  final Map<String, String> params = {
    "latlon": "${latlon.latitude},${latlon.longitude}",
    "parameters": "Temperature,SmartSymbol",
  };

  if (startTime != null) {
    params["starttime"] = startTime.toUtc().toIso8601String();
  }
  if (endTime != null) {
    params["endtime"] = endTime.toUtc().toIso8601String();
  }
  if (timezone != null) {
    params["timezone"] = timezone;
  }
  if (timestep != null) {
    params["timestep"] = timestep.inMinutes.toString();
  }

  final response = await http.get(_buildUri(
    storedQuery:
        "fmi::forecast::${model.name}::weather::scandinavia::point::timevaluepair",
    parameters: params,
  ));

  return Forecast.parse(response.body);
}
