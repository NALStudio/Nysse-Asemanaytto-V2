import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import './electricity_production_embed_settings.dart';
import '_electricity_production.dart';
import 'dart:developer' as developer;

GlobalKey<_ElectricityProductionEmbedWidgetState> _widgetState = GlobalKey();

class ElectricityProductionEmbed extends Embed {
  const ElectricityProductionEmbed({required super.name});

  @override
  EmbedWidgetMixin<ElectricityProductionEmbed> createEmbed(
          covariant ElectricityProductionEmbedSettings settings) =>
      ElectricityProductionEmbedWidget(key: _widgetState, settings: settings);

  @override
  EmbedSettings<Embed> createDefaultSettings() =>
      ElectricityProductionEmbedSettings(
        apiKey: null,
        pollRateMinutes: 3,
        showPieChartTitles: true,
      );
}

const List<Dataset> _datasets = [
  Dataset(
    id: 192,
    updateRate: Duration(minutes: 3),
    isTotalValue: true,
    title: "Tuotanto",
    unit: "MW",
    color: Color(0xFF277158),
  ),
  Dataset(
    id: 193,
    updateRate: Duration(minutes: 3),
    isTotalValue: true,
    title: "Kulutus",
    unit: "MW",
    color: Color(0xFF683956),
  ),
  Dataset(
    id: 188,
    updateRate: Duration(minutes: 3),
    title: "Ydinvoima",
    unit: "MW",
    color: Color(0xFFdcc81c),
  ),
  Dataset(
    id: 191,
    updateRate: Duration(minutes: 3),
    title: "Vesivoima",
    unit: "MW",
    color: Color(0xFF84c8f7),
  ),
  Dataset(
    id: 202,
    updateRate: Duration(minutes: 3),
    title: "Yhteistuotanto",
    subtitle: "teollisuus",
    unit: "MW",
    color: Color(0xFF6d838f),
  ),
  Dataset(
    id: 201,
    updateRate: Duration(minutes: 3),
    title: "Yhteistuotanto",
    subtitle: "kaukolämpö",
    unit: "MW",
    color: Color(0xFFd5dde3),
  ),
  Dataset(
    id: 181,
    updateRate: Duration(minutes: 3),
    title: "Tuulivoima",
    unit: "MW",
    color: Color(0xFF4d9d88),
  ),
  Dataset(
    id: 248,
    updateRate: Duration(minutes: 15),
    title: "Aurinkovoima",
    unit: "MW",
    color: Color(0xFFffef62),
  ),
  Dataset(
    id: 205,
    updateRate: Duration(minutes: 3),
    title: "Muu tuotanto",
    unit: "MW",
    color: Color(0xFFe5b2bb),
  ),
  Dataset(
    id: 183,
    updateRate: Duration(minutes: 3),
    title: "Tehoreservi",
    unit: "MW",
    color: Color(0xFFd5121e),
  ),
];

class ElectricityProductionEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin<ElectricityProductionEmbed> {
  final ElectricityProductionEmbedSettings settings;

  const ElectricityProductionEmbedWidget({super.key, required this.settings});

  @override
  State<ElectricityProductionEmbedWidget> createState() =>
      _ElectricityProductionEmbedWidgetState();

  @override
  Duration? getDuration() => const Duration(seconds: 15);

  @override
  void onDisable() {}

  @override
  void onEnable() {
    if (settings.apiKey != null) {
      _widgetState.currentState?.update();
    }
  }
}

const TextStyle _kDefaultTextStyle = TextStyle(
  fontFamily: "Inter",
  height: 1.0,
  color: Color(0xFF3d5560),
);

