import 'dart:collection';

import 'package:xml/xml.dart';

class Temperature {
  final double celsius;
  double get kelvin => celsius + 273.15;
  double get fahrenheit => (celsius * 1.8) + 32;

  Temperature({required this.celsius});
}

class Weather {
  final DateTime utc;

  /// in degrees celsius
  final Temperature? temperature;

  /// [weatherSymbol] represents an FMI SmartSymbol
  final int? weatherSymbol;

  Weather._({
    required this.utc,
    required this.temperature,
    required this.weatherSymbol,
  }) {
    assert(utc.isUtc);
  }

  factory Weather._parse({
    required DateTime dateTime,
    required _ParsedData data,
  }) {
    Temperature? temperature;
    int? weatherSymbol;

    for (final p in data.data) {
      switch (p.dataType) {
        case "Temperature":
          temperature = Temperature(celsius: double.parse(p.value));
        case "SmartSymbol":
          weatherSymbol = int.parse(p.value);
      }
    }

    return Weather._(
      utc: dateTime,
      temperature: temperature,
      weatherSymbol: weatherSymbol,
    );
  }
}

class Forecast {
  final List<Weather> weather;

  Forecast._({required this.weather});

  /// Unsafe parsing of forecast.
  factory Forecast.parse(String response) {
    final doc = XmlDocument.parse(response);
    final Map<DateTime, _ParsedData> map = _parseData(doc);

    List<Weather> weathers = map.entries
        .map((e) => Weather._parse(dateTime: e.key, data: e.value))
        .toList(growable: false);
    return Forecast._(weather: UnmodifiableListView(weathers));
  }
}

class _ParsedDataPoint {
  final String dataType;
  final String value;

  _ParsedDataPoint({required this.dataType, required this.value});
}

class _ParsedData {
  final List<_ParsedDataPoint> data;

  _ParsedData() : data = List.empty(growable: true);
}

String _getSingleChildValue(XmlElement element, String name) {
  final List<XmlElement> children = element.findElements(name).toList();
  assert(children.length == 1);

  final childValues = children[0].children;
  assert(childValues.length == 1);

  final String? value = childValues[0].value;
  assert(value != null);

  return value!;
}

/// Custom exceptions removed due to code clutter.
Map<DateTime, _ParsedData> _parseData(XmlDocument doc) {
  Map<DateTime, _ParsedData> map = {};

  // All measurements are contained in blocks of MeasurementTimeseries
  // These are of a single data type described in the id.
  for (final mts in doc.findAllElements("wml2:MeasurementTimeseries")) {
    final String id = mts.getAttribute("gml:id")!;

    // parse data type from id (Temperature, WeatherSymbol3, etc.)
    final String dataType = id.split('-').last;

    // MeasurementTimeseries contains (data) points
    for (final p in mts.childElements) {
      assert(p.name.prefix == "wml2");
      assert(p.name.local == "point");

      // each (data) point seems to only contain one measurement.
      for (final m in p.childElements) {
        assert(m.name.prefix == "wml2");
        assert(m.name.local == "MeasurementTVP");

        final String timestampStr = _getSingleChildValue(m, "wml2:time");
        final DateTime timestamp = DateTime.parse(timestampStr);

        final String value = _getSingleChildValue(m, "wml2:value");

        _ParsedData? data = map[timestamp];
        if (data == null) {
          data = _ParsedData();
          map[timestamp] = data;
        }

        data.data.add(_ParsedDataPoint(dataType: dataType, value: value));
      }
    }
  }

  return map;
}
