import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:nysse_asemanaytto/core/request_info.dart';

final Uri _kDayAheadEndpoint = Uri.https(
  "api.porssisahko.net",
  "/v1/latest-prices.json",
);

bool _isLocalDateTime(DateTime dt) {
  return dt.timeZoneName == dt.toLocal().timeZoneName;
}

bool _isDateOnly(DateTime dt) {
  return dt.hour == 0 &&
      dt.minute == 0 &&
      dt.second == 0 &&
      dt.millisecond == 0 &&
      dt.microsecond == 0;
}

bool _nextDayPricesAvailable(DateTime now) {
  assert(_isLocalDateTime(now));
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
    assert(_isLocalDateTime(now));

    final DateTime nowDate = DateTime(now.year, now.month, now.day);
    assert(_isDateOnly(nowDate));

    bool shouldRefreshDayAhead = false;
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
        if (_todayDate == null) rethrow;
        // Last date check will fail and the update is retried
        // But today prices will break if the fetch fails.
      }
    }
  }

  Future<void> _updateDayAhead(DateTime nowDate) async {
    assert(_isDateOnly(nowDate));
    final DateTime nextDayDate = nowDate.add(const Duration(days: 1));
    assert(_isDateOnly(nextDayDate));

    List<dynamic>? fetched = await _fetch();
    if (fetched == null) {
      throw _FetchError();
    }

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

      final double price = data["price"] as double;

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
      name: "electricity_data_widget.ElectricityDataState",
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
        name: "electricity_data_widget.ElectricityDataState",
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