class _ElectricityProductionEmbedWidgetState
    extends State<ElectricityProductionEmbedWidget> {
  final Map<int, double> data = {};
  Exception? error;

  DateTime? refreshAfter;

  void update() {
    DateTime now = DateTime.now();
    if (refreshAfter != null && !now.isAfter(refreshAfter!)) {
      return;
    }

    developer.log(
      "Fetching electricity production data...",
      name:
          "_electricity_production_embed._ElectricityProductionEmbedWidgetState",
    );

    getData(
      apiKey: widget.settings.apiKey!,
      datasets: _datasets,
      now: now,
    ).then((value) => _setData(value));
  }

  void _setData(FingridData data) {
    setState(() {
      refreshAfter = data.recommendedRefreshTime;

      if (data.error != null) {
        error = data.error;
      } else {
        for (final entry in data.data!.entries) {
          this.data[entry.key.id] = entry.value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.settings.apiKey == null) {
      return ErrorWidget.withDetails(message: "No API key provided.");
    }
    if (error != null) {
      return ErrorWidget(error!);
    }

    Map<Dataset, double?> subproduction = Map.fromEntries(
      _datasets
          .where((e) => !e.isTotalValue)
          .map((e) => MapEntry(e, data[e.id])),
    );

    double sumProduction = 0;
    for (double? p in subproduction.values) {
      if (p != null) {
        sumProduction += p;
      }
    }

    final layout = Layout.of(context);

    return Container(
      color: const Color(0xFFf3f6f8),
      padding: EdgeInsets.all(layout.padding),
      child: LayoutBuilder(builder: (context, constraints) {
        final double elementHeight = constraints.maxHeight;

        final double titleHeight = layout.tileHeight / 2;
        final double chartSize = elementHeight - titleHeight - layout.padding;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: elementHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sähköjärjestelmän tila",
                    textAlign: TextAlign.center,
                    style: _kDefaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: titleHeight,
                    ),
                  ),
                  SizedBox(
                    height: chartSize,
                    child: AspectRatio(
                      aspectRatio: 1 / 1,
                      child: _ProductionChart(
                        data: subproduction,
                        dataSum: sumProduction,
                        showTitle: widget.settings.showPieChartTitles,
                        radius: chartSize / 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: layout.padding),
            Expanded(
              child: _ProductionDataChart(
                data: Map.fromEntries(
                  _datasets.map((e) => MapEntry(e, data[e.id])),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _ProductionChart extends StatelessWidget {
  final Map<Dataset, double?> data;
  final double dataSum;

  final bool showTitle;
  final double radius;

  const _ProductionChart({
    required this.data,
    required this.dataSum,
    required this.showTitle,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final List<PieChartSectionData> sections =
        data.entries.where((e) => e.value != null).map(
      (e) {
        double value = e.value!;
        double frac = value / dataSum;

        return PieChartSectionData(
          value: e.value,
          color: e.key.color,
          radius: radius,
          showTitle: showTitle && frac >= 0.1,
          title: "${(frac * 100).round()} %",
          titleStyle: _kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold),
        );
      },
    ).toList(growable: true);
    // sort as reverse so that chart goes from biggest down clockwise
    sections.sort((a, b) => b.value.compareTo(a.value));

    return PieChart(
      PieChartData(
        centerSpaceRadius: 0,
        sectionsSpace: radius / 100,
        borderData: FlBorderData(show: false),
        startDegreeOffset: -90,
        pieTouchData: PieTouchData(enabled: false),
        sections: sections,
      ),
    );
  }
}

class _ProductionDataChart extends StatelessWidget {
  final Map<Dataset, double?> data;

  const _ProductionDataChart({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);

    final List<Widget> children = data.entries
        .map(
          (e) => __ProductionData(
            title: e.key.title,
            subtitle: e.key.subtitle,
            value: e.value,
            color: e.key.color,
            icon: e.key.isTotalValue
                ? SvgPicture.asset(
                    "assets/images/icon_fingrid_chart.svg",
                    colorFilter:
                        const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  )
                : null,
          ),
        )
        .toList(growable: false);

    return LayoutBuilder(builder: (context, constraints) {
      final double spacingX = layout.quarterPadding;
      final double spacingY = layout.quarterPadding;

      const int crossAxisCount = 2;
      final int rowCount = (children.length / crossAxisCount).ceil();

      final double trueWidth =
          constraints.maxWidth - ((crossAxisCount - 1) * spacingX);
      final double trueHeight =
          constraints.maxHeight - ((rowCount - 1) * spacingY);

      final double childWidth = trueWidth / crossAxisCount;
      final double childHeight = trueHeight / rowCount;

      return GridView.count(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: spacingY,
        crossAxisSpacing: spacingX,
        childAspectRatio: childWidth / childHeight,
        children: children,
      );
    });
  }
}

class __ProductionData extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double? value;
  final Color color;
  final Widget? icon;

  const __ProductionData({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final layout = Layout.of(context);

      final double fontSize = constraints.maxHeight / 6;

      final TextStyle textStyle =
          _kDefaultTextStyle.copyWith(fontSize: fontSize);

      return Container(
        padding: EdgeInsets.only(
          left: layout.halfPadding,
          right: layout.halfPadding,
        ),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget?>[
            Text(title, style: textStyle),
            subtitle != null
                ? Text(
                    subtitle!,
                    style: textStyle.copyWith(
                      color: textStyle.color!.withAlpha(192),
                      fontStyle: FontStyle.italic,
                    ),
                  )
                : null,
            SizedBox(height: layout.quarterPadding),
            Row(
              children: [
                SizedBox(
                  width: 2 * fontSize,
                  height: 2 * fontSize,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(layout.halfPadding),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 1.5 * fontSize,
                        height: 1.5 * fontSize,
                        child: icon,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: layout.quarterPadding),
                Text(
                  (value?.round() ?? "???").toString(),
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize * 2,
                  ),
                ),
                SizedBox(width: layout.quarterPadding),
                Padding(
                  padding: EdgeInsets.only(top: fontSize / 2),
                  child: Text(
                    "MW",
                    style: textStyle,
                  ),
                ),
              ],
            ),
          ].nonNulls.toList(growable: false),
        ),
      );
    });
  }
}
