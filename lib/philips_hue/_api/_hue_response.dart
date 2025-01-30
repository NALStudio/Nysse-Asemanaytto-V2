import 'dart:convert';

import 'package:http/http.dart' as http;

class HueResponse {
  final List<String> errors;
  final List? data;

  HueResponse.fromJson(Map json)
      : errors = (json["errors"] as List)
            .map((e) => e["description"] as String)
            .toList(growable: false),
        data = json["data"];

  static HueResponse? tryParse(http.Response response) {
    String? contentType = response.headers["content-type"];
    if (contentType != "application/json") {
      assert(response.statusCode != 200);
      return null;
    }

    // Why the fuck does Dart default to latin1 when decoding the response body ??????
    // Due to this complete fuckery, I'll decode it manually using utf8 instead.
    String bodyString = utf8.decode(response.bodyBytes);

    Map body = json.decode(bodyString);
    return HueResponse.fromJson(body);
  }
}
