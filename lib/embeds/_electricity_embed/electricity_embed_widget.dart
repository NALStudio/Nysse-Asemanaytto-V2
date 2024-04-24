import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/components/layout.dart';
import 'package:nysse_asemanaytto/core/helpers/datetime.dart';
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
      ElectricityEmbedWidget(key: _embedWidgetKey);
}

final GlobalKey<ElectricityPricingState> _electricityDataKey = GlobalKey();
final GlobalKey<_ElectricityEmbedWidgetState> _embedWidgetKey = GlobalKey();

class ElectricityEmbedWidget extends StatefulWidget
    implements EmbedWidgetMixin {
  const ElectricityEmbedWidget({super.key});

  @override
  State<ElectricityEmbedWidget> createState() => _ElectricityEmbedWidgetState();

  @override
  Duration getDuration() {
    final bool showTomorrow = _shouldShowTomorrowPrices();
    return Duration(seconds: showTomorrow ? 15 : 10);
  }

  @override
  void onDisable() {
    _embedWidgetKey.currentState?.onDisable();
  }

  @override
  void onEnable() {
    // update electricity data before doing any logic on it
    _electricityDataKey.currentState?.update();

    final bool showTomorrow = _shouldShowTomorrowPrices();
    _embedWidgetKey.currentState?.onEnable(showTomorrowPrices: showTomorrow);
  }

  bool _shouldShowTomorrowPrices() {
    DateTime tomorrow =
        DateTimeHelpers.getDate(DateTime.now()).add(const Duration(days: 1));

    // must be above 0
    // NOTE: Might need a third one during winter time, not sure, haven't tested yet...
    const int minTomorrowPricesRequired = 2;

    // we don't check prices.length > (24 + minTomorrowPricesRequired)
    // because some hours can be grouped or missing
    final List<ElectricityPrice>? prices =
        _electricityDataKey.currentState?.prices;

    // do not show next day electricity price if there aren't at least 2 hours worth of data.
    if (prices != null && prices.length >= minTomorrowPricesRequired) {
      // check if last two hours are in tomorrow
      return prices.reversed
          .take(minTomorrowPricesRequired)
          .every((p) => p.endTime.isAfter(tomorrow));
    } else {
      return false;
    }
  }
}

class _ElectricityEmbedWidgetState extends State<ElectricityEmbedWidget> {
  Timer? switchDayTimer;

  int _dayIndex = 0;

  void onDisable() {
    // set this on disable so the animation isn't ran when enabling
    _dayIndex = 0;
  }

  void onEnable({required bool showTomorrowPrices}) {
    assert(_dayIndex == 0);

    if (showTomorrowPrices) {
      final Duration switchDayDur = widget.getDuration() * 0.5;

      switchDayTimer = Timer(
        switchDayDur,
        () => setState(() {
          assert(_dayIndex == 0);
          _dayIndex = 1;
        }),
      );
    }
  }

  @override
  void dispose() {
    switchDayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ElectricityPricing(
      key: _electricityDataKey,
      child: _ChartWidget(dayIndex: _dayIndex),
    );
  }
}

class _ChartWidget extends StatelessWidget {
  final int dayIndex;

  const _ChartWidget({required this.dayIndex});

