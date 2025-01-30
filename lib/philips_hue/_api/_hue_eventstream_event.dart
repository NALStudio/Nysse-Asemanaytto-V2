enum HueEsType {
  update,
  add,
  delete,
  error;

  factory HueEsType.fromJson(String jsonString) {
    return switch (jsonString) {
      "update" => HueEsType.update,
      "add" => HueEsType.add,
      "delete" => HueEsType.delete,
      "error" => HueEsType.error,
      _ => throw ArgumentError.value(jsonString)
    };
  }
}

class HueEsEvent {
  final DateTime time;
  final String id;
  final HueEsType type;
  final List data;

  HueEsEvent.fromJson(Map json)
      : time = DateTime.parse(json["creationtime"]),
        id = json["id"],
        type = HueEsType.fromJson(json["type"]),
        data = json["data"];
}
