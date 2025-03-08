import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/helpers/datetime.dart';
import 'package:nysse_asemanaytto/core/helpers/helpers.dart';
import 'package:nysse_asemanaytto/fmi_open_data/fmi_open_data.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import 'embeds.dart';

final GlobalKey<_WeatherEmbedWidgetState> _weatherKey = GlobalKey();

// Weather embed doesn't display anything on first render
// because stop latitude and longitude information is not yet available
class WeatherEmbed extends Embed {
  static const int stepCount = 4;

  const WeatherEmbed({required super.name});

  @override
  EmbedWidgetMixin<WeatherEmbed> createEmbed(WeatherEmbedSettings settings) =>
      _WeatherEmbedWidget(key: _weatherKey);

  @override
  EmbedSettings<Embed> createDefaultSettings() => const WeatherEmbedSettings();
}

class _WeatherEmbedWidget extends StatefulWidget
    with EmbedWidgetMixin<WeatherEmbed> {
  _WeatherEmbedWidget({super.key});

  @override
  State<_WeatherEmbedWidget> createState() => _WeatherEmbedWidgetState();

  @override
  Duration? getDuration() => const Duration(seconds: 15);

  @override
  void onDisable() {}

  @override
  void onEnable() {
    _weatherKey.currentState?.update();
  }
}

class _WeatherEmbedWidgetState extends State<_WeatherEmbedWidget> {
  final Logger _logger = Logger("WeatherEmbed");

  DateTime? fetchNextTimeOn;
  Forecast? forecast;
  Exception? forecastError;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (forecastError != null) {
      assert(forecast == null);
      child = ErrorWidget(forecastError!);
    } else {
      child = _ForegroundWeathers(
        weathers: forecast?.weather ?? List.empty(growable: false),
      );
    }

    return ColoredBox(
      color: Colors.white,
      child: child,
    );
  }

  /// Updates the weather data if necessary
  /// Updated values will rebuild the inherited widget once they are loaded.
  void update() {
    DateTime now = DateTime.now();

    if (forecast == null ||
        fetchNextTimeOn == null ||
        now.isAfter(fetchNextTimeOn!)) {
      Duration timestep = computeTimestep(now);
      _getWeather(now: now, timestep: timestep)
          .then((value) => setState(() => forecast = value));

      // Fetch new weather every hour
      fetchNextTimeOn = DateTimeHelpers.getHour(now).add(Duration(hours: 1));
    }
  }

  Duration computeTimestep(DateTime now) {
    // Ensure that we always display 00:00 weather at midnight
    assert(DateTimeHelpers.isLocalDateTime(now));
    int tzOffsetInHours = now.timeZoneOffset.inHours;
    int timestepHours;
    if (tzOffsetInHours % 3 == 0) {
      timestepHours = 3;
    } else if (tzOffsetInHours % 2 == 0) {
      timestepHours = 2;
    } else {
      timestepHours = 1;
    }

    return Duration(hours: timestepHours);
  }

  Future<Forecast?> _getWeather({
    required DateTime now,
    required Duration timestep,
  }) async {
    _logger.fine("Fetching weather...");

    final LatLng? pos = StopInfo.of(context)?.latlon;
    if (pos == null) return null;

    final DateTime startTime = DateTimeHelpers.roundToNearestHour(now);
    final DateTime endTime = startTime.add(timestep * WeatherEmbed.stepCount);

    Forecast weather;
    try {
      weather = await getForecast(
        pos,
        startTime: startTime,
        endTime: endTime,
        timestep: timestep,
      );
    } on Exception {
      return null;
    }

    return weather;
  }
}

class _ForegroundWeathers extends StatelessWidget {
  final List<Weather> weathers;

  const _ForegroundWeathers({required this.weathers});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Layout.of(context).widePadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildChildren().toList(growable: false),
      ),
    );
  }

  Iterable<Widget> _buildChildren() sync* {
    for (int i = 0; i < WeatherEmbed.stepCount; i++) {
      final Weather? w = weathers.length > i ? weathers[i] : null;

      if (i == 0) {
        yield _WeatherLarge(weather: w);
      } else {
        yield _WeatherSmall(weather: w);
      }
    }
  }
}

