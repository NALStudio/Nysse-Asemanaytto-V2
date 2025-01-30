import 'package:nysse_asemanaytto/philips_hue/_authentication.dart';

class HueBridge {
  final String ipAddress;
  final HueBridgeCredentials credentials;

  const HueBridge({
    required this.ipAddress,
    required this.credentials,
  });

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