  @override
  Widget build(BuildContext context) {
    final layout = Layout.of(context);
    final double chartPadding = layout.padding;

    final DateTime minDate =
        DateTimeHelpers.getDate(DateTime.now()).add(Duration(days: dayIndex));
    final DateTime maxDate = minDate.add(const Duration(days: 1));

    List<ElectricityPrice> prices = ElectricityPricing.of(context)
        .prices
        .skipWhile((value) => value.startTime.isBefore(minDate))
        .takeWhile((value) => value.startTime.isBefore(maxDate))
        .toList(growable: false);

    const double defaultMin = 0;
    const double defaultMax = 1;

    double? minPrice;
    int? minPriceHour;
    double? maxPrice;
    int? maxPriceHour;
    for (ElectricityPrice price in prices) {
      if (maxPrice == null || price.price > maxPrice) {
        maxPrice = price.price;
        maxPriceHour = price.startTime.hour;
      }
      if (minPrice == null || price.price < minPrice) {
        minPrice = price.price;
        minPriceHour = price.startTime.hour;
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
        final int? nowHour;
        if (now.isBefore(minDate) || now.isAfter(maxDate)) {
          nowHour = null;
        } else {
          nowHour = now.hour;
        }

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

        final Set<int> tooltipHours;
        if (nowHour != null) {
          tooltipHours = {nowHour};
        } else {
          tooltipHours = Set.from([minPriceHour, maxPriceHour].nonNulls);
        }

        return BarChart(
          BarChartData(
            minY: minY,
            maxY: maxY,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                  return _getBarTooltipItem(
                    group,
                    groupIndex,
                    rod,
                    rodIndex,
                    nowHour: nowHour,
                  );
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
              border: Border(
                top: borderSideFromLineStyle,
                bottom: minY < 0 ? borderSideFromLineStyle : BorderSide.none,
              ),
            ),
            barGroups: _buildBarGroups(
              context,
              prices: prices,
              minPrice: minPrice!,
              maxPrice: maxPrice!,
              barWidth: barWidth,
              showTooltip: (hour) => tooltipHours.contains(hour),
            ),
          ),
        );
      }),
    );
  }
}

BarChartGroupData _buildGroup(
  BuildContext context, {
  required int index,
  required double value,
  required double width,
  required Color color,
  required bool showTooltip,
}) {
  final Radius barBorderRadius =
      Radius.circular(Layout.of(context).quarterPadding);

  return BarChartGroupData(
    x: index,
    showingTooltipIndicators: showTooltip ? [0] : null,
    barRods: [
      BarChartRodData(
        fromY: 0,
        toY: value,
        color: color,
        width: width,
        borderRadius: BorderRadius.vertical(
          top: value > 0 ? barBorderRadius : Radius.zero,
          bottom: value < 0 ? barBorderRadius : Radius.zero,
        ),
      ),
    ],
  );
}

List<BarChartGroupData> _buildBarGroups(
  BuildContext context, {
  required List<ElectricityPrice> prices,
  required double minPrice,
  required double maxPrice,
  required double barWidth,
  required bool Function(int hour) showTooltip,
}) {
  List<BarChartGroupData> hours = List.empty(growable: true);
  final double missingHourDefaultValue = ((minPrice + maxPrice) / 2);
  const Color missingHourColor = Colors.grey;

  for (ElectricityPrice p in prices) {
    // hours before this price (aka. hours missing from price data)
    while (hours.length < p.startTime.hour) {
      final int hour = hours.length;
      hours.add(_buildGroup(
        context,
        index: hour,
        value: missingHourDefaultValue,
        width: barWidth,
        color: missingHourColor,
        showTooltip: showTooltip(hour),
      ));
    }

    // hours this price data ranges from
    final int endTimeHour;
    // assuming that end is after start
    if (p.startTime.day == p.endTime.day) {
      endTimeHour = p.endTime.hour;
    } else {
      endTimeHour = 24 + p.endTime.hour;
    }

    while (hours.length < endTimeHour) {
      final int hour = hours.length;
      hours.add(_buildGroup(
        context,
        index: hour,
        value: p.price,
        width: barWidth,
        color: _barColor(p.price).toColor(),
        showTooltip: showTooltip(hour),
      ));
    }
  }

  if (hours.length > 24) {
    throw ArgumentError(
      "Too many price hours provided, expected: <=24, got: ${hours.length}",
    );
  }

  while (hours.length < 24) {
    final int hour = hours.length;
    hours.add(_buildGroup(
      context,
      index: hour,
      value: missingHourDefaultValue,
      width: barWidth,
      color: missingHourColor,
      showTooltip: showTooltip(hour),
    ));
  }

  return hours;
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
  required int? nowHour,
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
