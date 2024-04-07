import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/helpers/helpers.dart';
import 'package:nysse_asemanaytto/embeds/_electricity_embed/electricity_pricing.dart';
import 'package:nysse_asemanaytto/embeds/_electricity_embed/electricity_embed_settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class ElectricityEmbed extends Embed {
  const ElectricityEmbed({required super.name});

  @override
  EmbedSettings<Embed> createDefaultSettings() =>
      const ElectricityEmbedSettings();

  @override
  EmbedWidgetMixin<Embed> createEmbed(
          covariant EmbedSettings<Embed> settings) =>
      const ElectricityEmbedWidget();
}

final GlobalKey<ElectricityPricingState> _electricityDataKey = GlobalKey();

class ElectricityEmbedWidget extends StatelessWidget
    implements EmbedWidgetMixin {
  const ElectricityEmbedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElectricityPricing(
      key: _electricityDataKey,
      child: _ChartWidget(),
    );
  }

  @override
  Duration? getDuration() => const Duration(seconds: 10);

  @override
  void onDisable() {}

  @override
  void onEnable() {
    _electricityDataKey.currentState?.update();
  }
}

class _ChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double defaultMin = 0;
    const double defaultMax = 1;

    final layout = Layout.of(context);
    final double chartPadding = layout.padding;

    final pricing = ElectricityPricing.of(context);
    final List<double?> prices = pricing.todayPrices;

    // ignore: unused_local_variable
    int? minPriceIndex;
    double? minPrice;

    // ignore: unused_local_variable
    int? maxPriceIndex;
    double? maxPrice;
    for (final (int index, double? price) in prices.indexed) {
      if (price == null) continue;
      if (maxPrice == null || price > maxPrice) {
        maxPriceIndex = index;
        maxPrice = price;
      } else if (minPrice == null || price < minPrice) {
        minPriceIndex = index;
        minPrice = price;
      }
    }
    minPrice ??= defaultMin;
    maxPrice ??= defaultMax;

    final double minY = math.min(minPrice.floorToDouble(), defaultMin);
    final double maxY = math.max(maxPrice.ceilToDouble(), defaultMax);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        top: chartPadding,
        right: chartPadding,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final DateTime now = DateTime.now();

        final double leftAxisSize = 2 * chartPadding; // 44;
        final double bottomAxisSize = 2 * chartPadding; // 30;

        final double contentWidth = constraints.maxWidth - leftAxisSize;

        final double barSpacing = 10 * layout.logicalPixelSize;
        final double barWidth = (contentWidth / 24) - (barSpacing / 2);

        final FlLine lineStyle = FlLine(
          color: Colors.blueGrey,
          strokeWidth: layout.logicalPixelSize,
          // dashArray: [8, 4],
        );
        final BorderSide borderSideFromLineStyle = BorderSide(
          color: lineStyle.color!,
          width: lineStyle.strokeWidth,
        );
        final Radius barBorderRadius = Radius.circular(layout.halfPadding / 2);

        return BarChart(
          BarChartData(
            minY: minY,
            maxY: maxY,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return _getBarTooltipItem(group, groupIndex, rod, rodIndex,
                      nowHour: now.hour);
                },
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: leftAxisSize,
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(reservedSize: 0),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(reservedSize: 0),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: bottomAxisSize,
                  getTitlesWidget: (value, meta) {
                    final int v = value.toInt();
                    assert(v == value);
                    if (v.isEven) {
                      return Text("${v.toString().padLeft(2, '0')}:00");
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) => lineStyle,
            ),
            borderData: FlBorderData(
              show: minY < 0,
              border: Border(
                top: borderSideFromLineStyle,
                bottom: minY < 0 ? borderSideFromLineStyle : BorderSide.none,
              ),
            ),
            barGroups: prices.indexed.map(
              (e) {
                final (int index, double? price) = e;
                final Color color;
                if (price != null) {
                  color = _barColor(price).toColor();
                } else {
                  color = Colors.grey;
                }

                final double toY = e.$2 ?? ((minPrice! + maxPrice!) / 2);

                return BarChartGroupData(
                  x: index,
                  showingTooltipIndicators: index == now.hour ? [0] : null,
                  barRods: [
                    BarChartRodData(
                      fromY: 0,
                      toY: toY,
                      color: color,
                      width: barWidth,
                      borderRadius: BorderRadius.vertical(
                        top: toY > 0 ? barBorderRadius : Radius.zero,
                        bottom: toY < 0 ? barBorderRadius : Radius.zero,
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        );
      }),
    );
  }
}

HSVColor _barColor(double price) {
  const double priceMin = 0;
  const double hueMin = 180;
  const double priceMax = 25;
  const double hueMax = 0;
  double hue = remapDouble(
    price.clamp(priceMin, priceMax),
    priceMin,
    priceMax,
    hueMin,
    hueMax,
  );

  const double valuePriceMin = priceMax;
  const double valuePriceMax = valuePriceMin + (priceMax - priceMin);
  double value = remapDouble(
    price.clamp(valuePriceMin, valuePriceMax),
    valuePriceMin,
    valuePriceMax,
    1.0,
    0.0,
  );

  return HSVColor.fromAHSV(1.0, hue, 1.0, value);
}

BarTooltipItem? _getBarTooltipItem(
  BarChartGroupData group,
  int groupIndex,
  BarChartRodData rod,
  int rodIndex, {
  required int nowHour,
}) {
  final Color color = rod.color!;
  final valueTextStyle = TextStyle(
    color: color,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  const headerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );
  final String priceText = rod.toY.toString().replaceFirst('.', ',');
  return BarTooltipItem(
    groupIndex == nowHour ? "Hinta Nyt" : formatTime(groupIndex, 0),
    headerTextStyle,
    children: [
      TextSpan(text: "\n$priceText snt/kWh", style: valueTextStyle),
    ],
  );
}
