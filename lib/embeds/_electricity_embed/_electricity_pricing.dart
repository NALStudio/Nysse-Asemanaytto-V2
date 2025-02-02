import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';
import 'package:nysse_asemanaytto/core/helpers/datetime.dart';

final Uri _kDayAheadEndpoint = Uri.https(
  "api.porssisahko.net",
  "/v1/latest-prices.json",
);

bool _nextDayPricesAvailable(DateTime now) {
  assert(DateTimeHelpers.isLocalDateTime(now));
  final DateTime releaseDateTime = DateTime(now.year, now.month, now.day, 14);
  return now.isAfter(releaseDateTime);
}

class ElectricityPricing extends StatefulWidget {
  final Widget child;

  const ElectricityPricing({
    super.key,
    required this.child,
  });

  @override
  State<ElectricityPricing> createState() => ElectricityPricingState();

  static ElectricityPricingState? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_ElectricityDataInherited>()
        ?.parent;
  }

  static ElectricityPricingState of(BuildContext context) {
    final ElectricityPricingState? result = maybeOf(context);
    assert(result != null, "No config found in context.");
    return result!;
  }
}

class ElectricityPrice {
  final DateTime startTime;
  final DateTime endTime;
  final double price;

  ElectricityPrice({
    required this.startTime,
    required this.endTime,
    required this.price,
  });

  factory ElectricityPrice._parse(dynamic obj) {
    final DateTime start = DateTime.parse(obj["startDate"] as String).toLocal();
    final DateTime end = DateTime.parse(obj["endDate"] as String).toLocal();

    // cast as num first so if price is int, app won't crash
    final double price = (obj["price"] as num).toDouble();

    return ElectricityPrice(
      startTime: start,
      endTime: end,
      price: price,
    );
  }
}

class ElectricityPricingState extends State<ElectricityPricing> {
  final Logger _logger = Logger("ElectricityPricing");

  List<ElectricityPrice> prices = List.empty(growable: true);

  /// Updates the prices if necessary
  /// Updated values will rebuild the inherited widget once they are loaded.
  void update({DateTime? now}) {
    now ??= DateTime.now();
    assert(DateTimeHelpers.isLocalDateTime(now));

    final DateTime nowDate = DateTimeHelpers.getDate(now);
    assert(DateTimeHelpers.isDateOnly(nowDate));

    // NOTE: Today updates don't necessarily mean that we have the first 24 hours of prices
    // 24 was just a good approximation on what the API gives me...
    final bool updatePrices;
    if (prices.isEmpty) {
      updatePrices = true;
    } else if (_nextDayPricesAvailable(now)) {
      final DateTime theDayAfterTomorrow = nowDate.add(const Duration(days: 2));
      assert(DateTimeHelpers.isDateOnly(theDayAfterTomorrow));

      // if the last price is before midnight of the day after tomorrow, update
      updatePrices = prices.last.endTime.isBefore(theDayAfterTomorrow);
    } else {
      updatePrices = false;
    }

    if (updatePrices) {
      _updateDayAhead().then((_) {
        _stripPreviousDay(nowDate);
        setState(() {});
      });
    } else {
      _stripPreviousDay(nowDate);
    }
  }

  void _stripPreviousDay(DateTime nowDate) {
    assert(DateTimeHelpers.isDateOnly(nowDate));

    while (prices.isNotEmpty && prices.first.startTime.isBefore(nowDate)) {
      prices.removeAt(0);
    }
  }

  /// returns true if successful, returns false if unsuccessful.
  Future<bool> _updateDayAhead() async {
    List<ElectricityPrice>? fetched = await _fetch();
    if (fetched == null) return false;
    if (fetched.isEmpty) return true;

    // new to old => old to new
    fetched = fetched.reversed.toList(growable: false);

    // verify API output when debugging, assume correctness when in release mode
    if (kDebugMode) {
      for (int i = 1; i < fetched.length; i++) {
        final ElectricityPrice a = fetched[i - 1];
        final ElectricityPrice b = fetched[i];
        assert(!a.endTime.isAfter(b.startTime));
      }
    }

    final ElectricityPrice first = fetched.first;

    // find index where price start time and fetched price start time meet
    // the found price either starts at or after this point
    // start overriding data at this index and forwards
    // if list is empty, start overriding from 0
    int i = 0;
    while (i < prices.length && prices[i].startTime.isBefore(first.startTime)) {
      i++;
    }

    prices.removeRange(i, prices.length);
    prices.addAll(fetched);
    return true;
  }

  Future<List<ElectricityPrice>?> _fetch() async {
    _logger.fine("Fetching day ahead prices...");

    final response = await http.get(
      _kDayAheadEndpoint,
      headers: {"User-Agent": RequestInfo.userAgent},
    );

    if (response.statusCode == 200) {
      List<dynamic> prices = json.decode(response.body)["prices"];
      return prices
          .map((e) => ElectricityPrice._parse(e))
          .toList(growable: false);
    } else {
      _logger.severe(
        "Received an error while fetching day-ahead prices: ${response.body}",
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ElectricityDataInherited(
      parent: this,
      child: widget.child,
    );
  }
}

class _ElectricityDataInherited extends InheritedWidget {
  final ElectricityPricingState parent;

  const _ElectricityDataInherited({required super.child, required this.parent});

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}
