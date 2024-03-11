import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:nysse_asemanaytto/core/config.dart';
import 'package:nysse_asemanaytto/core/widgets/error_widgets.dart';
import 'package:nysse_asemanaytto/digitransit/_queries/trip_route.dart';
import 'package:nysse_asemanaytto/digitransit/digitransit.dart';
import 'package:nysse_asemanaytto/digitransit/mqtt/mqtt.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/map_lines_embed/settings.dart';
import 'package:nysse_asemanaytto/embeds/embeds.dart';
import 'package:nysse_asemanaytto/embeds/_map_embeds/base.dart';
import 'package:nysse_asemanaytto/gtfs/realtime.dart';
import 'package:nysse_asemanaytto/main/stopinfo.dart';

import 'package:nysse_asemanaytto/main/stoptimes.dart';

final GlobalKey<_MapLinesEmbedWidgetState> _mapKey = GlobalKey();

class MapLinesEmbed extends Embed {
  const MapLinesEmbed({required super.name});

  @override
  EmbedWidgetMixin<MapLinesEmbed> createEmbed(
          covariant MapLinesEmbedSettings settings) =>
      MapLinesEmbedWidget(key: _mapKey, settings: settings);

  @override
  EmbedSettings<MapLinesEmbed> createDefaultSettings() => MapLinesEmbedSettings(
        tileProvider: MapEmbedTileProvider.digitransitRetina,
      );
}

class MapLinesEmbedWidget extends StatelessWidget
    implements EmbedWidgetMixin<MapLinesEmbed> {
  final MapLinesEmbedSettings settings;

  const MapLinesEmbedWidget({required this.settings, super.key});

  @override
  Duration? getDuration() {
    return const Duration(seconds: 10);
  }

  @override
  void onDisable() {
    _mapKey.currentState?.unsubscribeMqtt();
  }

  @override
  void onEnable() {
    _mapKey.currentState?.subscribeMqtt();
  }

  @override
  Widget build(BuildContext context) {
    final DigitransitStoptime? stoptime =
        Stoptimes.of(context)?.stoptimesWithoutPatterns?.firstOrNull;
    if (stoptime == null) {
      return ErrorWidget.withDetails(message: "No stoptimes");
    }

    return Query(
      options: QueryOptions(
        document: gql(DigitransitTripRouteQuery.query),
        variables: {
          "tripId": stoptime!.tripGtfsId!.id,
        },
        pollInterval: RequestInfo.ratelimits.stoptimesRequest,
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return ErrorWidget(result.exception!);
        }

        final Map<String, dynamic>? data = result.data;
        final DigitransitStoptimeQuery? parsed =
            data != null ? DigitransitStoptimeQuery.parse(data) : null;

        return _StoptimesInherited(
          stoptimes: parsed,
          child: widget.child,
        );
      },
    );
  }
}

class _MapLinesEmbedWidget extends StatefulWidget {
  final DigitransitStoptime stoptime;

  const _MapLinesEmbedWidget({required this.stoptime});

  @override
  State<StatefulWidget> createState() => _MapLinesEmbedWidgetState();
}

class _MapLinesEmbedWidgetState extends State<_MapLinesEmbedWidget> {
  late final MapController _mapController;

  DigitransitMqttSubscription? _positioningSub;
  Widget? _positioningSubError;
  final Map<String, VehiclePosition> _vehiclePositions = {};

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    unsubscribeMqtt();

    super.dispose();
  }

  void subscribeMqtt() {
    final DigitransitMqttState? mqtt = DigitransitMqtt.maybeOf(context);
    if (mqtt?.isConnected != true) {
      _positioningSubError = MqttOfflineErrorWidget();
      return;
    }

    final GtfsId stopId = Config.of(context).stopId;

    _positioningSubError = null;
    _positioningSub = mqtt!.subscribe(
      DigitransitPositioningTopic(
              feedId: stopId.feedId,
              routeId: _subscribedStoptime!.routeGtfsId!.rawId)
          .buildTopicString(),
      MqttQos.atMostOnce,
    );

    _positioningSub!.onMessageReceived = _onVehiclePositionUpdate;
  }

  void _onVehiclePositionUpdate(DigitransitMqttMessage msg) {
    final FeedEntity ent = FeedEntity.fromBuffer(msg.bytes);
    setState(() {
      // BUG: After vehicle stops being updated
      // (doesn't fit to our topic <= too far for example)
      // The vehicle isn't removed from the map before the next disconnect.
      // This is fine for now, but I would like to make a timeout system in the future.
      _vehiclePositions[ent.id] = ent.vehicle;
    });
  }

  /// Safe to call multiple times.
  void unsubscribeMqtt() {
    if (_positioningSub == null) {
      return;
    }

    DigitransitMqtt.of(context).unsubscribe(_positioningSub!);
    _vehiclePositions.clear();
  }

  @override
  Widget build(BuildContext context) {
    final stopinfo = StopInfo.of(context);

    List<Marker> stopMarkers = List.empty(growable: true);
    if (stopinfo != null) {
      stopMarkers.add(_buildStopMarker(LatLng(stopinfo.lat, stopinfo.lon)));
    }

    final List<Widget> mapChildren = [
      buildMapEmbedTileProvider(context, widget.settings.tileProvider),
      MarkerLayer(
        markers: _vehiclePositions.values
            .map(
              (e) => buildVehicleMarker(
                context,
                mapController: _mapController,
                pos: e,
              ),
            )
            .toList(growable: false),
      ),
    ];

    if (_positioningSubError != null) {
      mapChildren.add(
        Positioned(
          left: _mapController.camera.nonRotatedSize.x / 1.5,
          bottom: _mapController.camera.nonRotatedSize.y / 1.5,
          right: 0,
          top: 0,
          child: _positioningSubError!,
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.none,
        ),
        initialCenter: LatLng(61.497742570, 23.761290078),
      ),
      children: mapChildren,
    );
  }

  Marker _buildStopMarker(LatLng point) {
    double size = calculateMarkerSize(10, 30, mapController: _mapController);
    return Marker(
      point: point,
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }
}
