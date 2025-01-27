import 'package:nysse_asemanaytto/philips_hue/_authentication.dart';

import 'package:http/http.dart' as http;
import 'package:nysse_asemanaytto/philips_hue/_endpoints.dart';
import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';

class HueBridge {
  final String ipAddress;
  final HueBridgeCredentials credentials;

  final Map<String, String> defaultHeaders;

  HueBridge({required this.ipAddress, required this.credentials})
      : defaultHeaders = {"hue-application-key": credentials.appKey};

  Map<String, dynamic> toJson() {
    return {
      "ip": ipAddress,
      "credentials": credentials,
    };
  }

  HueBridge.fromJson(Map json)
      : this(
          ipAddress: json["ip"],
          credentials: HueBridgeCredentials.fromJson(json["credentials"]),
        );
}
