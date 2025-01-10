import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/helpers/datetime.dart';
import 'package:nysse_asemanaytto/core/helpers/helpers.dart';
import 'package:nysse_asemanaytto/embeds/_weather_embed/_weather_symbol_provider.dart';
import 'package:nysse_asemanaytto/fmi_open_data/fmi_open_data.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';
import '../embeds.dart';
import 'dart:developer' as developer;

final GlobalKey<_WeatherEmbedWidgetState> _weatherKey = GlobalKey();

// Weather embed doesn't display anything on first render
// because stop latitude and longitude information is not yet available
class WeatherEmbed extends Embed {
  static const int stepCount = 4;

  // During winter, Finland's UTC offset is +2
  // during this time the timestep 3 returns times 2, 5, 8, 11, ...
  // I don't like this, so I'll use timestep 1 instead
  static const int timestepHours = 1;
  static const int pollRateMinutes = (timestepHours * 60) ~/ 4;
  static const Duration timestep = Duration(hours: timestepHours);

  const WeatherEmbed({required super.name});

  @override
  EmbedWidgetMixin<WeatherEmbed> createEmbed(WeatherEmbedSettings settings) =>
      WeatherEmbedWidget(key: _weatherKey);

  @override
  EmbedSettings<Embed> createDefaultSettings() => const WeatherEmbedSettings();
}

class WeatherEmbedWidget extends StatefulWidget
    with EmbedWidgetMixin<WeatherEmbed> {
  WeatherEmbedWidget({super.key});

  @override
  State<WeatherEmbedWidget> createState() => _WeatherEmbedWidgetState();

  @override
  Duration? getDuration() => const Duration(seconds: 15);

  @override
  void onDisable() {}

  @override
  void onEnable() {
    _weatherKey.currentState?.update();
  }
}

class _WeatherEmbedWidgetState extends State<WeatherEmbedWidget> {
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
  void update({DateTime? now}) {
    now ??= DateTime.now();
    assert(DateTimeHelpers.isLocalDateTime(now));

    if (forecast == null ||
        fetchNextTimeOn == null ||
        now.isAfter(fetchNextTimeOn!)) {
      _getWeather(now: now).then((value) => setState(() => forecast = value));

      fetchNextTimeOn = DateTimeHelpers.getHour(now).add(
        const Duration(minutes: WeatherEmbed.pollRateMinutes),
      );
    }
  }

  Future<Forecast?> _getWeather({required DateTime now}) async {
    developer.log(
      "Fetching weather...",
      name: "weather_embed._WeatherEmbedWidgetState",
    );

    final stopinfo = StopInfo.of(context);
    if (stopinfo == null) return null;

    final DateTime startTime = DateTimeHelpers.roundToNearestHour(now);
    final DateTime endTime = startTime.add(
      Duration(hours: WeatherEmbed.stepCount * WeatherEmbed.timestepHours),
    );

    final LatLng pos = LatLng(stopinfo.lat, stopinfo.lon);
    Forecast weather;
    try {
      weather = await getForecast(
        pos,
        startTime: startTime,
        endTime: endTime,
        timestep: WeatherEmbed.timestep,
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

class __WeatherSymbol extends StatefulWidget {
  final int? symbol;
  final double width;

  const __WeatherSymbol({required this.symbol, required this.width});

  @override
  State<__WeatherSymbol> createState() => __WeatherSymbolState();
}

class __WeatherSymbolState extends State<__WeatherSymbol> {
  Map<int, String>? weatherSymbols;

  @override
  void initState() {
    super.initState();

    loadWeatherSymbols(DefaultAssetBundle.of(context)).then((value) {
      setState(() => weatherSymbols = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    int? symbol = widget.symbol;
    if (symbol == null) {
      return const FlutterLogo();
    }

    if (weatherSymbols == null) {
      return SvgPicture.defaultPlaceholderBuilder(context);
    }

    // day or night symbol
    String? symbolAsset = weatherSymbols![symbol];
    if (symbolAsset == null) {
      assert(symbol > 100);

      // fall back on day symbol only
      symbolAsset = weatherSymbols![symbol - 100];
      assert(symbolAsset != null);
    }

    return SvgPicture.asset(
      symbolAsset!,
      alignment: Alignment.topCenter,
      width: widget.width,
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