class __WeatherSymbol extends StatelessWidget {
  final int? symbol;
  final double width;

  const __WeatherSymbol({required this.symbol, required this.width});

  @override
  Widget build(BuildContext context) {
    if (symbol == null) {
      return const FlutterLogo();
    }

    return SvgPicture.asset(
      "assets/images/fmi_weather_symbols/${symbol!}.svg",
      alignment: Alignment.topCenter,
      width: width,
    );
  }
}

const TextStyle _kWeatherTextStyle = TextStyle(
  fontFamily: "Lato",
  height: 1.0,
);

class __WeatherTime extends StatelessWidget {
  final DateTime? time;
  final double fontSize;

  __WeatherTime({required this.time, required this.fontSize}) {
    assert(time == null || DateTimeHelpers.isLocalDateTime(time!));
  }

  @override
  Widget build(BuildContext context) {
    final String text;
    if (time == null) {
      text = "?:??";
    } else {
      text = formatTime2(time!.hour, time!.minute);
    }

    return Text(
      text,
      style: _kWeatherTextStyle.copyWith(fontSize: fontSize),
    );
  }
}

class __WeatherTemperature extends StatelessWidget {
  final double? temperature;
  final double fontSize;

  const __WeatherTemperature(
      {required this.temperature, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    final String temp = temperature?.round().toString() ?? "??";

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          temp,
          style: _kWeatherTextStyle.copyWith(fontSize: fontSize),
        ),
        Text(
          "°C",
          style: _kWeatherTextStyle.copyWith(
            fontSize: 0.8 * fontSize,
            height: 1.1,
          ),
        ),
      ],
    );
  }
}

class _WeatherSmall extends StatelessWidget {
  final Weather? weather;

  const _WeatherSmall({this.weather});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    final double fontSize = 48 * layout.logicalPixelSize;

    return Padding(
      padding: EdgeInsets.only(
        top: layout.doublePadding + layout.padding,
        bottom: 2 * layout.doublePadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          __WeatherSymbol(
            symbol: weather?.weatherSymbol,
            width: MediaQuery.sizeOf(context).width / 8,
          ),
          __WeatherTime(
            time: weather?.utc.toLocal(),
            fontSize: fontSize,
          ),
          __WeatherTemperature(
            temperature: weather?.temperature?.celsius,
            fontSize: fontSize,
          ),
        ],
      ),
    );
  }
}

class _WeatherLarge extends StatelessWidget {
  final Weather? weather;

  const _WeatherLarge({this.weather});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    final double width = MediaQuery.sizeOf(context).width / 3;
    final double fontSize = 64 * layout.logicalPixelSize;

    return Padding(
      padding: EdgeInsets.only(bottom: layout.doublePadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          __WeatherSymbol(
            symbol: weather?.weatherSymbol,
            width: width,
          ),
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                __WeatherTime(
                  time: weather?.utc.toLocal(),
                  fontSize: fontSize,
                ),
                __WeatherTemperature(
                  temperature: weather?.temperature?.celsius,
                  fontSize: fontSize,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class WeatherEmbedSettings extends EmbedSettings<WeatherEmbed> {
  const WeatherEmbedSettings();

  @override
  EmbedSettingsForm<EmbedSettings<Embed>> createForm(
    covariant WeatherEmbedSettings defaultSettings,
  ) =>
      WeatherEmbedSettingsForm(
          parentSettings: this, defaultSettings: defaultSettings);

  @override
  String serialize() {
    return "";
  }

  @override
  void deserialize(String serialized) {}
}

class WeatherEmbedSettingsForm extends EmbedSettingsForm {
  WeatherEmbedSettingsForm({
    required super.parentSettings,
    required super.defaultSettings,
  });

  @override
  Widget build(BuildContext context) {
    return EmbedSettingsForm.buildNoSettingsWidget(context);
  }

  @override
  Color get displayColor => Colors.lightBlue;

  @override
  String get displayName => "Weather Embed";
}
