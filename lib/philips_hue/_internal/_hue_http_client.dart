import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

class HueHttpClient extends BaseClient {
  final Client _client;

  HueHttpClient() : _client = _constructClient();

  static IOClient _constructClient() {
    return IOClient(HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              cert.issuer.contains("Philips Hue") ||
              cert.issuer.contains("root-bridge"));
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return _client.send(request);
  }

  @override
  void close() {
    _client.close();
  }
}
