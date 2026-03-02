// This is a generated file - do not edit.
//
// Generated from gtfs-realtime.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'gtfs-realtime.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'gtfs-realtime.pbenum.dart';

/// The contents of a feed message.
/// A feed is a continuous stream of feed messages. Each message in the stream is
/// obtained as a response to an appropriate HTTP GET request.
/// A realtime feed is always defined with relation to an existing GTFS feed.
/// All the entity ids are resolved with respect to the GTFS feed.
/// Note that "required" and "optional" as stated in this file refer to Protocol
/// Buffer cardinality, not semantic cardinality.  See reference.md at
/// https://github.com/google/transit/tree/master/gtfs-realtime for field
/// semantic cardinality.
class FeedMessage extends $pb.GeneratedMessage {
  factory FeedMessage({
    FeedHeader? header,
    $core.Iterable<FeedEntity>? entity,
  }) {
    final result = create();
    if (header != null) result.header = header;
    if (entity != null) result.entity.addAll(entity);
    return result;
  }

  FeedMessage._();

  factory FeedMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeedMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeedMessage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQM<FeedHeader>(1, _omitFieldNames ? '' : 'header',
        subBuilder: FeedHeader.create)
    ..pPM<FeedEntity>(2, _omitFieldNames ? '' : 'entity',
        subBuilder: FeedEntity.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedMessage copyWith(void Function(FeedMessage) updates) =>
      super.copyWith((message) => updates(message as FeedMessage))
          as FeedMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedMessage create() => FeedMessage._();
  @$core.override
  FeedMessage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FeedMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeedMessage>(create);
  static FeedMessage? _defaultInstance;

  /// Metadata about this feed and feed message.
  @$pb.TagNumber(1)
  FeedHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(FeedHeader value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => $_clearField(1);
  @$pb.TagNumber(1)
  FeedHeader ensureHeader() => $_ensure(0);

  /// Contents of the feed.
  @$pb.TagNumber(2)
  $pb.PbList<FeedEntity> get entity => $_getList(1);
}

/// Metadata about a feed, included in feed messages.
class FeedHeader extends $pb.GeneratedMessage {
  factory FeedHeader({
    $core.String? gtfsRealtimeVersion,
    FeedHeader_Incrementality? incrementality,
    $fixnum.Int64? timestamp,
    $core.String? feedVersion,
  }) {
    final result = create();
    if (gtfsRealtimeVersion != null)
      result.gtfsRealtimeVersion = gtfsRealtimeVersion;
    if (incrementality != null) result.incrementality = incrementality;
    if (timestamp != null) result.timestamp = timestamp;
    if (feedVersion != null) result.feedVersion = feedVersion;
    return result;
  }

  FeedHeader._();

  factory FeedHeader.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeedHeader.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeedHeader',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'gtfsRealtimeVersion')
    ..aE<FeedHeader_Incrementality>(2, _omitFieldNames ? '' : 'incrementality',
        defaultOrMaker: FeedHeader_Incrementality.FULL_DATASET,
        enumValues: FeedHeader_Incrementality.values)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(4, _omitFieldNames ? '' : 'feedVersion')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedHeader clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedHeader copyWith(void Function(FeedHeader) updates) =>
      super.copyWith((message) => updates(message as FeedHeader)) as FeedHeader;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedHeader create() => FeedHeader._();
  @$core.override
  FeedHeader createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FeedHeader getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeedHeader>(create);
  static FeedHeader? _defaultInstance;

  /// Version of the feed specification.
  /// The current version is 2.0.  Valid versions are "2.0", "1.0".
  @$pb.TagNumber(1)
  $core.String get gtfsRealtimeVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set gtfsRealtimeVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGtfsRealtimeVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearGtfsRealtimeVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  FeedHeader_Incrementality get incrementality => $_getN(1);
  @$pb.TagNumber(2)
  set incrementality(FeedHeader_Incrementality value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasIncrementality() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncrementality() => $_clearField(2);

  /// This timestamp identifies the moment when the content of this feed has been
  /// created (in server time). In POSIX time (i.e., number of seconds since
  /// January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => $_clearField(3);

  /// String that matches the feed_info.feed_version from the GTFS feed that the real
  /// time data is based on. Consumers can use this to identify which GTFS feed is
  /// currently active or when a new one is available to download.
  @$pb.TagNumber(4)
  $core.String get feedVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set feedVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFeedVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearFeedVersion() => $_clearField(4);
}

/// A definition (or update) of an entity in the transit feed.
class FeedEntity extends $pb.GeneratedMessage {
  factory FeedEntity({
    $core.String? id,
    $core.bool? isDeleted,
    TripUpdate? tripUpdate,
    VehiclePosition? vehicle,
    Alert? alert,
    Shape? shape,
    Stop? stop,
    TripModifications? tripModifications,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (isDeleted != null) result.isDeleted = isDeleted;
    if (tripUpdate != null) result.tripUpdate = tripUpdate;
    if (vehicle != null) result.vehicle = vehicle;
    if (alert != null) result.alert = alert;
    if (shape != null) result.shape = shape;
    if (stop != null) result.stop = stop;
    if (tripModifications != null) result.tripModifications = tripModifications;
    return result;
  }

  FeedEntity._();

  factory FeedEntity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory FeedEntity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FeedEntity',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'isDeleted')
    ..aOM<TripUpdate>(3, _omitFieldNames ? '' : 'tripUpdate',
        subBuilder: TripUpdate.create)
    ..aOM<VehiclePosition>(4, _omitFieldNames ? '' : 'vehicle',
        subBuilder: VehiclePosition.create)
    ..aOM<Alert>(5, _omitFieldNames ? '' : 'alert', subBuilder: Alert.create)
    ..aOM<Shape>(6, _omitFieldNames ? '' : 'shape', subBuilder: Shape.create)
    ..aOM<Stop>(7, _omitFieldNames ? '' : 'stop', subBuilder: Stop.create)
    ..aOM<TripModifications>(8, _omitFieldNames ? '' : 'tripModifications',
        subBuilder: TripModifications.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedEntity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FeedEntity copyWith(void Function(FeedEntity) updates) =>
      super.copyWith((message) => updates(message as FeedEntity)) as FeedEntity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedEntity create() => FeedEntity._();
  @$core.override
  FeedEntity createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static FeedEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<FeedEntity>(create);
  static FeedEntity? _defaultInstance;

  /// The ids are used only to provide incrementality support. The id should be
  /// unique within a FeedMessage. Consequent FeedMessages may contain
  /// FeedEntities with the same id. In case of a DIFFERENTIAL update the new
  /// FeedEntity with some id will replace the old FeedEntity with the same id
  /// (or delete it - see is_deleted below).
  /// The actual GTFS entities (e.g. stations, routes, trips) referenced by the
  /// feed must be specified by explicit selectors (see EntitySelector below for
  /// more info).
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// Whether this entity is to be deleted. Relevant only for incremental
  /// fetches.
  @$pb.TagNumber(2)
  $core.bool get isDeleted => $_getBF(1);
  @$pb.TagNumber(2)
  set isDeleted($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsDeleted() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDeleted() => $_clearField(2);

  /// Data about the entity itself. Exactly one of the following fields must be
  /// present (unless the entity is being deleted).
  @$pb.TagNumber(3)
  TripUpdate get tripUpdate => $_getN(2);
  @$pb.TagNumber(3)
  set tripUpdate(TripUpdate value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasTripUpdate() => $_has(2);
  @$pb.TagNumber(3)
  void clearTripUpdate() => $_clearField(3);
  @$pb.TagNumber(3)
  TripUpdate ensureTripUpdate() => $_ensure(2);

  @$pb.TagNumber(4)
  VehiclePosition get vehicle => $_getN(3);
  @$pb.TagNumber(4)
  set vehicle(VehiclePosition value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVehicle() => $_has(3);
  @$pb.TagNumber(4)
  void clearVehicle() => $_clearField(4);
  @$pb.TagNumber(4)
  VehiclePosition ensureVehicle() => $_ensure(3);

  @$pb.TagNumber(5)
  Alert get alert => $_getN(4);
  @$pb.TagNumber(5)
  set alert(Alert value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasAlert() => $_has(4);
  @$pb.TagNumber(5)
  void clearAlert() => $_clearField(5);
  @$pb.TagNumber(5)
  Alert ensureAlert() => $_ensure(4);

  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(6)
  Shape get shape => $_getN(5);
  @$pb.TagNumber(6)
  set shape(Shape value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasShape() => $_has(5);
  @$pb.TagNumber(6)
  void clearShape() => $_clearField(6);
  @$pb.TagNumber(6)
  Shape ensureShape() => $_ensure(5);

  @$pb.TagNumber(7)
  Stop get stop => $_getN(6);
  @$pb.TagNumber(7)
  set stop(Stop value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasStop() => $_has(6);
  @$pb.TagNumber(7)
  void clearStop() => $_clearField(7);
  @$pb.TagNumber(7)
  Stop ensureStop() => $_ensure(6);

  @$pb.TagNumber(8)
  TripModifications get tripModifications => $_getN(7);
  @$pb.TagNumber(8)
  set tripModifications(TripModifications value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasTripModifications() => $_has(7);
  @$pb.TagNumber(8)
  void clearTripModifications() => $_clearField(8);
  @$pb.TagNumber(8)
  TripModifications ensureTripModifications() => $_ensure(7);
}

/// Timing information for a single predicted event (either arrival or
/// departure).
/// Timing consists of delay and/or estimated time, and uncertainty.
/// - delay should be used when the prediction is given relative to some
///   existing schedule in GTFS.
/// - time should be given whether there is a predicted schedule or not. If
///   both time and delay are specified, time will take precedence
///   (although normally, time, if given for a scheduled trip, should be
///   equal to scheduled time in GTFS + delay).
///
/// Uncertainty applies equally to both time and delay.
/// The uncertainty roughly specifies the expected error in true delay (but
/// note, we don't yet define its precise statistical meaning). It's possible
/// for the uncertainty to be 0, for example for trains that are driven under
/// computer timing control.
class TripUpdate_StopTimeEvent extends $pb.GeneratedMessage {
  factory TripUpdate_StopTimeEvent({
    $core.int? delay,
    $fixnum.Int64? time,
    $core.int? uncertainty,
    $fixnum.Int64? scheduledTime,
  }) {
    final result = create();
    if (delay != null) result.delay = delay;
    if (time != null) result.time = time;
    if (uncertainty != null) result.uncertainty = uncertainty;
    if (scheduledTime != null) result.scheduledTime = scheduledTime;
    return result;
  }

  TripUpdate_StopTimeEvent._();

  factory TripUpdate_StopTimeEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripUpdate_StopTimeEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripUpdate.StopTimeEvent',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'delay')
    ..aInt64(2, _omitFieldNames ? '' : 'time')
    ..aI(3, _omitFieldNames ? '' : 'uncertainty')
    ..aInt64(4, _omitFieldNames ? '' : 'scheduledTime')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeEvent copyWith(
          void Function(TripUpdate_StopTimeEvent) updates) =>
      super.copyWith((message) => updates(message as TripUpdate_StopTimeEvent))
          as TripUpdate_StopTimeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeEvent create() => TripUpdate_StopTimeEvent._();
  @$core.override
  TripUpdate_StopTimeEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripUpdate_StopTimeEvent>(create);
  static TripUpdate_StopTimeEvent? _defaultInstance;

  /// Delay (in seconds) can be positive (meaning that the vehicle is late) or
  /// negative (meaning that the vehicle is ahead of schedule). Delay of 0
  /// means that the vehicle is exactly on time.
  @$pb.TagNumber(1)
  $core.int get delay => $_getIZ(0);
  @$pb.TagNumber(1)
  set delay($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDelay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDelay() => $_clearField(1);

  /// Event as absolute time.
  /// In Unix time (i.e., number of seconds since January 1st 1970 00:00:00
  /// UTC).
  @$pb.TagNumber(2)
  $fixnum.Int64 get time => $_getI64(1);
  @$pb.TagNumber(2)
  set time($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => $_clearField(2);

  /// If uncertainty is omitted, it is interpreted as unknown.
  /// If the prediction is unknown or too uncertain, the delay (or time) field
  /// should be empty. In such case, the uncertainty field is ignored.
  /// To specify a completely certain prediction, set its uncertainty to 0.
  @$pb.TagNumber(3)
  $core.int get uncertainty => $_getIZ(2);
  @$pb.TagNumber(3)
  set uncertainty($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUncertainty() => $_has(2);
  @$pb.TagNumber(3)
  void clearUncertainty() => $_clearField(3);

  /// Scheduled time for a NEW, REPLACEMENT, or DUPLICATED trip.
  /// In Unix time (i.e., number of seconds since January 1st 1970 00:00:00
  /// UTC).
  /// Optional if TripUpdate.schedule_relationship is NEW, REPLACEMENT or DUPLICATED, forbidden otherwise.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  $fixnum.Int64 get scheduledTime => $_getI64(3);
  @$pb.TagNumber(4)
  set scheduledTime($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasScheduledTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduledTime() => $_clearField(4);
}

/// Provides the updated values for the stop time.
/// NOTE: This message is still experimental, and subject to change. It may be formally adopted in the future.
class TripUpdate_StopTimeUpdate_StopTimeProperties
    extends $pb.GeneratedMessage {
  factory TripUpdate_StopTimeUpdate_StopTimeProperties({
    $core.String? assignedStopId,
    $core.String? stopHeadsign,
    TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType? pickupType,
    TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType? dropOffType,
  }) {
    final result = create();
    if (assignedStopId != null) result.assignedStopId = assignedStopId;
    if (stopHeadsign != null) result.stopHeadsign = stopHeadsign;
    if (pickupType != null) result.pickupType = pickupType;
    if (dropOffType != null) result.dropOffType = dropOffType;
    return result;
  }

  TripUpdate_StopTimeUpdate_StopTimeProperties._();

  factory TripUpdate_StopTimeUpdate_StopTimeProperties.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripUpdate_StopTimeUpdate_StopTimeProperties.fromJson(
          $core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripUpdate.StopTimeUpdate.StopTimeProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assignedStopId')
    ..aOS(2, _omitFieldNames ? '' : 'stopHeadsign')
    ..aE<TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType>(
        3, _omitFieldNames ? '' : 'pickupType',
        enumValues:
            TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
                .values)
    ..aE<TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType>(
        4, _omitFieldNames ? '' : 'dropOffType',
        enumValues:
            TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
                .values)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeUpdate_StopTimeProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeUpdate_StopTimeProperties copyWith(
          void Function(TripUpdate_StopTimeUpdate_StopTimeProperties)
              updates) =>
      super.copyWith((message) =>
              updates(message as TripUpdate_StopTimeUpdate_StopTimeProperties))
          as TripUpdate_StopTimeUpdate_StopTimeProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate_StopTimeProperties create() =>
      TripUpdate_StopTimeUpdate_StopTimeProperties._();
  @$core.override
  TripUpdate_StopTimeUpdate_StopTimeProperties createEmptyInstance() =>
      create();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate_StopTimeProperties getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TripUpdate_StopTimeUpdate_StopTimeProperties>(create);
  static TripUpdate_StopTimeUpdate_StopTimeProperties? _defaultInstance;

  /// Supports real-time stop assignments. Refers to a stop_id defined in the GTFS stops.txt.
  /// The new assigned_stop_id should not result in a significantly different trip experience for the end user than
  /// the stop_id defined in GTFS stop_times.txt. In other words, the end user should not view this new stop_id as an
  /// "unusual change" if the new stop was presented within an app without any additional context.
  /// For example, this field is intended to be used for platform assignments by using a stop_id that belongs to the
  /// same station as the stop originally defined in GTFS stop_times.txt.
  /// To assign a stop without providing any real-time arrival or departure predictions, populate this field and set
  /// StopTimeUpdate.schedule_relationship = NO_DATA.
  /// If this field is populated, it is preferred to omit `StopTimeUpdate.stop_id` and use only `StopTimeUpdate.stop_sequence`. If
  /// `StopTimeProperties.assigned_stop_id` and `StopTimeUpdate.stop_id` are populated, `StopTimeUpdate.stop_id` must match `assigned_stop_id`.
  /// Platform assignments should be reflected in other GTFS-realtime fields as well
  /// (e.g., `VehiclePosition.stop_id`).
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(1)
  $core.String get assignedStopId => $_getSZ(0);
  @$pb.TagNumber(1)
  set assignedStopId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAssignedStopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssignedStopId() => $_clearField(1);

  /// The updated headsign of the vehicle at the stop.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get stopHeadsign => $_getSZ(1);
  @$pb.TagNumber(2)
  set stopHeadsign($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStopHeadsign() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopHeadsign() => $_clearField(2);

  /// The updated pickup of the vehicle at the stop.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(3)
  TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      get pickupType => $_getN(2);
  @$pb.TagNumber(3)
  set pickupType(
          TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
              value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPickupType() => $_has(2);
  @$pb.TagNumber(3)
  void clearPickupType() => $_clearField(3);

  /// The updated drop off of the vehicle at the stop.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      get dropOffType => $_getN(3);
  @$pb.TagNumber(4)
  set dropOffType(
          TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
              value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDropOffType() => $_has(3);
  @$pb.TagNumber(4)
  void clearDropOffType() => $_clearField(4);
}

/// Realtime update for arrival and/or departure events for a given stop on a
/// trip. Updates can be supplied for both past and future events.
/// The producer is allowed, although not required, to drop past events.
class TripUpdate_StopTimeUpdate extends $pb.GeneratedMessage {
  factory TripUpdate_StopTimeUpdate({
    $core.int? stopSequence,
    TripUpdate_StopTimeEvent? arrival,
    TripUpdate_StopTimeEvent? departure,
    $core.String? stopId,
    TripUpdate_StopTimeUpdate_ScheduleRelationship? scheduleRelationship,
    TripUpdate_StopTimeUpdate_StopTimeProperties? stopTimeProperties,
    VehiclePosition_OccupancyStatus? departureOccupancyStatus,
  }) {
    final result = create();
    if (stopSequence != null) result.stopSequence = stopSequence;
    if (arrival != null) result.arrival = arrival;
    if (departure != null) result.departure = departure;
    if (stopId != null) result.stopId = stopId;
    if (scheduleRelationship != null)
      result.scheduleRelationship = scheduleRelationship;
    if (stopTimeProperties != null)
      result.stopTimeProperties = stopTimeProperties;
    if (departureOccupancyStatus != null)
      result.departureOccupancyStatus = departureOccupancyStatus;
    return result;
  }

  TripUpdate_StopTimeUpdate._();

  factory TripUpdate_StopTimeUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripUpdate_StopTimeUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripUpdate.StopTimeUpdate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'stopSequence',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<TripUpdate_StopTimeEvent>(2, _omitFieldNames ? '' : 'arrival',
        subBuilder: TripUpdate_StopTimeEvent.create)
    ..aOM<TripUpdate_StopTimeEvent>(3, _omitFieldNames ? '' : 'departure',
        subBuilder: TripUpdate_StopTimeEvent.create)
    ..aOS(4, _omitFieldNames ? '' : 'stopId')
    ..aE<TripUpdate_StopTimeUpdate_ScheduleRelationship>(
        5, _omitFieldNames ? '' : 'scheduleRelationship',
        defaultOrMaker:
            TripUpdate_StopTimeUpdate_ScheduleRelationship.SCHEDULED,
        enumValues: TripUpdate_StopTimeUpdate_ScheduleRelationship.values)
    ..aOM<TripUpdate_StopTimeUpdate_StopTimeProperties>(
        6, _omitFieldNames ? '' : 'stopTimeProperties',
        subBuilder: TripUpdate_StopTimeUpdate_StopTimeProperties.create)
    ..aE<VehiclePosition_OccupancyStatus>(
        7, _omitFieldNames ? '' : 'departureOccupancyStatus',
        enumValues: VehiclePosition_OccupancyStatus.values)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_StopTimeUpdate copyWith(
          void Function(TripUpdate_StopTimeUpdate) updates) =>
      super.copyWith((message) => updates(message as TripUpdate_StopTimeUpdate))
          as TripUpdate_StopTimeUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate create() => TripUpdate_StopTimeUpdate._();
  @$core.override
  TripUpdate_StopTimeUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripUpdate_StopTimeUpdate>(create);
  static TripUpdate_StopTimeUpdate? _defaultInstance;

  /// Must be the same as in stop_times.txt in the corresponding GTFS feed.
  @$pb.TagNumber(1)
  $core.int get stopSequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set stopSequence($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStopSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearStopSequence() => $_clearField(1);

  @$pb.TagNumber(2)
  TripUpdate_StopTimeEvent get arrival => $_getN(1);
  @$pb.TagNumber(2)
  set arrival(TripUpdate_StopTimeEvent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasArrival() => $_has(1);
  @$pb.TagNumber(2)
  void clearArrival() => $_clearField(2);
  @$pb.TagNumber(2)
  TripUpdate_StopTimeEvent ensureArrival() => $_ensure(1);

  @$pb.TagNumber(3)
  TripUpdate_StopTimeEvent get departure => $_getN(2);
  @$pb.TagNumber(3)
  set departure(TripUpdate_StopTimeEvent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDeparture() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeparture() => $_clearField(3);
  @$pb.TagNumber(3)
  TripUpdate_StopTimeEvent ensureDeparture() => $_ensure(2);

  /// Must be the same as in stops.txt in the corresponding GTFS feed.
  @$pb.TagNumber(4)
  $core.String get stopId => $_getSZ(3);
  @$pb.TagNumber(4)
  set stopId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStopId() => $_has(3);
  @$pb.TagNumber(4)
  void clearStopId() => $_clearField(4);

  @$pb.TagNumber(5)
  TripUpdate_StopTimeUpdate_ScheduleRelationship get scheduleRelationship =>
      $_getN(4);
  @$pb.TagNumber(5)
  set scheduleRelationship(
          TripUpdate_StopTimeUpdate_ScheduleRelationship value) =>
      $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasScheduleRelationship() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduleRelationship() => $_clearField(5);

  /// Realtime updates for certain properties defined within GTFS stop_times.txt
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(6)
  TripUpdate_StopTimeUpdate_StopTimeProperties get stopTimeProperties =>
      $_getN(5);
  @$pb.TagNumber(6)
  set stopTimeProperties(TripUpdate_StopTimeUpdate_StopTimeProperties value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStopTimeProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearStopTimeProperties() => $_clearField(6);
  @$pb.TagNumber(6)
  TripUpdate_StopTimeUpdate_StopTimeProperties ensureStopTimeProperties() =>
      $_ensure(5);

  /// Expected occupancy after departure from the given stop.
  /// Should be provided only for future stops.
  /// In order to provide departure_occupancy_status without either arrival or
  /// departure StopTimeEvents, ScheduleRelationship should be set to NO_DATA.
  @$pb.TagNumber(7)
  VehiclePosition_OccupancyStatus get departureOccupancyStatus => $_getN(6);
  @$pb.TagNumber(7)
  set departureOccupancyStatus(VehiclePosition_OccupancyStatus value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasDepartureOccupancyStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearDepartureOccupancyStatus() => $_clearField(7);
}

/// Defines updated properties of the trip, such as a new shape_id when there is a detour. Or defines the
/// trip_id, start_date, and start_time of a DUPLICATED trip.
/// NOTE: This message is still experimental, and subject to change. It may be formally adopted in the future.
class TripUpdate_TripProperties extends $pb.GeneratedMessage {
  factory TripUpdate_TripProperties({
    $core.String? tripId,
    $core.String? startDate,
    $core.String? startTime,
    $core.String? shapeId,
    $core.String? tripHeadsign,
    $core.String? tripShortName,
  }) {
    final result = create();
    if (tripId != null) result.tripId = tripId;
    if (startDate != null) result.startDate = startDate;
    if (startTime != null) result.startTime = startTime;
    if (shapeId != null) result.shapeId = shapeId;
    if (tripHeadsign != null) result.tripHeadsign = tripHeadsign;
    if (tripShortName != null) result.tripShortName = tripShortName;
    return result;
  }

  TripUpdate_TripProperties._();

  factory TripUpdate_TripProperties.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripUpdate_TripProperties.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripUpdate.TripProperties',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tripId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'startTime')
    ..aOS(4, _omitFieldNames ? '' : 'shapeId')
    ..aOS(5, _omitFieldNames ? '' : 'tripHeadsign')
    ..aOS(6, _omitFieldNames ? '' : 'tripShortName')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_TripProperties clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate_TripProperties copyWith(
          void Function(TripUpdate_TripProperties) updates) =>
      super.copyWith((message) => updates(message as TripUpdate_TripProperties))
          as TripUpdate_TripProperties;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_TripProperties create() => TripUpdate_TripProperties._();
  @$core.override
  TripUpdate_TripProperties createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_TripProperties getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripUpdate_TripProperties>(create);
  static TripUpdate_TripProperties? _defaultInstance;

  /// Defines the identifier of a new trip that is a duplicate of an existing trip defined in (CSV) GTFS trips.txt
  /// but will start at a different service date and/or time (defined using the TripProperties.start_date and
  /// TripProperties.start_time fields). See definition of trips.trip_id in (CSV) GTFS. Its value must be different
  /// than the ones used in the (CSV) GTFS. Required if schedule_relationship=DUPLICATED, otherwise this field must not
  /// be populated and will be ignored by consumers.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(1)
  $core.String get tripId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tripId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => $_clearField(1);

  /// Service date on which the DUPLICATED trip will be run, in YYYYMMDD format. Required if
  /// schedule_relationship=DUPLICATED, otherwise this field must not be populated and will be ignored by consumers.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => $_clearField(2);

  /// Defines the departure start time of the trip when it’s duplicated. See definition of stop_times.departure_time
  /// in (CSV) GTFS. Scheduled arrival and departure times for the duplicated trip are calculated based on the offset
  /// between the original trip departure_time and this field. For example, if a GTFS trip has stop A with a
  /// departure_time of 10:00:00 and stop B with departure_time of 10:01:00, and this field is populated with the value
  /// of 10:30:00, stop B on the duplicated trip will have a scheduled departure_time of 10:31:00. Real-time prediction
  /// delay values are applied to this calculated schedule time to determine the predicted time. For example, if a
  /// departure delay of 30 is provided for stop B, then the predicted departure time is 10:31:30. Real-time
  /// prediction time values do not have any offset applied to them and indicate the predicted time as provided.
  /// For example, if a departure time representing 10:31:30 is provided for stop B, then the predicted departure time
  /// is 10:31:30. This field is required if schedule_relationship is DUPLICATED, otherwise this field must not be
  /// populated and will be ignored by consumers.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(3)
  $core.String get startTime => $_getSZ(2);
  @$pb.TagNumber(3)
  set startTime($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartTime() => $_clearField(3);

  /// Specifies the identifier of the shape of the vehicle travel path when the trip shape differs from the shape specified in (CSV) GTFS
  /// or to specify it in real-time when it's not provided by (CSV) GTFS, such as a vehicle that takes differing paths based on rider demand. See definition of trips.shape_id in (CSV) GTFS.
  /// If a shape is neither defined in (CSV) GTFS nor in real-time, the shape is considered unknown. This field can refer to a shape defined in the (CSV) GTFS in shapes.txt or a `Shape` in the same (protobuf) real-time feed.
  /// The order of stops (stop sequences) for this trip must remain the same as (CSV) GTFS.
  /// If it refers to a `Shape` entity in the same real-time feed, the value of this field should be the one of the `shape_id` inside the entity, and _not_ the `id` of `FeedEntity`.
  /// Stops that are a part of the original trip but will no longer be made, such as when a detour occurs, should be marked as schedule_relationship=SKIPPED or more details can be provided via a `TripModifications` message.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  $core.String get shapeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set shapeId($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasShapeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearShapeId() => $_clearField(4);

  /// Specifies the headsign for this trip when it differs from the original.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(5)
  $core.String get tripHeadsign => $_getSZ(4);
  @$pb.TagNumber(5)
  set tripHeadsign($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTripHeadsign() => $_has(4);
  @$pb.TagNumber(5)
  void clearTripHeadsign() => $_clearField(5);

  /// Specifies the name for this trip when it differs from the original.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(6)
  $core.String get tripShortName => $_getSZ(5);
  @$pb.TagNumber(6)
  set tripShortName($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTripShortName() => $_has(5);
  @$pb.TagNumber(6)
  void clearTripShortName() => $_clearField(6);
}

/// Realtime update of the progress of a vehicle along a trip.
/// Depending on the value of ScheduleRelationship, a TripUpdate can specify:
/// - A trip that proceeds along the schedule.
/// - A trip that proceeds along a route but has no fixed schedule.
/// - A trip that have been added or removed with regard to schedule.
///
/// The updates can be for future, predicted arrival/departure events, or for
/// past events that already occurred.
/// Normally, updates should get more precise and more certain (see
/// uncertainty below) as the events gets closer to current time.
/// Even if that is not possible, the information for past events should be
/// precise and certain. In particular, if an update points to time in the past
/// but its update's uncertainty is not 0, the client should conclude that the
/// update is a (wrong) prediction and that the trip has not completed yet.
///
/// Note that the update can describe a trip that is already completed.
/// To this end, it is enough to provide an update for the last stop of the trip.
/// If the time of that is in the past, the client will conclude from that that
/// the whole trip is in the past (it is possible, although inconsequential, to
/// also provide updates for preceding stops).
/// This option is most relevant for a trip that has completed ahead of schedule,
/// but according to the schedule, the trip is still proceeding at the current
/// time. Removing the updates for this trip could make the client assume
/// that the trip is still proceeding.
/// Note that the feed provider is allowed, but not required, to purge past
/// updates - this is one case where this would be practically useful.
class TripUpdate extends $pb.GeneratedMessage {
  factory TripUpdate({
    TripDescriptor? trip,
    $core.Iterable<TripUpdate_StopTimeUpdate>? stopTimeUpdate,
    VehicleDescriptor? vehicle,
    $fixnum.Int64? timestamp,
    $core.int? delay,
    TripUpdate_TripProperties? tripProperties,
  }) {
    final result = create();
    if (trip != null) result.trip = trip;
    if (stopTimeUpdate != null) result.stopTimeUpdate.addAll(stopTimeUpdate);
    if (vehicle != null) result.vehicle = vehicle;
    if (timestamp != null) result.timestamp = timestamp;
    if (delay != null) result.delay = delay;
    if (tripProperties != null) result.tripProperties = tripProperties;
    return result;
  }

  TripUpdate._();

  factory TripUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripUpdate',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQM<TripDescriptor>(1, _omitFieldNames ? '' : 'trip',
        subBuilder: TripDescriptor.create)
    ..pPM<TripUpdate_StopTimeUpdate>(2, _omitFieldNames ? '' : 'stopTimeUpdate',
        subBuilder: TripUpdate_StopTimeUpdate.create)
    ..aOM<VehicleDescriptor>(3, _omitFieldNames ? '' : 'vehicle',
        subBuilder: VehicleDescriptor.create)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aI(5, _omitFieldNames ? '' : 'delay')
    ..aOM<TripUpdate_TripProperties>(6, _omitFieldNames ? '' : 'tripProperties',
        subBuilder: TripUpdate_TripProperties.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripUpdate copyWith(void Function(TripUpdate) updates) =>
      super.copyWith((message) => updates(message as TripUpdate)) as TripUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate create() => TripUpdate._();
  @$core.override
  TripUpdate createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripUpdate>(create);
  static TripUpdate? _defaultInstance;

  /// The Trip that this message applies to. There can be at most one
  /// TripUpdate entity for each actual trip instance.
  /// If there is none, that means there is no prediction information available.
  /// It does *not* mean that the trip is progressing according to schedule.
  @$pb.TagNumber(1)
  TripDescriptor get trip => $_getN(0);
  @$pb.TagNumber(1)
  set trip(TripDescriptor value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrip() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrip() => $_clearField(1);
  @$pb.TagNumber(1)
  TripDescriptor ensureTrip() => $_ensure(0);

  /// Updates to StopTimes for the trip (both future, i.e., predictions, and in
  /// some cases, past ones, i.e., those that already happened).
  /// The updates must be sorted by stop_sequence, and apply for all the
  /// following stops of the trip up to the next specified one.
  ///
  /// Example 1:
  /// For a trip with 20 stops, a StopTimeUpdate with arrival delay and departure
  /// delay of 0 for stop_sequence of the current stop means that the trip is
  /// exactly on time.
  ///
  /// Example 2:
  /// For the same trip instance, 3 StopTimeUpdates are provided:
  /// - delay of 5 min for stop_sequence 3
  /// - delay of 1 min for stop_sequence 8
  /// - delay of unspecified duration for stop_sequence 10
  /// This will be interpreted as:
  /// - stop_sequences 3,4,5,6,7 have delay of 5 min.
  /// - stop_sequences 8,9 have delay of 1 min.
  /// - stop_sequences 10,... have unknown delay.
  @$pb.TagNumber(2)
  $pb.PbList<TripUpdate_StopTimeUpdate> get stopTimeUpdate => $_getList(1);

  /// Additional information on the vehicle that is serving this trip.
  @$pb.TagNumber(3)
  VehicleDescriptor get vehicle => $_getN(2);
  @$pb.TagNumber(3)
  set vehicle(VehicleDescriptor value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVehicle() => $_has(2);
  @$pb.TagNumber(3)
  void clearVehicle() => $_clearField(3);
  @$pb.TagNumber(3)
  VehicleDescriptor ensureVehicle() => $_ensure(2);

  /// The most recent moment at which the vehicle's real-time progress was measured
  /// to estimate StopTimes in the future. When StopTimes in the past are provided,
  /// arrival/departure times may be earlier than this value. In POSIX
  /// time (i.e., the number of seconds since January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => $_clearField(4);

  /// The current schedule deviation for the trip.  Delay should only be
  /// specified when the prediction is given relative to some existing schedule
  /// in GTFS.
  ///
  /// Delay (in seconds) can be positive (meaning that the vehicle is late) or
  /// negative (meaning that the vehicle is ahead of schedule). Delay of 0
  /// means that the vehicle is exactly on time.
  ///
  /// Delay information in StopTimeUpdates take precedent of trip-level delay
  /// information, such that trip-level delay is only propagated until the next
  /// stop along the trip with a StopTimeUpdate delay value specified.
  ///
  /// Feed providers are strongly encouraged to provide a TripUpdate.timestamp
  /// value indicating when the delay value was last updated, in order to
  /// evaluate the freshness of the data.
  ///
  /// NOTE: This field is still experimental, and subject to change. It may be
  /// formally adopted in the future.
  @$pb.TagNumber(5)
  $core.int get delay => $_getIZ(4);
  @$pb.TagNumber(5)
  set delay($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDelay() => $_has(4);
  @$pb.TagNumber(5)
  void clearDelay() => $_clearField(5);

  @$pb.TagNumber(6)
  TripUpdate_TripProperties get tripProperties => $_getN(5);
  @$pb.TagNumber(6)
  set tripProperties(TripUpdate_TripProperties value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasTripProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearTripProperties() => $_clearField(6);
  @$pb.TagNumber(6)
  TripUpdate_TripProperties ensureTripProperties() => $_ensure(5);
}

/// Carriage specific details, used for vehicles composed of several carriages
/// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
class VehiclePosition_CarriageDetails extends $pb.GeneratedMessage {
  factory VehiclePosition_CarriageDetails({
    $core.String? id,
    $core.String? label,
    VehiclePosition_OccupancyStatus? occupancyStatus,
    $core.int? occupancyPercentage,
    $core.int? carriageSequence,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (label != null) result.label = label;
    if (occupancyStatus != null) result.occupancyStatus = occupancyStatus;
    if (occupancyPercentage != null)
      result.occupancyPercentage = occupancyPercentage;
    if (carriageSequence != null) result.carriageSequence = carriageSequence;
    return result;
  }

  VehiclePosition_CarriageDetails._();

  factory VehiclePosition_CarriageDetails.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VehiclePosition_CarriageDetails.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VehiclePosition.CarriageDetails',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aE<VehiclePosition_OccupancyStatus>(
        3, _omitFieldNames ? '' : 'occupancyStatus',
        defaultOrMaker: VehiclePosition_OccupancyStatus.NO_DATA_AVAILABLE,
        enumValues: VehiclePosition_OccupancyStatus.values)
    ..aI(4, _omitFieldNames ? '' : 'occupancyPercentage', defaultOrMaker: -1)
    ..aI(5, _omitFieldNames ? '' : 'carriageSequence',
        fieldType: $pb.PbFieldType.OU3)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehiclePosition_CarriageDetails clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehiclePosition_CarriageDetails copyWith(
          void Function(VehiclePosition_CarriageDetails) updates) =>
      super.copyWith(
              (message) => updates(message as VehiclePosition_CarriageDetails))
          as VehiclePosition_CarriageDetails;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehiclePosition_CarriageDetails create() =>
      VehiclePosition_CarriageDetails._();
  @$core.override
  VehiclePosition_CarriageDetails createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VehiclePosition_CarriageDetails getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VehiclePosition_CarriageDetails>(
          create);
  static VehiclePosition_CarriageDetails? _defaultInstance;

  /// Identification of the carriage. Should be unique per vehicle.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// User visible label that may be shown to the passenger to help identify
  /// the carriage. Example: "7712", "Car ABC-32", etc...
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  /// Occupancy status for this given carriage, in this vehicle
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(3)
  VehiclePosition_OccupancyStatus get occupancyStatus => $_getN(2);
  @$pb.TagNumber(3)
  set occupancyStatus(VehiclePosition_OccupancyStatus value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasOccupancyStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearOccupancyStatus() => $_clearField(3);

  /// Occupancy percentage for this given carriage, in this vehicle.
  /// Follows the same rules as "VehiclePosition.occupancy_percentage"
  /// -1 in case data is not available for this given carriage (as protobuf defaults to 0 otherwise)
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  $core.int get occupancyPercentage => $_getI(3, -1);
  @$pb.TagNumber(4)
  set occupancyPercentage($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOccupancyPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearOccupancyPercentage() => $_clearField(4);

  /// Identifies the order of this carriage with respect to the other
  /// carriages in the vehicle's list of CarriageDetails.
  /// The first carriage in the direction of travel must have a value of 1.
  /// The second value corresponds to the second carriage in the direction
  /// of travel and must have a value of 2, and so forth.
  /// For example, the first carriage in the direction of travel has a value of 1.
  /// If the second carriage in the direction of travel has a value of 3,
  /// consumers will discard data for all carriages (i.e., the multi_carriage_details field).
  /// Carriages without data must be represented with a valid carriage_sequence number and the fields
  /// without data should be omitted (alternately, those fields could also be included and set to the "no data" values).
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(5)
  $core.int get carriageSequence => $_getIZ(4);
  @$pb.TagNumber(5)
  set carriageSequence($core.int value) => $_setUnsignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasCarriageSequence() => $_has(4);
  @$pb.TagNumber(5)
  void clearCarriageSequence() => $_clearField(5);
}

/// Realtime positioning information for a given vehicle.
class VehiclePosition extends $pb.GeneratedMessage {
  factory VehiclePosition({
    TripDescriptor? trip,
    Position? position,
    $core.int? currentStopSequence,
    VehiclePosition_VehicleStopStatus? currentStatus,
    $fixnum.Int64? timestamp,
    VehiclePosition_CongestionLevel? congestionLevel,
    $core.String? stopId,
    VehicleDescriptor? vehicle,
    VehiclePosition_OccupancyStatus? occupancyStatus,
    $core.int? occupancyPercentage,
    $core.Iterable<VehiclePosition_CarriageDetails>? multiCarriageDetails,
  }) {
    final result = create();
    if (trip != null) result.trip = trip;
    if (position != null) result.position = position;
    if (currentStopSequence != null)
      result.currentStopSequence = currentStopSequence;
    if (currentStatus != null) result.currentStatus = currentStatus;
    if (timestamp != null) result.timestamp = timestamp;
    if (congestionLevel != null) result.congestionLevel = congestionLevel;
    if (stopId != null) result.stopId = stopId;
    if (vehicle != null) result.vehicle = vehicle;
    if (occupancyStatus != null) result.occupancyStatus = occupancyStatus;
    if (occupancyPercentage != null)
      result.occupancyPercentage = occupancyPercentage;
    if (multiCarriageDetails != null)
      result.multiCarriageDetails.addAll(multiCarriageDetails);
    return result;
  }

  VehiclePosition._();

  factory VehiclePosition.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VehiclePosition.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VehiclePosition',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOM<TripDescriptor>(1, _omitFieldNames ? '' : 'trip',
        subBuilder: TripDescriptor.create)
    ..aOM<Position>(2, _omitFieldNames ? '' : 'position',
        subBuilder: Position.create)
    ..aI(3, _omitFieldNames ? '' : 'currentStopSequence',
        fieldType: $pb.PbFieldType.OU3)
    ..aE<VehiclePosition_VehicleStopStatus>(
        4, _omitFieldNames ? '' : 'currentStatus',
        defaultOrMaker: VehiclePosition_VehicleStopStatus.IN_TRANSIT_TO,
        enumValues: VehiclePosition_VehicleStopStatus.values)
    ..a<$fixnum.Int64>(
        5, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<VehiclePosition_CongestionLevel>(
        6, _omitFieldNames ? '' : 'congestionLevel',
        enumValues: VehiclePosition_CongestionLevel.values)
    ..aOS(7, _omitFieldNames ? '' : 'stopId')
    ..aOM<VehicleDescriptor>(8, _omitFieldNames ? '' : 'vehicle',
        subBuilder: VehicleDescriptor.create)
    ..aE<VehiclePosition_OccupancyStatus>(
        9, _omitFieldNames ? '' : 'occupancyStatus',
        enumValues: VehiclePosition_OccupancyStatus.values)
    ..aI(10, _omitFieldNames ? '' : 'occupancyPercentage',
        fieldType: $pb.PbFieldType.OU3)
    ..pPM<VehiclePosition_CarriageDetails>(
        11, _omitFieldNames ? '' : 'multiCarriageDetails',
        subBuilder: VehiclePosition_CarriageDetails.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehiclePosition clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehiclePosition copyWith(void Function(VehiclePosition) updates) =>
      super.copyWith((message) => updates(message as VehiclePosition))
          as VehiclePosition;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehiclePosition create() => VehiclePosition._();
  @$core.override
  VehiclePosition createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VehiclePosition getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VehiclePosition>(create);
  static VehiclePosition? _defaultInstance;

  /// The Trip that this vehicle is serving.
  /// Can be empty or partial if the vehicle can not be identified with a given
  /// trip instance.
  @$pb.TagNumber(1)
  TripDescriptor get trip => $_getN(0);
  @$pb.TagNumber(1)
  set trip(TripDescriptor value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasTrip() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrip() => $_clearField(1);
  @$pb.TagNumber(1)
  TripDescriptor ensureTrip() => $_ensure(0);

  /// Current position of this vehicle.
  @$pb.TagNumber(2)
  Position get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(Position value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => $_clearField(2);
  @$pb.TagNumber(2)
  Position ensurePosition() => $_ensure(1);

  /// The stop sequence index of the current stop. The meaning of
  /// current_stop_sequence (i.e., the stop that it refers to) is determined by
  /// current_status.
  /// If current_status is missing IN_TRANSIT_TO is assumed.
  @$pb.TagNumber(3)
  $core.int get currentStopSequence => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentStopSequence($core.int value) => $_setUnsignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCurrentStopSequence() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentStopSequence() => $_clearField(3);

  /// The exact status of the vehicle with respect to the current stop.
  /// Ignored if current_stop_sequence is missing.
  @$pb.TagNumber(4)
  VehiclePosition_VehicleStopStatus get currentStatus => $_getN(3);
  @$pb.TagNumber(4)
  set currentStatus(VehiclePosition_VehicleStopStatus value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasCurrentStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentStatus() => $_clearField(4);

  /// Moment at which the vehicle's position was measured. In POSIX time
  /// (i.e., number of seconds since January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => $_clearField(5);

  @$pb.TagNumber(6)
  VehiclePosition_CongestionLevel get congestionLevel => $_getN(5);
  @$pb.TagNumber(6)
  set congestionLevel(VehiclePosition_CongestionLevel value) =>
      $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCongestionLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearCongestionLevel() => $_clearField(6);

  /// Identifies the current stop. The value must be the same as in stops.txt in
  /// the corresponding GTFS feed.
  @$pb.TagNumber(7)
  $core.String get stopId => $_getSZ(6);
  @$pb.TagNumber(7)
  set stopId($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStopId() => $_has(6);
  @$pb.TagNumber(7)
  void clearStopId() => $_clearField(7);

  /// Additional information on the vehicle that is serving this trip.
  @$pb.TagNumber(8)
  VehicleDescriptor get vehicle => $_getN(7);
  @$pb.TagNumber(8)
  set vehicle(VehicleDescriptor value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasVehicle() => $_has(7);
  @$pb.TagNumber(8)
  void clearVehicle() => $_clearField(8);
  @$pb.TagNumber(8)
  VehicleDescriptor ensureVehicle() => $_ensure(7);

  /// If multi_carriage_status is populated with per-carriage OccupancyStatus,
  /// then this field should describe the entire vehicle with all carriages accepting passengers considered.
  @$pb.TagNumber(9)
  VehiclePosition_OccupancyStatus get occupancyStatus => $_getN(8);
  @$pb.TagNumber(9)
  set occupancyStatus(VehiclePosition_OccupancyStatus value) =>
      $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasOccupancyStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearOccupancyStatus() => $_clearField(9);

  /// A percentage value indicating the degree of passenger occupancy in the vehicle.
  /// The values are represented as an integer without decimals. 0 means 0% and 100 means 100%.
  /// The value 100 should represent the total maximum occupancy the vehicle was designed for,
  /// including both seated and standing capacity, and current operating regulations allow.
  /// The value may exceed 100 if there are more passengers than the maximum designed capacity.
  /// The precision of occupancy_percentage should be low enough that individual passengers cannot be tracked boarding or alighting the vehicle.
  /// If multi_carriage_status is populated with per-carriage occupancy_percentage,
  /// then this field should describe the entire vehicle with all carriages accepting passengers considered.
  /// This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(10)
  $core.int get occupancyPercentage => $_getIZ(9);
  @$pb.TagNumber(10)
  set occupancyPercentage($core.int value) => $_setUnsignedInt32(9, value);
  @$pb.TagNumber(10)
  $core.bool hasOccupancyPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearOccupancyPercentage() => $_clearField(10);

  /// Details of the multiple carriages of this given vehicle.
  /// The first occurrence represents the first carriage of the vehicle,
  /// given the current direction of travel.
  /// The number of occurrences of the multi_carriage_details
  /// field represents the number of carriages of the vehicle.
  /// It also includes non boardable carriages,
  /// like engines, maintenance carriages, etc… as they provide valuable
  /// information to passengers about where to stand on a platform.
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(11)
  $pb.PbList<VehiclePosition_CarriageDetails> get multiCarriageDetails =>
      $_getList(10);
}

/// An alert, indicating some sort of incident in the public transit network.
class Alert extends $pb.GeneratedMessage {
  factory Alert({
    $core.Iterable<TimeRange>? activePeriod,
    $core.Iterable<EntitySelector>? informedEntity,
    Alert_Cause? cause,
    Alert_Effect? effect,
    TranslatedString? url,
    TranslatedString? headerText,
    TranslatedString? descriptionText,
    TranslatedString? ttsHeaderText,
    TranslatedString? ttsDescriptionText,
    Alert_SeverityLevel? severityLevel,
    TranslatedImage? image,
    TranslatedString? imageAlternativeText,
    TranslatedString? causeDetail,
    TranslatedString? effectDetail,
  }) {
    final result = create();
    if (activePeriod != null) result.activePeriod.addAll(activePeriod);
    if (informedEntity != null) result.informedEntity.addAll(informedEntity);
    if (cause != null) result.cause = cause;
    if (effect != null) result.effect = effect;
    if (url != null) result.url = url;
    if (headerText != null) result.headerText = headerText;
    if (descriptionText != null) result.descriptionText = descriptionText;
    if (ttsHeaderText != null) result.ttsHeaderText = ttsHeaderText;
    if (ttsDescriptionText != null)
      result.ttsDescriptionText = ttsDescriptionText;
    if (severityLevel != null) result.severityLevel = severityLevel;
    if (image != null) result.image = image;
    if (imageAlternativeText != null)
      result.imageAlternativeText = imageAlternativeText;
    if (causeDetail != null) result.causeDetail = causeDetail;
    if (effectDetail != null) result.effectDetail = effectDetail;
    return result;
  }

  Alert._();

  factory Alert.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Alert.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Alert',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..pPM<TimeRange>(1, _omitFieldNames ? '' : 'activePeriod',
        subBuilder: TimeRange.create)
    ..pPM<EntitySelector>(5, _omitFieldNames ? '' : 'informedEntity',
        subBuilder: EntitySelector.create)
    ..aE<Alert_Cause>(6, _omitFieldNames ? '' : 'cause',
        defaultOrMaker: Alert_Cause.UNKNOWN_CAUSE,
        enumValues: Alert_Cause.values)
    ..aE<Alert_Effect>(7, _omitFieldNames ? '' : 'effect',
        defaultOrMaker: Alert_Effect.UNKNOWN_EFFECT,
        enumValues: Alert_Effect.values)
    ..aOM<TranslatedString>(8, _omitFieldNames ? '' : 'url',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(10, _omitFieldNames ? '' : 'headerText',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(11, _omitFieldNames ? '' : 'descriptionText',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(12, _omitFieldNames ? '' : 'ttsHeaderText',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(13, _omitFieldNames ? '' : 'ttsDescriptionText',
        subBuilder: TranslatedString.create)
    ..aE<Alert_SeverityLevel>(14, _omitFieldNames ? '' : 'severityLevel',
        defaultOrMaker: Alert_SeverityLevel.UNKNOWN_SEVERITY,
        enumValues: Alert_SeverityLevel.values)
    ..aOM<TranslatedImage>(15, _omitFieldNames ? '' : 'image',
        subBuilder: TranslatedImage.create)
    ..aOM<TranslatedString>(16, _omitFieldNames ? '' : 'imageAlternativeText',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(17, _omitFieldNames ? '' : 'causeDetail',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(18, _omitFieldNames ? '' : 'effectDetail',
        subBuilder: TranslatedString.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Alert clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Alert copyWith(void Function(Alert) updates) =>
      super.copyWith((message) => updates(message as Alert)) as Alert;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Alert create() => Alert._();
  @$core.override
  Alert createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Alert getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Alert>(create);
  static Alert? _defaultInstance;

  /// Time when the alert should be shown to the user. If missing, the
  /// alert will be shown as long as it appears in the feed.
  /// If multiple ranges are given, the alert will be shown during all of them.
  @$pb.TagNumber(1)
  $pb.PbList<TimeRange> get activePeriod => $_getList(0);

  /// Entities whose users we should notify of this alert.
  @$pb.TagNumber(5)
  $pb.PbList<EntitySelector> get informedEntity => $_getList(1);

  @$pb.TagNumber(6)
  Alert_Cause get cause => $_getN(2);
  @$pb.TagNumber(6)
  set cause(Alert_Cause value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasCause() => $_has(2);
  @$pb.TagNumber(6)
  void clearCause() => $_clearField(6);

  @$pb.TagNumber(7)
  Alert_Effect get effect => $_getN(3);
  @$pb.TagNumber(7)
  set effect(Alert_Effect value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasEffect() => $_has(3);
  @$pb.TagNumber(7)
  void clearEffect() => $_clearField(7);

  /// The URL which provides additional information about the alert.
  @$pb.TagNumber(8)
  TranslatedString get url => $_getN(4);
  @$pb.TagNumber(8)
  set url(TranslatedString value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasUrl() => $_has(4);
  @$pb.TagNumber(8)
  void clearUrl() => $_clearField(8);
  @$pb.TagNumber(8)
  TranslatedString ensureUrl() => $_ensure(4);

  /// Alert header. Contains a short summary of the alert text as plain-text.
  @$pb.TagNumber(10)
  TranslatedString get headerText => $_getN(5);
  @$pb.TagNumber(10)
  set headerText(TranslatedString value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasHeaderText() => $_has(5);
  @$pb.TagNumber(10)
  void clearHeaderText() => $_clearField(10);
  @$pb.TagNumber(10)
  TranslatedString ensureHeaderText() => $_ensure(5);

  /// Full description for the alert as plain-text. The information in the
  /// description should add to the information of the header.
  @$pb.TagNumber(11)
  TranslatedString get descriptionText => $_getN(6);
  @$pb.TagNumber(11)
  set descriptionText(TranslatedString value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasDescriptionText() => $_has(6);
  @$pb.TagNumber(11)
  void clearDescriptionText() => $_clearField(11);
  @$pb.TagNumber(11)
  TranslatedString ensureDescriptionText() => $_ensure(6);

  /// Text for alert header to be used in text-to-speech implementations. This field is the text-to-speech version of header_text.
  @$pb.TagNumber(12)
  TranslatedString get ttsHeaderText => $_getN(7);
  @$pb.TagNumber(12)
  set ttsHeaderText(TranslatedString value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasTtsHeaderText() => $_has(7);
  @$pb.TagNumber(12)
  void clearTtsHeaderText() => $_clearField(12);
  @$pb.TagNumber(12)
  TranslatedString ensureTtsHeaderText() => $_ensure(7);

  /// Text for full description for the alert to be used in text-to-speech implementations. This field is the text-to-speech version of description_text.
  @$pb.TagNumber(13)
  TranslatedString get ttsDescriptionText => $_getN(8);
  @$pb.TagNumber(13)
  set ttsDescriptionText(TranslatedString value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasTtsDescriptionText() => $_has(8);
  @$pb.TagNumber(13)
  void clearTtsDescriptionText() => $_clearField(13);
  @$pb.TagNumber(13)
  TranslatedString ensureTtsDescriptionText() => $_ensure(8);

  @$pb.TagNumber(14)
  Alert_SeverityLevel get severityLevel => $_getN(9);
  @$pb.TagNumber(14)
  set severityLevel(Alert_SeverityLevel value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasSeverityLevel() => $_has(9);
  @$pb.TagNumber(14)
  void clearSeverityLevel() => $_clearField(14);

  /// TranslatedImage to be displayed along the alert text. Used to explain visually the alert effect of a detour, station closure, etc. The image must enhance the understanding of the alert. Any essential information communicated within the image must also be contained in the alert text.
  /// The following types of images are discouraged : image containing mainly text, marketing or branded images that add no additional information.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(15)
  TranslatedImage get image => $_getN(10);
  @$pb.TagNumber(15)
  set image(TranslatedImage value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasImage() => $_has(10);
  @$pb.TagNumber(15)
  void clearImage() => $_clearField(15);
  @$pb.TagNumber(15)
  TranslatedImage ensureImage() => $_ensure(10);

  /// Text describing the appearance of the linked image in the `image` field (e.g., in case the image can't be displayed
  /// or the user can't see the image for accessibility reasons). See the HTML spec for alt image text - https://html.spec.whatwg.org/#alt.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(16)
  TranslatedString get imageAlternativeText => $_getN(11);
  @$pb.TagNumber(16)
  set imageAlternativeText(TranslatedString value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasImageAlternativeText() => $_has(11);
  @$pb.TagNumber(16)
  void clearImageAlternativeText() => $_clearField(16);
  @$pb.TagNumber(16)
  TranslatedString ensureImageAlternativeText() => $_ensure(11);

  /// Description of the cause of the alert that allows for agency-specific language; more specific than the Cause. If cause_detail is included, then Cause must also be included.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(17)
  TranslatedString get causeDetail => $_getN(12);
  @$pb.TagNumber(17)
  set causeDetail(TranslatedString value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasCauseDetail() => $_has(12);
  @$pb.TagNumber(17)
  void clearCauseDetail() => $_clearField(17);
  @$pb.TagNumber(17)
  TranslatedString ensureCauseDetail() => $_ensure(12);

  /// Description of the effect of the alert that allows for agency-specific language; more specific than the Effect. If effect_detail is included, then Effect must also be included.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(18)
  TranslatedString get effectDetail => $_getN(13);
  @$pb.TagNumber(18)
  set effectDetail(TranslatedString value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasEffectDetail() => $_has(13);
  @$pb.TagNumber(18)
  void clearEffectDetail() => $_clearField(18);
  @$pb.TagNumber(18)
  TranslatedString ensureEffectDetail() => $_ensure(13);
}

/// A time interval. The interval is considered active at time 't' if 't' is
/// greater than or equal to the start time and less than the end time.
class TimeRange extends $pb.GeneratedMessage {
  factory TimeRange({
    $fixnum.Int64? start,
    $fixnum.Int64? end,
  }) {
    final result = create();
    if (start != null) result.start = start;
    if (end != null) result.end = end;
    return result;
  }

  TimeRange._();

  factory TimeRange.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TimeRange.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TimeRange',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'start', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'end', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeRange clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TimeRange copyWith(void Function(TimeRange) updates) =>
      super.copyWith((message) => updates(message as TimeRange)) as TimeRange;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeRange create() => TimeRange._();
  @$core.override
  TimeRange createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TimeRange getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeRange>(create);
  static TimeRange? _defaultInstance;

  /// Start time, in POSIX time (i.e., number of seconds since January 1st 1970
  /// 00:00:00 UTC).
  /// If missing, the interval starts at minus infinity.
  @$pb.TagNumber(1)
  $fixnum.Int64 get start => $_getI64(0);
  @$pb.TagNumber(1)
  set start($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => $_clearField(1);

  /// End time, in POSIX time (i.e., number of seconds since January 1st 1970
  /// 00:00:00 UTC).
  /// If missing, the interval ends at plus infinity.
  @$pb.TagNumber(2)
  $fixnum.Int64 get end => $_getI64(1);
  @$pb.TagNumber(2)
  set end($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => $_clearField(2);
}

/// A position.
class Position extends $pb.GeneratedMessage {
  factory Position({
    $core.double? latitude,
    $core.double? longitude,
    $core.double? bearing,
    $core.double? odometer,
    $core.double? speed,
  }) {
    final result = create();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (bearing != null) result.bearing = bearing;
    if (odometer != null) result.odometer = odometer;
    if (speed != null) result.speed = speed;
    return result;
  }

  Position._();

  factory Position.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Position.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Position',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'latitude', fieldType: $pb.PbFieldType.QF)
    ..aD(2, _omitFieldNames ? '' : 'longitude', fieldType: $pb.PbFieldType.QF)
    ..aD(3, _omitFieldNames ? '' : 'bearing', fieldType: $pb.PbFieldType.OF)
    ..aD(4, _omitFieldNames ? '' : 'odometer')
    ..aD(5, _omitFieldNames ? '' : 'speed', fieldType: $pb.PbFieldType.OF)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Position clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Position copyWith(void Function(Position) updates) =>
      super.copyWith((message) => updates(message as Position)) as Position;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  @$core.override
  Position createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  /// Degrees North, in the WGS-84 coordinate system.
  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setFloat(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  /// Degrees East, in the WGS-84 coordinate system.
  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setFloat(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);

  /// Bearing, in degrees, clockwise from North, i.e., 0 is North and 90 is East.
  /// This can be the compass bearing, or the direction towards the next stop
  /// or intermediate location.
  /// This should not be direction deduced from the sequence of previous
  /// positions, which can be computed from previous data.
  @$pb.TagNumber(3)
  $core.double get bearing => $_getN(2);
  @$pb.TagNumber(3)
  set bearing($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBearing() => $_has(2);
  @$pb.TagNumber(3)
  void clearBearing() => $_clearField(3);

  /// Odometer value, in meters.
  @$pb.TagNumber(4)
  $core.double get odometer => $_getN(3);
  @$pb.TagNumber(4)
  set odometer($core.double value) => $_setDouble(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOdometer() => $_has(3);
  @$pb.TagNumber(4)
  void clearOdometer() => $_clearField(4);

  /// Momentary speed measured by the vehicle, in meters per second.
  @$pb.TagNumber(5)
  $core.double get speed => $_getN(4);
  @$pb.TagNumber(5)
  set speed($core.double value) => $_setFloat(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSpeed() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpeed() => $_clearField(5);
}

class TripDescriptor_ModifiedTripSelector extends $pb.GeneratedMessage {
  factory TripDescriptor_ModifiedTripSelector({
    $core.String? modificationsId,
    $core.String? affectedTripId,
    $core.String? startTime,
    $core.String? startDate,
  }) {
    final result = create();
    if (modificationsId != null) result.modificationsId = modificationsId;
    if (affectedTripId != null) result.affectedTripId = affectedTripId;
    if (startTime != null) result.startTime = startTime;
    if (startDate != null) result.startDate = startDate;
    return result;
  }

  TripDescriptor_ModifiedTripSelector._();

  factory TripDescriptor_ModifiedTripSelector.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripDescriptor_ModifiedTripSelector.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripDescriptor.ModifiedTripSelector',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'modificationsId')
    ..aOS(2, _omitFieldNames ? '' : 'affectedTripId')
    ..aOS(3, _omitFieldNames ? '' : 'startTime')
    ..aOS(4, _omitFieldNames ? '' : 'startDate')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripDescriptor_ModifiedTripSelector clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripDescriptor_ModifiedTripSelector copyWith(
          void Function(TripDescriptor_ModifiedTripSelector) updates) =>
      super.copyWith((message) =>
              updates(message as TripDescriptor_ModifiedTripSelector))
          as TripDescriptor_ModifiedTripSelector;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripDescriptor_ModifiedTripSelector create() =>
      TripDescriptor_ModifiedTripSelector._();
  @$core.override
  TripDescriptor_ModifiedTripSelector createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripDescriptor_ModifiedTripSelector getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          TripDescriptor_ModifiedTripSelector>(create);
  static TripDescriptor_ModifiedTripSelector? _defaultInstance;

  /// The 'id' from the FeedEntity in which the contained TripModifications object affects this trip.
  @$pb.TagNumber(1)
  $core.String get modificationsId => $_getSZ(0);
  @$pb.TagNumber(1)
  set modificationsId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasModificationsId() => $_has(0);
  @$pb.TagNumber(1)
  void clearModificationsId() => $_clearField(1);

  /// The trip_id from the GTFS feed that is modified by the modifications_id
  @$pb.TagNumber(2)
  $core.String get affectedTripId => $_getSZ(1);
  @$pb.TagNumber(2)
  set affectedTripId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAffectedTripId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAffectedTripId() => $_clearField(2);

  /// The initially scheduled start time of this trip instance, applied to the frequency based modified trip. Same definition as start_time in TripDescriptor.
  @$pb.TagNumber(3)
  $core.String get startTime => $_getSZ(2);
  @$pb.TagNumber(3)
  set startTime($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartTime() => $_clearField(3);

  /// The start date of this trip instance in YYYYMMDD format, applied to the modified trip. Same definition as start_date in TripDescriptor.
  @$pb.TagNumber(4)
  $core.String get startDate => $_getSZ(3);
  @$pb.TagNumber(4)
  set startDate($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasStartDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearStartDate() => $_clearField(4);
}

/// A descriptor that identifies an instance of a GTFS trip, or all instances of
/// a trip along a route.
/// - To specify a single trip instance, the trip_id (and if necessary,
///   start_time) is set. If route_id is also set, then it should be same as one
///   that the given trip corresponds to.
/// - To specify all the trips along a given route, only the route_id should be
///   set. Note that if the trip_id is not known, then stop sequence ids in
///   TripUpdate are not sufficient, and stop_ids must be provided as well. In
///   addition, absolute arrival/departure times must be provided.
class TripDescriptor extends $pb.GeneratedMessage {
  factory TripDescriptor({
    $core.String? tripId,
    $core.String? startTime,
    $core.String? startDate,
    TripDescriptor_ScheduleRelationship? scheduleRelationship,
    $core.String? routeId,
    $core.int? directionId,
    TripDescriptor_ModifiedTripSelector? modifiedTrip,
  }) {
    final result = create();
    if (tripId != null) result.tripId = tripId;
    if (startTime != null) result.startTime = startTime;
    if (startDate != null) result.startDate = startDate;
    if (scheduleRelationship != null)
      result.scheduleRelationship = scheduleRelationship;
    if (routeId != null) result.routeId = routeId;
    if (directionId != null) result.directionId = directionId;
    if (modifiedTrip != null) result.modifiedTrip = modifiedTrip;
    return result;
  }

  TripDescriptor._();

  factory TripDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripDescriptor',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tripId')
    ..aOS(2, _omitFieldNames ? '' : 'startTime')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..aE<TripDescriptor_ScheduleRelationship>(
        4, _omitFieldNames ? '' : 'scheduleRelationship',
        enumValues: TripDescriptor_ScheduleRelationship.values)
    ..aOS(5, _omitFieldNames ? '' : 'routeId')
    ..aI(6, _omitFieldNames ? '' : 'directionId',
        fieldType: $pb.PbFieldType.OU3)
    ..aOM<TripDescriptor_ModifiedTripSelector>(
        7, _omitFieldNames ? '' : 'modifiedTrip',
        subBuilder: TripDescriptor_ModifiedTripSelector.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripDescriptor copyWith(void Function(TripDescriptor) updates) =>
      super.copyWith((message) => updates(message as TripDescriptor))
          as TripDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripDescriptor create() => TripDescriptor._();
  @$core.override
  TripDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripDescriptor>(create);
  static TripDescriptor? _defaultInstance;

  /// The trip_id from the GTFS feed that this selector refers to.
  /// For non frequency-based trips, this field is enough to uniquely identify
  /// the trip. For frequency-based trip, start_time and start_date might also be
  /// necessary. When schedule_relationship is DUPLICATED within a TripUpdate, the trip_id identifies the trip from
  /// static GTFS to be duplicated. When schedule_relationship is DUPLICATED within a VehiclePosition, the trip_id
  /// identifies the new duplicate trip and must contain the value for the corresponding TripUpdate.TripProperties.trip_id.
  @$pb.TagNumber(1)
  $core.String get tripId => $_getSZ(0);
  @$pb.TagNumber(1)
  set tripId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => $_clearField(1);

  /// The initially scheduled start time of this trip instance.
  /// When the trip_id corresponds to a non-frequency-based trip, this field
  /// should either be omitted or be equal to the value in the GTFS feed. When
  /// the trip_id correponds to a frequency-based trip, the start_time must be
  /// specified for trip updates and vehicle positions. If the trip corresponds
  /// to exact_times=1 GTFS record, then start_time must be some multiple
  /// (including zero) of headway_secs later than frequencies.txt start_time for
  /// the corresponding time period. If the trip corresponds to exact_times=0,
  /// then its start_time may be arbitrary, and is initially expected to be the
  /// first departure of the trip. Once established, the start_time of this
  /// frequency-based trip should be considered immutable, even if the first
  /// departure time changes -- that time change may instead be reflected in a
  /// StopTimeUpdate.
  /// Format and semantics of the field is same as that of
  /// GTFS/frequencies.txt/start_time, e.g., 11:15:35 or 25:15:35.
  @$pb.TagNumber(2)
  $core.String get startTime => $_getSZ(1);
  @$pb.TagNumber(2)
  set startTime($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => $_clearField(2);

  /// The scheduled start date of this trip instance.
  /// Must be provided to disambiguate trips that are so late as to collide with
  /// a scheduled trip on a next day. For example, for a train that departs 8:00
  /// and 20:00 every day, and is 12 hours late, there would be two distinct
  /// trips on the same time.
  /// This field can be provided but is not mandatory for schedules in which such
  /// collisions are impossible - for example, a service running on hourly
  /// schedule where a vehicle that is one hour late is not considered to be
  /// related to schedule anymore.
  /// In YYYYMMDD format.
  @$pb.TagNumber(3)
  $core.String get startDate => $_getSZ(2);
  @$pb.TagNumber(3)
  set startDate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => $_clearField(3);

  @$pb.TagNumber(4)
  TripDescriptor_ScheduleRelationship get scheduleRelationship => $_getN(3);
  @$pb.TagNumber(4)
  set scheduleRelationship(TripDescriptor_ScheduleRelationship value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasScheduleRelationship() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduleRelationship() => $_clearField(4);

  /// The route_id from the GTFS that this selector refers to.
  @$pb.TagNumber(5)
  $core.String get routeId => $_getSZ(4);
  @$pb.TagNumber(5)
  set routeId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasRouteId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRouteId() => $_clearField(5);

  /// The direction_id from the GTFS feed trips.txt file, indicating the
  /// direction of travel for trips this selector refers to.
  @$pb.TagNumber(6)
  $core.int get directionId => $_getIZ(5);
  @$pb.TagNumber(6)
  set directionId($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDirectionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirectionId() => $_clearField(6);

  /// Linkage to any modifications done to this trip (shape changes, removal or addition of stops).
  /// If this field is provided, the `trip_id`, `route_id`, `direction_id`, `start_time`, `start_date` fields of the `TripDescriptor` MUST be left empty, to avoid confusion by consumers that aren't looking for the `ModifiedTripSelector` value.
  @$pb.TagNumber(7)
  TripDescriptor_ModifiedTripSelector get modifiedTrip => $_getN(6);
  @$pb.TagNumber(7)
  set modifiedTrip(TripDescriptor_ModifiedTripSelector value) =>
      $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasModifiedTrip() => $_has(6);
  @$pb.TagNumber(7)
  void clearModifiedTrip() => $_clearField(7);
  @$pb.TagNumber(7)
  TripDescriptor_ModifiedTripSelector ensureModifiedTrip() => $_ensure(6);
}

/// Identification information for the vehicle performing the trip.
class VehicleDescriptor extends $pb.GeneratedMessage {
  factory VehicleDescriptor({
    $core.String? id,
    $core.String? label,
    $core.String? licensePlate,
    VehicleDescriptor_WheelchairAccessible? wheelchairAccessible,
  }) {
    final result = create();
    if (id != null) result.id = id;
    if (label != null) result.label = label;
    if (licensePlate != null) result.licensePlate = licensePlate;
    if (wheelchairAccessible != null)
      result.wheelchairAccessible = wheelchairAccessible;
    return result;
  }

  VehicleDescriptor._();

  factory VehicleDescriptor.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VehicleDescriptor.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VehicleDescriptor',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'licensePlate')
    ..aE<VehicleDescriptor_WheelchairAccessible>(
        4, _omitFieldNames ? '' : 'wheelchairAccessible',
        defaultOrMaker: VehicleDescriptor_WheelchairAccessible.NO_VALUE,
        enumValues: VehicleDescriptor_WheelchairAccessible.values)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehicleDescriptor clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VehicleDescriptor copyWith(void Function(VehicleDescriptor) updates) =>
      super.copyWith((message) => updates(message as VehicleDescriptor))
          as VehicleDescriptor;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehicleDescriptor create() => VehicleDescriptor._();
  @$core.override
  VehicleDescriptor createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VehicleDescriptor getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VehicleDescriptor>(create);
  static VehicleDescriptor? _defaultInstance;

  /// Internal system identification of the vehicle. Should be unique per
  /// vehicle, and can be used for tracking the vehicle as it proceeds through
  /// the system.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// User visible label, i.e., something that must be shown to the passenger to
  /// help identify the correct vehicle.
  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => $_clearField(2);

  /// The license plate of the vehicle.
  @$pb.TagNumber(3)
  $core.String get licensePlate => $_getSZ(2);
  @$pb.TagNumber(3)
  set licensePlate($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLicensePlate() => $_has(2);
  @$pb.TagNumber(3)
  void clearLicensePlate() => $_clearField(3);

  @$pb.TagNumber(4)
  VehicleDescriptor_WheelchairAccessible get wheelchairAccessible => $_getN(3);
  @$pb.TagNumber(4)
  set wheelchairAccessible(VehicleDescriptor_WheelchairAccessible value) =>
      $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasWheelchairAccessible() => $_has(3);
  @$pb.TagNumber(4)
  void clearWheelchairAccessible() => $_clearField(4);
}

/// A selector for an entity in a GTFS feed.
class EntitySelector extends $pb.GeneratedMessage {
  factory EntitySelector({
    $core.String? agencyId,
    $core.String? routeId,
    $core.int? routeType,
    TripDescriptor? trip,
    $core.String? stopId,
    $core.int? directionId,
  }) {
    final result = create();
    if (agencyId != null) result.agencyId = agencyId;
    if (routeId != null) result.routeId = routeId;
    if (routeType != null) result.routeType = routeType;
    if (trip != null) result.trip = trip;
    if (stopId != null) result.stopId = stopId;
    if (directionId != null) result.directionId = directionId;
    return result;
  }

  EntitySelector._();

  factory EntitySelector.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory EntitySelector.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EntitySelector',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'agencyId')
    ..aOS(2, _omitFieldNames ? '' : 'routeId')
    ..aI(3, _omitFieldNames ? '' : 'routeType')
    ..aOM<TripDescriptor>(4, _omitFieldNames ? '' : 'trip',
        subBuilder: TripDescriptor.create)
    ..aOS(5, _omitFieldNames ? '' : 'stopId')
    ..aI(6, _omitFieldNames ? '' : 'directionId',
        fieldType: $pb.PbFieldType.OU3)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntitySelector clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EntitySelector copyWith(void Function(EntitySelector) updates) =>
      super.copyWith((message) => updates(message as EntitySelector))
          as EntitySelector;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EntitySelector create() => EntitySelector._();
  @$core.override
  EntitySelector createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static EntitySelector getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EntitySelector>(create);
  static EntitySelector? _defaultInstance;

  /// The values of the fields should correspond to the appropriate fields in the
  /// GTFS feed.
  /// At least one specifier must be given. If several are given, then the
  /// matching has to apply to all the given specifiers.
  @$pb.TagNumber(1)
  $core.String get agencyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set agencyId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAgencyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAgencyId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get routeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set routeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRouteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRouteId() => $_clearField(2);

  /// corresponds to route_type in GTFS.
  @$pb.TagNumber(3)
  $core.int get routeType => $_getIZ(2);
  @$pb.TagNumber(3)
  set routeType($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRouteType() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteType() => $_clearField(3);

  @$pb.TagNumber(4)
  TripDescriptor get trip => $_getN(3);
  @$pb.TagNumber(4)
  set trip(TripDescriptor value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTrip() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrip() => $_clearField(4);
  @$pb.TagNumber(4)
  TripDescriptor ensureTrip() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get stopId => $_getSZ(4);
  @$pb.TagNumber(5)
  set stopId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasStopId() => $_has(4);
  @$pb.TagNumber(5)
  void clearStopId() => $_clearField(5);

  /// Corresponds to trip direction_id in GTFS trips.txt. If provided the
  /// route_id must also be provided.
  @$pb.TagNumber(6)
  $core.int get directionId => $_getIZ(5);
  @$pb.TagNumber(6)
  set directionId($core.int value) => $_setUnsignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasDirectionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirectionId() => $_clearField(6);
}

class TranslatedString_Translation extends $pb.GeneratedMessage {
  factory TranslatedString_Translation({
    $core.String? text,
    $core.String? language,
  }) {
    final result = create();
    if (text != null) result.text = text;
    if (language != null) result.language = language;
    return result;
  }

  TranslatedString_Translation._();

  factory TranslatedString_Translation.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TranslatedString_Translation.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslatedString.Translation',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'text')
    ..aOS(2, _omitFieldNames ? '' : 'language')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedString_Translation clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedString_Translation copyWith(
          void Function(TranslatedString_Translation) updates) =>
      super.copyWith(
              (message) => updates(message as TranslatedString_Translation))
          as TranslatedString_Translation;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedString_Translation create() =>
      TranslatedString_Translation._();
  @$core.override
  TranslatedString_Translation createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TranslatedString_Translation getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslatedString_Translation>(create);
  static TranslatedString_Translation? _defaultInstance;

  /// A UTF-8 string containing the message.
  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  /// BCP-47 language code. Can be omitted if the language is unknown or if
  /// no i18n is done at all for the feed. At most one translation is
  /// allowed to have an unspecified language tag.
  @$pb.TagNumber(2)
  $core.String get language => $_getSZ(1);
  @$pb.TagNumber(2)
  set language($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLanguage() => $_has(1);
  @$pb.TagNumber(2)
  void clearLanguage() => $_clearField(2);
}

/// An internationalized message containing per-language versions of a snippet of
/// text or a URL.
/// One of the strings from a message will be picked up. The resolution proceeds
/// as follows:
/// 1. If the UI language matches the language code of a translation,
///    the first matching translation is picked.
/// 2. If a default UI language (e.g., English) matches the language code of a
///    translation, the first matching translation is picked.
/// 3. If some translation has an unspecified language code, that translation is
///    picked.
class TranslatedString extends $pb.GeneratedMessage {
  factory TranslatedString({
    $core.Iterable<TranslatedString_Translation>? translation,
  }) {
    final result = create();
    if (translation != null) result.translation.addAll(translation);
    return result;
  }

  TranslatedString._();

  factory TranslatedString.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TranslatedString.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslatedString',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..pPM<TranslatedString_Translation>(1, _omitFieldNames ? '' : 'translation',
        subBuilder: TranslatedString_Translation.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedString clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedString copyWith(void Function(TranslatedString) updates) =>
      super.copyWith((message) => updates(message as TranslatedString))
          as TranslatedString;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedString create() => TranslatedString._();
  @$core.override
  TranslatedString createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TranslatedString getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslatedString>(create);
  static TranslatedString? _defaultInstance;

  /// At least one translation must be provided.
  @$pb.TagNumber(1)
  $pb.PbList<TranslatedString_Translation> get translation => $_getList(0);
}

class TranslatedImage_LocalizedImage extends $pb.GeneratedMessage {
  factory TranslatedImage_LocalizedImage({
    $core.String? url,
    $core.String? mediaType,
    $core.String? language,
  }) {
    final result = create();
    if (url != null) result.url = url;
    if (mediaType != null) result.mediaType = mediaType;
    if (language != null) result.language = language;
    return result;
  }

  TranslatedImage_LocalizedImage._();

  factory TranslatedImage_LocalizedImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TranslatedImage_LocalizedImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslatedImage.LocalizedImage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'url')
    ..aQS(2, _omitFieldNames ? '' : 'mediaType')
    ..aOS(3, _omitFieldNames ? '' : 'language')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedImage_LocalizedImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedImage_LocalizedImage copyWith(
          void Function(TranslatedImage_LocalizedImage) updates) =>
      super.copyWith(
              (message) => updates(message as TranslatedImage_LocalizedImage))
          as TranslatedImage_LocalizedImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedImage_LocalizedImage create() =>
      TranslatedImage_LocalizedImage._();
  @$core.override
  TranslatedImage_LocalizedImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TranslatedImage_LocalizedImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslatedImage_LocalizedImage>(create);
  static TranslatedImage_LocalizedImage? _defaultInstance;

  /// String containing an URL linking to an image
  /// The image linked must be less than 2MB.
  /// If an image changes in a significant enough way that an update is required on the consumer side, the producer must update the URL to a new one.
  /// The URL should be a fully qualified URL that includes http:// or https://, and any special characters in the URL must be correctly escaped. See the following http://www.w3.org/Addressing/URL/4_URI_Recommentations.html for a description of how to create fully qualified URL values.
  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  /// IANA media type as to specify the type of image to be displayed.
  /// The type must start with "image/"
  @$pb.TagNumber(2)
  $core.String get mediaType => $_getSZ(1);
  @$pb.TagNumber(2)
  set mediaType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaType() => $_clearField(2);

  /// BCP-47 language code. Can be omitted if the language is unknown or if
  /// no i18n is done at all for the feed. At most one translation is
  /// allowed to have an unspecified language tag.
  @$pb.TagNumber(3)
  $core.String get language => $_getSZ(2);
  @$pb.TagNumber(3)
  set language($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLanguage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLanguage() => $_clearField(3);
}

/// An internationalized image containing per-language versions of a URL linking to an image
/// along with meta information
/// Only one of the images from a message will be retained by consumers. The resolution proceeds
/// as follows:
/// 1. If the UI language matches the language code of a translation,
///    the first matching translation is picked.
/// 2. If a default UI language (e.g., English) matches the language code of a
///    translation, the first matching translation is picked.
/// 3. If some translation has an unspecified language code, that translation is
///    picked.
/// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
class TranslatedImage extends $pb.GeneratedMessage {
  factory TranslatedImage({
    $core.Iterable<TranslatedImage_LocalizedImage>? localizedImage,
  }) {
    final result = create();
    if (localizedImage != null) result.localizedImage.addAll(localizedImage);
    return result;
  }

  TranslatedImage._();

  factory TranslatedImage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TranslatedImage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TranslatedImage',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..pPM<TranslatedImage_LocalizedImage>(
        1, _omitFieldNames ? '' : 'localizedImage',
        subBuilder: TranslatedImage_LocalizedImage.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedImage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TranslatedImage copyWith(void Function(TranslatedImage) updates) =>
      super.copyWith((message) => updates(message as TranslatedImage))
          as TranslatedImage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedImage create() => TranslatedImage._();
  @$core.override
  TranslatedImage createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TranslatedImage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TranslatedImage>(create);
  static TranslatedImage? _defaultInstance;

  /// At least one localized image must be provided.
  @$pb.TagNumber(1)
  $pb.PbList<TranslatedImage_LocalizedImage> get localizedImage => $_getList(0);
}

/// Describes the physical path that a vehicle takes when it's not part of the (CSV) GTFS,
/// such as for a detour. Shapes belong to Trips, and consist of a sequence of shape points.
/// Tracing the points in order provides the path of the vehicle.  Shapes do not need to intercept
/// the location of Stops exactly, but all Stops on a trip should lie within a small distance of
/// the shape for that trip, i.e. close to straight line segments connecting the shape points
/// NOTE: This message is still experimental, and subject to change. It may be formally adopted in the future.
class Shape extends $pb.GeneratedMessage {
  factory Shape({
    $core.String? shapeId,
    $core.String? encodedPolyline,
  }) {
    final result = create();
    if (shapeId != null) result.shapeId = shapeId;
    if (encodedPolyline != null) result.encodedPolyline = encodedPolyline;
    return result;
  }

  Shape._();

  factory Shape.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Shape.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Shape',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shapeId')
    ..aOS(2, _omitFieldNames ? '' : 'encodedPolyline')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Shape clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Shape copyWith(void Function(Shape) updates) =>
      super.copyWith((message) => updates(message as Shape)) as Shape;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Shape create() => Shape._();
  @$core.override
  Shape createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Shape getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shape>(create);
  static Shape? _defaultInstance;

  /// Identifier of the shape. Must be different than any shape_id defined in the (CSV) GTFS.
  /// This field is required as per reference.md, but needs to be specified here optional because "Required is Forever"
  /// See https://developers.google.com/protocol-buffers/docs/proto#specifying_field_rules
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(1)
  $core.String get shapeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set shapeId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasShapeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeId() => $_clearField(1);

  /// Encoded polyline representation of the shape. This polyline must contain at least two points and represent the full shape of the trip where it's used.
  /// For more information about encoded polylines, see https://developers.google.com/maps/documentation/utilities/polylinealgorithm
  /// This field is required as per reference.md, but needs to be specified here optional because "Required is Forever"
  /// See https://developers.google.com/protocol-buffers/docs/proto#specifying_field_rules
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get encodedPolyline => $_getSZ(1);
  @$pb.TagNumber(2)
  set encodedPolyline($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEncodedPolyline() => $_has(1);
  @$pb.TagNumber(2)
  void clearEncodedPolyline() => $_clearField(2);
}

/// Describes a stop which is served by trips. All fields are as described in the GTFS-Static specification.
/// NOTE: This message is still experimental, and subject to change. It may be formally adopted in the future.
class Stop extends $pb.GeneratedMessage {
  factory Stop({
    $core.String? stopId,
    TranslatedString? stopCode,
    TranslatedString? stopName,
    TranslatedString? ttsStopName,
    TranslatedString? stopDesc,
    $core.double? stopLat,
    $core.double? stopLon,
    $core.String? zoneId,
    TranslatedString? stopUrl,
    $core.String? parentStation,
    $core.String? stopTimezone,
    Stop_WheelchairBoarding? wheelchairBoarding,
    $core.String? levelId,
    TranslatedString? platformCode,
  }) {
    final result = create();
    if (stopId != null) result.stopId = stopId;
    if (stopCode != null) result.stopCode = stopCode;
    if (stopName != null) result.stopName = stopName;
    if (ttsStopName != null) result.ttsStopName = ttsStopName;
    if (stopDesc != null) result.stopDesc = stopDesc;
    if (stopLat != null) result.stopLat = stopLat;
    if (stopLon != null) result.stopLon = stopLon;
    if (zoneId != null) result.zoneId = zoneId;
    if (stopUrl != null) result.stopUrl = stopUrl;
    if (parentStation != null) result.parentStation = parentStation;
    if (stopTimezone != null) result.stopTimezone = stopTimezone;
    if (wheelchairBoarding != null)
      result.wheelchairBoarding = wheelchairBoarding;
    if (levelId != null) result.levelId = levelId;
    if (platformCode != null) result.platformCode = platformCode;
    return result;
  }

  Stop._();

  factory Stop.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Stop.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Stop',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'stopId')
    ..aOM<TranslatedString>(2, _omitFieldNames ? '' : 'stopCode',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(3, _omitFieldNames ? '' : 'stopName',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(4, _omitFieldNames ? '' : 'ttsStopName',
        subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(5, _omitFieldNames ? '' : 'stopDesc',
        subBuilder: TranslatedString.create)
    ..aD(6, _omitFieldNames ? '' : 'stopLat', fieldType: $pb.PbFieldType.OF)
    ..aD(7, _omitFieldNames ? '' : 'stopLon', fieldType: $pb.PbFieldType.OF)
    ..aOS(8, _omitFieldNames ? '' : 'zoneId')
    ..aOM<TranslatedString>(9, _omitFieldNames ? '' : 'stopUrl',
        subBuilder: TranslatedString.create)
    ..aOS(11, _omitFieldNames ? '' : 'parentStation')
    ..aOS(12, _omitFieldNames ? '' : 'stopTimezone')
    ..aE<Stop_WheelchairBoarding>(
        13, _omitFieldNames ? '' : 'wheelchairBoarding',
        defaultOrMaker: Stop_WheelchairBoarding.UNKNOWN,
        enumValues: Stop_WheelchairBoarding.values)
    ..aOS(14, _omitFieldNames ? '' : 'levelId')
    ..aOM<TranslatedString>(15, _omitFieldNames ? '' : 'platformCode',
        subBuilder: TranslatedString.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Stop clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Stop copyWith(void Function(Stop) updates) =>
      super.copyWith((message) => updates(message as Stop)) as Stop;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Stop create() => Stop._();
  @$core.override
  Stop createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Stop getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Stop>(create);
  static Stop? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get stopId => $_getSZ(0);
  @$pb.TagNumber(1)
  set stopId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearStopId() => $_clearField(1);

  @$pb.TagNumber(2)
  TranslatedString get stopCode => $_getN(1);
  @$pb.TagNumber(2)
  set stopCode(TranslatedString value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStopCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopCode() => $_clearField(2);
  @$pb.TagNumber(2)
  TranslatedString ensureStopCode() => $_ensure(1);

  @$pb.TagNumber(3)
  TranslatedString get stopName => $_getN(2);
  @$pb.TagNumber(3)
  set stopName(TranslatedString value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasStopName() => $_has(2);
  @$pb.TagNumber(3)
  void clearStopName() => $_clearField(3);
  @$pb.TagNumber(3)
  TranslatedString ensureStopName() => $_ensure(2);

  @$pb.TagNumber(4)
  TranslatedString get ttsStopName => $_getN(3);
  @$pb.TagNumber(4)
  set ttsStopName(TranslatedString value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasTtsStopName() => $_has(3);
  @$pb.TagNumber(4)
  void clearTtsStopName() => $_clearField(4);
  @$pb.TagNumber(4)
  TranslatedString ensureTtsStopName() => $_ensure(3);

  @$pb.TagNumber(5)
  TranslatedString get stopDesc => $_getN(4);
  @$pb.TagNumber(5)
  set stopDesc(TranslatedString value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasStopDesc() => $_has(4);
  @$pb.TagNumber(5)
  void clearStopDesc() => $_clearField(5);
  @$pb.TagNumber(5)
  TranslatedString ensureStopDesc() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.double get stopLat => $_getN(5);
  @$pb.TagNumber(6)
  set stopLat($core.double value) => $_setFloat(5, value);
  @$pb.TagNumber(6)
  $core.bool hasStopLat() => $_has(5);
  @$pb.TagNumber(6)
  void clearStopLat() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.double get stopLon => $_getN(6);
  @$pb.TagNumber(7)
  set stopLon($core.double value) => $_setFloat(6, value);
  @$pb.TagNumber(7)
  $core.bool hasStopLon() => $_has(6);
  @$pb.TagNumber(7)
  void clearStopLon() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get zoneId => $_getSZ(7);
  @$pb.TagNumber(8)
  set zoneId($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasZoneId() => $_has(7);
  @$pb.TagNumber(8)
  void clearZoneId() => $_clearField(8);

  @$pb.TagNumber(9)
  TranslatedString get stopUrl => $_getN(8);
  @$pb.TagNumber(9)
  set stopUrl(TranslatedString value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasStopUrl() => $_has(8);
  @$pb.TagNumber(9)
  void clearStopUrl() => $_clearField(9);
  @$pb.TagNumber(9)
  TranslatedString ensureStopUrl() => $_ensure(8);

  @$pb.TagNumber(11)
  $core.String get parentStation => $_getSZ(9);
  @$pb.TagNumber(11)
  set parentStation($core.String value) => $_setString(9, value);
  @$pb.TagNumber(11)
  $core.bool hasParentStation() => $_has(9);
  @$pb.TagNumber(11)
  void clearParentStation() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get stopTimezone => $_getSZ(10);
  @$pb.TagNumber(12)
  set stopTimezone($core.String value) => $_setString(10, value);
  @$pb.TagNumber(12)
  $core.bool hasStopTimezone() => $_has(10);
  @$pb.TagNumber(12)
  void clearStopTimezone() => $_clearField(12);

  @$pb.TagNumber(13)
  Stop_WheelchairBoarding get wheelchairBoarding => $_getN(11);
  @$pb.TagNumber(13)
  set wheelchairBoarding(Stop_WheelchairBoarding value) =>
      $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasWheelchairBoarding() => $_has(11);
  @$pb.TagNumber(13)
  void clearWheelchairBoarding() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get levelId => $_getSZ(12);
  @$pb.TagNumber(14)
  set levelId($core.String value) => $_setString(12, value);
  @$pb.TagNumber(14)
  $core.bool hasLevelId() => $_has(12);
  @$pb.TagNumber(14)
  void clearLevelId() => $_clearField(14);

  @$pb.TagNumber(15)
  TranslatedString get platformCode => $_getN(13);
  @$pb.TagNumber(15)
  set platformCode(TranslatedString value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasPlatformCode() => $_has(13);
  @$pb.TagNumber(15)
  void clearPlatformCode() => $_clearField(15);
  @$pb.TagNumber(15)
  TranslatedString ensurePlatformCode() => $_ensure(13);
}

/// A `Modification` message replaces a span of n stop times from each affected trip starting at `start_stop_selector`.
class TripModifications_Modification extends $pb.GeneratedMessage {
  factory TripModifications_Modification({
    StopSelector? startStopSelector,
    StopSelector? endStopSelector,
    $core.int? propagatedModificationDelay,
    $core.Iterable<ReplacementStop>? replacementStops,
    $core.String? serviceAlertId,
    $fixnum.Int64? lastModifiedTime,
  }) {
    final result = create();
    if (startStopSelector != null) result.startStopSelector = startStopSelector;
    if (endStopSelector != null) result.endStopSelector = endStopSelector;
    if (propagatedModificationDelay != null)
      result.propagatedModificationDelay = propagatedModificationDelay;
    if (replacementStops != null)
      result.replacementStops.addAll(replacementStops);
    if (serviceAlertId != null) result.serviceAlertId = serviceAlertId;
    if (lastModifiedTime != null) result.lastModifiedTime = lastModifiedTime;
    return result;
  }

  TripModifications_Modification._();

  factory TripModifications_Modification.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripModifications_Modification.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripModifications.Modification',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aOM<StopSelector>(1, _omitFieldNames ? '' : 'startStopSelector',
        subBuilder: StopSelector.create)
    ..aOM<StopSelector>(2, _omitFieldNames ? '' : 'endStopSelector',
        subBuilder: StopSelector.create)
    ..aI(3, _omitFieldNames ? '' : 'propagatedModificationDelay')
    ..pPM<ReplacementStop>(4, _omitFieldNames ? '' : 'replacementStops',
        subBuilder: ReplacementStop.create)
    ..aOS(5, _omitFieldNames ? '' : 'serviceAlertId')
    ..a<$fixnum.Int64>(
        6, _omitFieldNames ? '' : 'lastModifiedTime', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications_Modification clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications_Modification copyWith(
          void Function(TripModifications_Modification) updates) =>
      super.copyWith(
              (message) => updates(message as TripModifications_Modification))
          as TripModifications_Modification;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripModifications_Modification create() =>
      TripModifications_Modification._();
  @$core.override
  TripModifications_Modification createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripModifications_Modification getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripModifications_Modification>(create);
  static TripModifications_Modification? _defaultInstance;

  /// The stop selector of the first stop_time of the original trip that is to be affected by this modification.
  /// Used in conjuction with `end_stop_selector`.
  /// `start_stop_selector` is required and is used to define the reference stop used with `travel_time_to_stop`.
  @$pb.TagNumber(1)
  StopSelector get startStopSelector => $_getN(0);
  @$pb.TagNumber(1)
  set startStopSelector(StopSelector value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasStartStopSelector() => $_has(0);
  @$pb.TagNumber(1)
  void clearStartStopSelector() => $_clearField(1);
  @$pb.TagNumber(1)
  StopSelector ensureStartStopSelector() => $_ensure(0);

  /// The stop selector of the last stop of the original trip that is to be affected by this modification.
  /// The selection is inclusive, so if only one stop_time is replaced by that modification, `start_stop_selector` and `end_stop_selector` must be equivalent.
  /// If no stop_time is replaced, `end_stop_selector` must not be provided. It's otherwise required.
  @$pb.TagNumber(2)
  StopSelector get endStopSelector => $_getN(1);
  @$pb.TagNumber(2)
  set endStopSelector(StopSelector value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasEndStopSelector() => $_has(1);
  @$pb.TagNumber(2)
  void clearEndStopSelector() => $_clearField(2);
  @$pb.TagNumber(2)
  StopSelector ensureEndStopSelector() => $_ensure(1);

  /// The number of seconds of delay to add to all departure and arrival times following the end of this modification.
  /// If multiple modifications apply to the same trip, the delays accumulate as the trip advances.
  @$pb.TagNumber(3)
  $core.int get propagatedModificationDelay => $_getIZ(2);
  @$pb.TagNumber(3)
  set propagatedModificationDelay($core.int value) =>
      $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPropagatedModificationDelay() => $_has(2);
  @$pb.TagNumber(3)
  void clearPropagatedModificationDelay() => $_clearField(3);

  /// A list of replacement stops, replacing those of the original trip.
  /// The length of the new stop times may be less, the same, or greater than the number of replaced stop times.
  @$pb.TagNumber(4)
  $pb.PbList<ReplacementStop> get replacementStops => $_getList(3);

  /// An `id` value from the `FeedEntity` message that contains the `Alert` describing this Modification for user-facing communication.
  @$pb.TagNumber(5)
  $core.String get serviceAlertId => $_getSZ(4);
  @$pb.TagNumber(5)
  set serviceAlertId($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasServiceAlertId() => $_has(4);
  @$pb.TagNumber(5)
  void clearServiceAlertId() => $_clearField(5);

  /// This timestamp identifies the moment when the modification has last been changed.
  /// In POSIX time (i.e., number of seconds since January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(6)
  $fixnum.Int64 get lastModifiedTime => $_getI64(5);
  @$pb.TagNumber(6)
  set lastModifiedTime($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLastModifiedTime() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastModifiedTime() => $_clearField(6);
}

class TripModifications_SelectedTrips extends $pb.GeneratedMessage {
  factory TripModifications_SelectedTrips({
    $core.Iterable<$core.String>? tripIds,
    $core.String? shapeId,
  }) {
    final result = create();
    if (tripIds != null) result.tripIds.addAll(tripIds);
    if (shapeId != null) result.shapeId = shapeId;
    return result;
  }

  TripModifications_SelectedTrips._();

  factory TripModifications_SelectedTrips.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripModifications_SelectedTrips.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripModifications.SelectedTrips',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'tripIds')
    ..aOS(2, _omitFieldNames ? '' : 'shapeId')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications_SelectedTrips clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications_SelectedTrips copyWith(
          void Function(TripModifications_SelectedTrips) updates) =>
      super.copyWith(
              (message) => updates(message as TripModifications_SelectedTrips))
          as TripModifications_SelectedTrips;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripModifications_SelectedTrips create() =>
      TripModifications_SelectedTrips._();
  @$core.override
  TripModifications_SelectedTrips createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripModifications_SelectedTrips getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripModifications_SelectedTrips>(
          create);
  static TripModifications_SelectedTrips? _defaultInstance;

  /// A list of trips affected with this replacement that all have the same new `shape_id`. A `TripUpdate` with `schedule_relationship=REPLACEMENT` must not already exist for the trip.
  @$pb.TagNumber(1)
  $pb.PbList<$core.String> get tripIds => $_getList(0);

  /// The ID of the new shape for the modified trips in this SelectedTrips.
  /// May refer to a new shape added using a `Shape` message in the same GTFS-RT feed, or to an existing shape defined in the GTFS-Static feed’s shapes.txt.
  /// If it refers to a `Shape` entity in the real-time feed, the value of this field should be the one of the `shape_id` inside the entity, and _not_ the `id` of `FeedEntity`.
  @$pb.TagNumber(2)
  $core.String get shapeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set shapeId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasShapeId() => $_has(1);
  @$pb.TagNumber(2)
  void clearShapeId() => $_clearField(2);
}

/// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
class TripModifications extends $pb.GeneratedMessage {
  factory TripModifications({
    $core.Iterable<TripModifications_SelectedTrips>? selectedTrips,
    $core.Iterable<$core.String>? startTimes,
    $core.Iterable<$core.String>? serviceDates,
    $core.Iterable<TripModifications_Modification>? modifications,
  }) {
    final result = create();
    if (selectedTrips != null) result.selectedTrips.addAll(selectedTrips);
    if (startTimes != null) result.startTimes.addAll(startTimes);
    if (serviceDates != null) result.serviceDates.addAll(serviceDates);
    if (modifications != null) result.modifications.addAll(modifications);
    return result;
  }

  TripModifications._();

  factory TripModifications.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory TripModifications.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TripModifications',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..pPM<TripModifications_SelectedTrips>(
        1, _omitFieldNames ? '' : 'selectedTrips',
        subBuilder: TripModifications_SelectedTrips.create)
    ..pPS(2, _omitFieldNames ? '' : 'startTimes')
    ..pPS(3, _omitFieldNames ? '' : 'serviceDates')
    ..pPM<TripModifications_Modification>(
        4, _omitFieldNames ? '' : 'modifications',
        subBuilder: TripModifications_Modification.create)
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TripModifications copyWith(void Function(TripModifications) updates) =>
      super.copyWith((message) => updates(message as TripModifications))
          as TripModifications;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripModifications create() => TripModifications._();
  @$core.override
  TripModifications createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static TripModifications getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TripModifications>(create);
  static TripModifications? _defaultInstance;

  /// A list of selected trips affected by this TripModifications.
  @$pb.TagNumber(1)
  $pb.PbList<TripModifications_SelectedTrips> get selectedTrips => $_getList(0);

  /// A list of start times in the real-time trip descriptor for the trip_id defined in trip_ids.
  /// Useful to target multiple departures of a trip_id in a frequency-based trip.
  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get startTimes => $_getList(1);

  /// Dates on which the modifications occurs, in the YYYYMMDD format. Producers SHOULD only transmit detours occurring within the next week.
  /// The dates provided should not be used as user-facing information, if a user-facing start and end date needs to be provided, they can be provided in the linked service alert with `service_alert_id`
  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get serviceDates => $_getList(2);

  /// A list of modifications to apply to the affected trips.
  @$pb.TagNumber(4)
  $pb.PbList<TripModifications_Modification> get modifications => $_getList(3);
}

/// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
/// Select a stop by stop sequence or by stop_id. At least one of the two values must be provided.
class StopSelector extends $pb.GeneratedMessage {
  factory StopSelector({
    $core.int? stopSequence,
    $core.String? stopId,
  }) {
    final result = create();
    if (stopSequence != null) result.stopSequence = stopSequence;
    if (stopId != null) result.stopId = stopId;
    return result;
  }

  StopSelector._();

  factory StopSelector.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StopSelector.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StopSelector',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'stopSequence',
        fieldType: $pb.PbFieldType.OU3)
    ..aOS(2, _omitFieldNames ? '' : 'stopId')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StopSelector clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StopSelector copyWith(void Function(StopSelector) updates) =>
      super.copyWith((message) => updates(message as StopSelector))
          as StopSelector;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StopSelector create() => StopSelector._();
  @$core.override
  StopSelector createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StopSelector getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StopSelector>(create);
  static StopSelector? _defaultInstance;

  /// Must be the same as in stop_times.txt in the corresponding GTFS feed.
  @$pb.TagNumber(1)
  $core.int get stopSequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set stopSequence($core.int value) => $_setUnsignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStopSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearStopSequence() => $_clearField(1);

  /// Must be the same as in stops.txt in the corresponding GTFS feed.
  @$pb.TagNumber(2)
  $core.String get stopId => $_getSZ(1);
  @$pb.TagNumber(2)
  set stopId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStopId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopId() => $_clearField(2);
}

/// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
class ReplacementStop extends $pb.GeneratedMessage {
  factory ReplacementStop({
    $core.int? travelTimeToStop,
    $core.String? stopId,
  }) {
    final result = create();
    if (travelTimeToStop != null) result.travelTimeToStop = travelTimeToStop;
    if (stopId != null) result.stopId = stopId;
    return result;
  }

  ReplacementStop._();

  factory ReplacementStop.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ReplacementStop.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReplacementStop',
      package:
          const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'travelTimeToStop')
    ..aOS(2, _omitFieldNames ? '' : 'stopId')
    ..hasExtensions = true;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplacementStop clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReplacementStop copyWith(void Function(ReplacementStop) updates) =>
      super.copyWith((message) => updates(message as ReplacementStop))
          as ReplacementStop;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ReplacementStop create() => ReplacementStop._();
  @$core.override
  ReplacementStop createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ReplacementStop getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReplacementStop>(create);
  static ReplacementStop? _defaultInstance;

  /// The difference in seconds between the arrival time at this stop and the arrival time at the reference stop. The reference stop is the stop prior to start_stop_selector. If the modification begins at the first stop of the trip, then the first stop of the trip is the reference stop.
  /// This value MUST be monotonically increasing and may only be a negative number if the first stop of the original trip is the reference stop.
  @$pb.TagNumber(1)
  $core.int get travelTimeToStop => $_getIZ(0);
  @$pb.TagNumber(1)
  set travelTimeToStop($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTravelTimeToStop() => $_has(0);
  @$pb.TagNumber(1)
  void clearTravelTimeToStop() => $_clearField(1);

  /// The replacement stop ID which will now be visited by the trip. May refer to a new stop added using a GTFS-RT `Stop` message in the same GTFS-RT feed, or to an existing stop defined in the (CSV) GTFS feed’s `stops.txt`.
  /// If it refers to a `Shape` entity in the real-time feed, the value of this field should be the one of the `stop_id` inside the entity, and _not_ the `id` of `FeedEntity`. The replacement stop MUST have `location_type=0` (routable stops).
  @$pb.TagNumber(2)
  $core.String get stopId => $_getSZ(1);
  @$pb.TagNumber(2)
  set stopId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasStopId() => $_has(1);
  @$pb.TagNumber(2)
  void clearStopId() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
