import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';

class HueEntertainmentConfiguration extends HueResource {
  String status;

  bool get isActive => status == "active";

  HueEntertainmentConfiguration.fromJson(super.json)
      : status = json["status"],
        super.fromJson();

  @override
  void update(Map? json) {
    super.update(json);

    if (json == null) return;

    status = json.containsKey("status") ? json["status"] : status;
  }
}
