import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nysse_asemanaytto/core/helpers/helpers.dart' as helpers;

class Dataset {
  final int id;
  final Duration updateRate;

  /// If the dataset is a total of some group.
  final bool isTotalValue;

  final String title;
  final String? subtitle;

  final String unit;
  final Color color;

  const Dataset({
    required this.id,
    required this.updateRate,
    this.isTotalValue = false,
    required this.title,
    this.subtitle,
    required this.unit,
    required this.color,
  });

  @override
  operator ==(Object other) {
    return other is Dataset && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => "Dataset(id: $id)";
}

class FingridData {
  final Map<Dataset, double>? data;
  final DateTime? recommendedRefreshTime;
  final Exception? error;

  const FingridData({
    required this.data,
    required this.error,
    required this.recommendedRefreshTime,
  });
}

class FingridFetchError implements Exception {
  final String? name;
  final String? message;
  final String? stack;
  final int? status;
  final Map<String, dynamic>? fields;

  FingridFetchError({
    required this.name,
    required this.message,
    required this.stack,
    required this.status,
    required this.fields,
  });
}

/// A recommended endTime is computed automatically.
/// A maximum of 20 000 results are returned.
Future<FingridData> getData({
  required String apiKey,
  required List<Dataset> datasets,
  required DateTime now,
}) async {
  if (datasets.isEmpty) {
    return const FingridData(
      data: {},
      error: null,
      recommendedRefreshTime: null,
    );
  }

  /// A constant used to adjust timestamps to take clock inaccuracies into consideration
  const Duration timePadding = Duration(minutes: 2);
  // ^^ 2 minutes because 1 minute wasn't sufficient
  // (indentical electricity data was fetched on multiple loads)

  Duration? maxUpdateRate;
  for (final ds in datasets) {
    if (maxUpdateRate == null || maxUpdateRate < ds.updateRate) {
      maxUpdateRate = ds.updateRate;
    }
  }
  assert(maxUpdateRate != null);

  final Duration timeOffset = maxUpdateRate! + timePadding;
  final DateTime startTime = now.add(-timeOffset);
  final DateTime endTime = now.add(timeOffset);

  Map<int, Dataset> datasetLookup = {for (final ds in datasets) ds.id: ds};

  final response = await http.get(
    Uri.https(
      "data.fingrid.fi",
      "/api/data",
      <String, String>{
        "datasets": datasets.map((e) => e.id).join(','),
        "startTime": startTime.toUtc().toIso8601String(),
        "endTime": endTime.toUtc().toIso8601String(),
        "pageSize": "20000",
        "locale": "fi",
        "sortBy": "startTime",
        "sortOrder": "desc",
      },
    ),
    headers: {"x-api-key": apiKey},
  );

  final String responseBody = response.body;
  final Map<String, dynamic>? body =
      responseBody.isNotEmpty ? json.decode(responseBody) : null;

  if (!helpers.isSuccessStatusCode(response.statusCode)) {
    throw FingridFetchError(
      name: body?["name"],
      message: body?["message"],
      stack: body?["stack"],
      status: body?["status"],
      fields: body?["fields"],
    );
  }

  assert(body!["pagination"]["prevPage"] == null);
  assert(body!["pagination"]["nextPage"] == null);

  final List data = body!["data"];

  final Map<Dataset, double> out = {};
  DateTime? minEndTime;
  for (Map d in data) {
    // skip all data that is in the future
    final String startTimeStr = d["startTime"];
    if (DateTime.parse(startTimeStr).isAfter(now)) {
      continue;
    }

    final Dataset dataset = datasetLookup[d["datasetId"] as int]!;
    // data is ordered in descending order by startTime
    // so if it exists already, this data is older => skip
    if (out.containsKey(dataset)) {
      continue;
    }

    out[dataset] = (d["value"] as num).toDouble();

    final String endTimeStr = d["endTime"];
    final DateTime endTime = DateTime.parse(endTimeStr);
    if (minEndTime == null || endTime.isBefore(minEndTime)) {
      minEndTime = endTime;
    }
  }

  return FingridData(
    data: out,
    error: null,
    recommendedRefreshTime: minEndTime?.add(timePadding),
  );
}
