import 'package:meta/meta.dart' as meta;
import 'package:nysse_asemanaytto/philips_hue/_resources/_base_resource_type.dart';

export '_base_resource_type.dart';
export '_light.dart';
export '_entertainment_configuration.dart';

abstract interface class HueBase {
  void update(Map? json);

  static T? fromJsonNullable<T>(T Function(Map) fromJson, Map? json) {
    if (json == null) return null;
    return fromJson(json);
  }

  /// Returns the updated value.
  /// This value must be assigned to back to the updated property.
  static T? updateNullable<T extends HueBase>(
      T? originalValue, T Function(Map) fromJson, Map? json) {
    if (originalValue == null && json != null) {
      return fromJson(json);
    }

    originalValue?.update(json);
    return originalValue;
  }
}

class HueResource implements HueBase {
  /// Unique identifier representing a specific resource instance
  String id;

  // Type of the supported resources
  HueResourceType? type;

  HueResource.fromJson(Map json)
      : id = json["id"],
        type = HueResourceType.fromString(json["type"]);

  @override
  @meta.mustBeOverridden
  @meta.mustCallSuper
  void update(Map? json) {
    if (json == null) return;

    id = json.containsKey("id") ? json["id"] : id;

    if (json.containsKey("type")) {
      type = HueResourceType.fromString(json["type"]);
    }
  }
}

class HueOwner implements HueBase {
  /// The unique id of the referenced resource
  String rid;

  /// The type of the referenced resource
  String rtype;

  HueOwner.fromJson(Map json)
      : rid = json["rid"],
        rtype = json["rtype"];

  @override
  void update(Map? json) {
    if (json == null) return;

    rid = json.containsKey("rid") ? json["rid"] : rid;
    rtype = json.containsKey("rtype") ? json["rtype"] : rtype;
  }
}

class HueXY implements HueBase {
  double x;
  double y;

  HueXY.fromJson(Map json)
      : x = json["x"],
        y = json["y"];

  @override
  void update(Map? json) {
    if (json == null) return;

    x = json.containsKey("x") ? json["x"] : x;
    y = json.containsKey("y") ? json["y"] : y;
  }
}
