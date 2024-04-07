import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
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

class ElectricityPricingState extends State<ElectricityPricing> {
  /// TODO: Debug todayDate... This is checked on each update but never assigned...
  /// Date only
  DateTime? _todayDate;
  final List<double?> _todayPrices = List.generate(
    24,
    (index) => null,
    growable: false,
  );
  List<double?> get todayPrices => UnmodifiableListView(_todayPrices);

  final List<double?> _nextDayPrices = List.generate(
    24,
    (index) => null,
    growable: false,
  );
  List<double?> get nextDayPrices => _nextDayPrices;

  /// Updates the prices if necessary
  /// Updated values will rebuild the inherited widget once they are loaded.
  void update({DateTime? now}) {
    now ??= DateTime.now();
    assert(DateTimeHelpers.isLocalDateTime(now));

    final DateTime nowDate = DateTimeHelpers.getDate(now);
    assert(DateTimeHelpers.isDateOnly(nowDate));

    bool shouldRefreshDayAhead = false;
    // if fetch has errored, todayDate is its old value
    if (_todayDate == null || nowDate.isAfter(_todayDate!)) {
      shouldRefreshDayAhead = true;
    }
    if (_nextDayPrices.last == null && _nextDayPricesAvailable(now)) {
      shouldRefreshDayAhead = true;
    }

    if (shouldRefreshDayAhead) {
      try {
        _updateDayAhead(nowDate).then((value) => setState(() {}));
      } on _FetchError {
        // fall back on older prices on error and retry on next update
        // rethrow if no previous price data is available.
        if (_todayDate == null) rethrow;
      }
    }
  }

  Future<void> _updateDayAhead(DateTime nowDate) async {
    // TODO: Redo this entire function...
    // Currently it doesn't replace old data properly
    // we should probably just use a around 48 hour (depends on the data given by the provider)
    // list which pops the first element while it's yesterdays data
    // and we try to load new data when nextDayPrices are available
    throw UnimplementedError();

    assert(DateTimeHelpers.isDateOnly(nowDate));
    final DateTime nextDayDate = nowDate.add(const Duration(days: 1));
    assert(DateTimeHelpers.isDateOnly(nextDayDate));

    List<dynamic>? fetched = await _fetch();
    if (fetched == null) {
      throw _FetchError();
    }
    _todayDate = nowDate;

    // today prices are not cleared since we can't refill that data from the next fetch
    // (the first hour of the day isn't provided once new day ahead prices are available)
    _nextDayPrices.fillRange(0, _nextDayPrices.length, null);
    for (Map<String, dynamic> data in fetched) {
      final DateTime startDate =
          DateTime.parse(data["startDate"] as String).toLocal();
      if (startDate.isBefore(nowDate)) continue;

      final DateTime endDate =
          DateTime.parse(data["endDate"] as String).toLocal();

      final int startIndex = startDate.hour;
      final int endIndex;
      // next day hour 0 equals this day hour 24
      if (endDate.hour == 0) {
        endIndex = 24;
      } else {
        endIndex = endDate.hour;
      }

      final double price = (data["price"] as num).toDouble();

      if (startDate.isBefore(nextDayDate)) {
        _todayPrices.fillRange(startIndex, endIndex, price);
      } else {
        _nextDayPrices.fillRange(startIndex, endIndex, price);
      }
    }
  }

  Future<List<dynamic>?> _fetch() async {
    developer.log(
      "Fetching day ahead prices...",
      name: "_electricity_embed.ElectricityPricingEmbed",
    );

    final response = await http.get(
      _kDayAheadEndpoint,
      headers: {"User-Agent": RequestInfo.userAgent},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)["prices"];
    } else {
      developer.log(
        "Received an error while fetching day-ahead prices: ${response.body}",
        name: "_electricity_embed.ElectricityPricingEmbed",
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

class _FetchError implements Exception {}
