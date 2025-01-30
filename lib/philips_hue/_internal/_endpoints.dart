import 'package:nysse_asemanaytto/philips_hue/_resources/_base_resource_type.dart';

class HueEndpointsV1 {
  static const String authentication = "/api";
}

class HueEndpointsV2 {
  static const String _base = "/clip/v2";
  static const String eventstream = "/eventstream/clip/v2";

  static const String resources = "$_base/resource";

  static String resourcesOfType(HueResourceType type) =>
      "$_base/resource/${type.name}";
}
