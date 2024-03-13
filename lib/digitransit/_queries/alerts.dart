import 'dart:collection';

class DigitransitAlertsQuery {
  static const String query = """
query getAlerts(\$feeds: [String!], \$stopId: String!)
{
  globalSevere: alerts(feeds: \$feeds, severityLevel: [SEVERE]) {
    alertDescriptionText
  }
  localAll: alerts(feeds: \$feeds, stop: [\$stopId]) {
    alertDescriptionText
  }
}
""";
  final List<DigitransitAlert> globalSevere;
  final List<DigitransitAlert> localAll;

  const DigitransitAlertsQuery({
    required this.globalSevere,
    required this.localAll,
  });

  static DigitransitAlertsQuery parse(Map<String, dynamic> data) {
    List<dynamic> global = data["globalSevere"];
    List<dynamic> local = data["localAll"];

    return DigitransitAlertsQuery(
      globalSevere: UnmodifiableListView(
        global.map((e) => DigitransitAlert._parse(e)).toList(growable: false),
      ),
      localAll: UnmodifiableListView(
        local.map((e) => DigitransitAlert._parse(e)).toList(growable: false),
      ),
    );
  }
}

class DigitransitAlert {
  final String description;

  DigitransitAlert({required this.description});

  static DigitransitAlert _parse(Map<String, dynamic> map) {
    return DigitransitAlert(
      description: map["alertDescriptionText"] as String,
    );
  }
}
