class DigitransitEnum {
  final String value;

  const DigitransitEnum(this.value);

  @override
  bool operator ==(Object other) {
    if (other is DigitransitEnum) {
      return runtimeType == other.runtimeType && value == other.value;
    } else if (other is String) {
      return value == other;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode;
}

class DigitransitMode extends DigitransitEnum {
  const DigitransitMode(super.value);

  static const DigitransitMode airplane = DigitransitMode("AIRPLANE");
  static const DigitransitMode bicycle = DigitransitMode("BICYCLE");
  static const DigitransitMode bus = DigitransitMode("BUS");
  static const DigitransitMode cableCar = DigitransitMode("CABLE_CAR");
  static const DigitransitMode car = DigitransitMode("CAR");
  static const DigitransitMode ferry = DigitransitMode("FERRY");
  static const DigitransitMode funicular = DigitransitMode("FUNICULAR");
  static const DigitransitMode gondola = DigitransitMode("GONDOLA");
  static const DigitransitMode legSwitch = DigitransitMode("LEG_SWITCH");
  static const DigitransitMode rail = DigitransitMode("RAIL");
  static const DigitransitMode subway = DigitransitMode("SUBWAY");
  static const DigitransitMode tram = DigitransitMode("TRAM");
  static const DigitransitMode transit = DigitransitMode("TRANSIT");
  static const DigitransitMode walk = DigitransitMode("WALK");
}

class DigitransitRealtimeState extends DigitransitEnum {
  const DigitransitRealtimeState(super.value);

  static const DigitransitRealtimeState scheduled =
      DigitransitRealtimeState("SCHEDULED");
  static const DigitransitRealtimeState updated =
      DigitransitRealtimeState("UPDATED");
  static const DigitransitRealtimeState canceled =
      DigitransitRealtimeState("CANCELED");
  static const DigitransitRealtimeState added =
      DigitransitRealtimeState("ADDED");
  static const DigitransitRealtimeState modified =
      DigitransitRealtimeState("MODIFIED");
}

class DigitransitRoutingEndpoint extends DigitransitEnum {
  const DigitransitRoutingEndpoint(super.value);

  static const DigitransitRoutingEndpoint hsl =
      DigitransitRoutingEndpoint("hsl");
  static const DigitransitRoutingEndpoint waltti =
      DigitransitRoutingEndpoint("waltti");
  static const DigitransitRoutingEndpoint finland =
      DigitransitRoutingEndpoint("finland");

  String getEndpoint() {
    return "https://api.digitransit.fi/routing/v1/routers/$value/index/graphql";
  }
}
