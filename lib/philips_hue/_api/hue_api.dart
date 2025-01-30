import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:nysse_asemanaytto/philips_hue/_api/_hue_eventstream_event.dart';
import 'package:nysse_asemanaytto/philips_hue/_api/_hue_response.dart';
import 'package:nysse_asemanaytto/philips_hue/_bridge.dart';
import 'package:nysse_asemanaytto/philips_hue/_internal/_endpoints.dart';
import 'package:nysse_asemanaytto/philips_hue/_errors.dart';
import 'package:nysse_asemanaytto/philips_hue/_internal/_hue_http_client.dart';
import 'package:nysse_asemanaytto/philips_hue/_resources/_base.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

// Hue API that updates its state constantly from the events provided by the bridge.
class HueEventApi extends ChangeNotifier {
  final HueBridge bridge;
  final Set<HueResourceType> types;

  final HueHttpClient _client = HueHttpClient();
  late Map<String, HueResource> _state;

  List<HueResource> get resources => List.from(_state.values);

  http.StreamedResponse? eventStream;
  bool connected = false;

  HueEventApi._({
    required this.bridge,
    required Iterable<HueResourceType> types,
  }) : types = Set.unmodifiable(types);

  static Future<HueEventApi> listen({
    required HueBridge bridge,
    required List<HueResourceType> types,
  }) async {
    HueEventApi api = HueEventApi._(
      bridge: bridge,
      types: types,
    );

    try {
      await api._connectEventStream();
      await api._fetchInitialState();
      api._startListenEvents();
    } catch (_) {
      api.dispose();
      rethrow;
    }

    return api;
  }

  Future _connectEventStream() async {
    Uri endpoint = Uri.https(bridge.ipAddress, HueEndpointsV2.eventstream);

    http.Request request = http.Request("GET", endpoint);
    request.headers["hue-application-key"] = bridge.credentials.appKey;
    request.headers["Accept"] = "text/event-stream";

    eventStream = await _client.send(request);
    connected = true;
  }

  Future _fetchInitialState() async {
    HueApi api = HueApi._temporary(_client);

    try {
      List<HueResource> state = List.empty(growable: true);
      for (HueResourceType type in types) {
        state.addAll(await api._fetch(bridge, type));
      }
      _state = Map.fromEntries(state.map((r) => MapEntry(r.id, r)));
    } finally {
      api.dispose();
    }
  }

  void _startListenEvents() {
    eventStream!.stream
        .transform(Utf8Decoder())
        .transform(LineSplitter())
        .listen(_handleEvent, onDone: _handleDisconnect, onError: _handleError);
  }

  void _handleEvent(String line) {
    const dataHeader = "data:";
    if (!line.startsWith(dataHeader)) return;

    List body = json.decode(line.substring(dataHeader.length));

    for (HueEsEvent event in body.map((e) => HueEsEvent.fromJson(e))) {
      for (Map resourceJson in event.data) {
        // Construct temporary resource
        // since we need to access the resource id and type data
        HueResource resource = HueResource.fromJson(resourceJson);

        switch (event.type) {
          case HueEsType.add:
            if (types.contains(resource.type)) {
              _state[resource.id] = resource.type!.convertJson(resourceJson);
            }
            break;
          case HueEsType.update:
            _state[resource.id]?.update(resourceJson);
            break;
          case HueEsType.delete:
            _state.remove(resource.id);
            break;
          case HueEsType.error:
            developer.log("Hue event stream error.", name: "HueEventApi");
            break;
        }
      }
    }

    notifyListeners();
  }

  void _handleDisconnect() {
    connected = false;
    notifyListeners();
  }

  void _handleError(Object? error, StackTrace trace) {
    developer.log(
      "Hue event stream connection error.",
      name: "HueEventApi",
      error: error,
      stackTrace: trace,
    );
    _handleDisconnect();
  }

  @override
  void dispose() {
    _client.close();
    super.dispose();
  }
}

class HueApi {
  final bool _temporary;
  final HueHttpClient _client;

  HueApi()
      : _client = HueHttpClient(),
        _temporary = false;

  HueApi._temporary(HueHttpClient client)
      : _client = client,
        _temporary = true;

  Future<List<HueResource>> fetch({
    required List<HueBridge> bridges,
    required List<HueResourceType> types,
  }) async {
    List<HueResource> output = List.empty(growable: true);

    // Iterate types before bridges so if we have multiple bridges,
    // we give them time to rest in between
    // TODO: Request throttling
    for (HueResourceType t in types) {
      for (HueBridge b in bridges) {
        Iterable<HueResource> data = await _fetch(b, t);
        output.addAll(data);
      }
    }

    return output;
  }

  Future<Iterable<HueResource>> _fetch(
    HueBridge bridge,
    HueResourceType type,
  ) async {
    Uri endpoint =
        Uri.https(bridge.ipAddress, HueEndpointsV2.resourcesOfType(type));

    http.Response r = await _client.get(
      endpoint,
      headers: {"hue-application-key": bridge.credentials.appKey},
    );

    HueResponse? response = HueResponse.tryParse(r);
    if (r.statusCode != 200 || response == null || response.errors.isNotEmpty) {
      throw HueFetchError.withDetails(r.statusCode, response?.errors);
    }

    return response.data!.map((d) => _parse(d));
  }

  static HueResource _parse(Map json) {
    HueResourceType? type = HueResourceType.fromString(json["type"]);
    if (type == null) throw ArgumentError("Object type not supported.");
    return type.convertJson(json);
  }

  void dispose() {
    if (!_temporary) {
      _client.close();
    }
  }
}
