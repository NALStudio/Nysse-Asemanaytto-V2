import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nysse_asemanaytto/philips_hue/_endpoints.dart';
import 'package:nysse_asemanaytto/philips_hue/_errors.dart';

class HueBridgeCredentials {
  final String appKey;
  final String clientKey;

  HueBridgeCredentials({required this.appKey, required this.clientKey});

  factory HueBridgeCredentials.fromJson(Map<String, dynamic> json) {
    final String? appKey = json["username"];
    final String? clientKey = json["clientkey"];

    if (appKey == null || clientKey == null) {
      throw ArgumentError("Invalid JSON payload.");
    }

    return HueBridgeCredentials(appKey: appKey, clientKey: clientKey);
  }

  Map<String, String> toJson() {
    return {
      "username": appKey,
      "clientkey": clientKey,
    };
  }
}

// Reference: https://github.com/NALStudio/NDiscoPlus/blob/353869cbf252f1ea3bbc462a078c95ab941dde44/NDiscoPlus.PhilipsHue/Authentication/HueAuthentication.cs
class HueAuthentication {
  final String _bridgeIp;

  HueAuthentication({required String bridgeIp}) : _bridgeIp = bridgeIp;

  /// Returns [HueBridgeCredentials] if authentication was successful.
  /// Returns [null] if the link button was not pressed.
  /// Throws an error otherwise.
  Future<HueBridgeCredentials?> tryAuthenticate({
    required String appName,
    required String instanceName,
  }) async {
    throwIfNameInvalid(appName, "appName");
    throwIfNameInvalid(instanceName, "instanceName");

    Uri endpoint = Uri.https(_bridgeIp, HueEndpointsV1.authentication);
    String body = json.encode(
        {"devicetype": "$appName#$instanceName", "generateclientkey": true});

    http.Response response = await http.post(endpoint, body: body);
    if (response.statusCode != 200) {
      throw HueAuthenticationError.statusCode(response.statusCode);
    }

    // response
    Map<String, dynamic> resp = json.decode(response.body);
    Map<String, dynamic>? success = resp["success"];
    if (success == null) {
      Map? error = resp["error"];
      if (error != null && error["type"] == 101) {
        return null;
      }

      String? errorDesc = error?["description"];
      throw HueAuthenticationError.withDescription(errorDesc);
    }

    return HueBridgeCredentials.fromJson(success);
  }

  void throwIfNameInvalid(String name, String paramName) {
    if (name.contains('#')) {
      throw ArgumentError("Invalid character in name: '#'", paramName);
    }

    const int maxLen = 19;
    if (name.length > maxLen) {
      throw ArgumentError("Name too long", paramName);
    }
  }
}
