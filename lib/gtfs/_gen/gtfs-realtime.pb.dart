//
//  Generated code. Do not modify.
//  source: gtfs-realtime.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'gtfs-realtime.pbenum.dart';

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
    final $result = create();
    if (header != null) {
      $result.header = header;
    }
    if (entity != null) {
      $result.entity.addAll(entity);
    }
    return $result;
  }
  FeedMessage._() : super();
  factory FeedMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeedMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeedMessage', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQM<FeedHeader>(1, _omitFieldNames ? '' : 'header', subBuilder: FeedHeader.create)
    ..pc<FeedEntity>(2, _omitFieldNames ? '' : 'entity', $pb.PbFieldType.PM, subBuilder: FeedEntity.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeedMessage clone() => FeedMessage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeedMessage copyWith(void Function(FeedMessage) updates) => super.copyWith((message) => updates(message as FeedMessage)) as FeedMessage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedMessage create() => FeedMessage._();
  FeedMessage createEmptyInstance() => create();
  static $pb.PbList<FeedMessage> createRepeated() => $pb.PbList<FeedMessage>();
  @$core.pragma('dart2js:noInline')
  static FeedMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeedMessage>(create);
  static FeedMessage? _defaultInstance;

  /// Metadata about this feed and feed message.
  @$pb.TagNumber(1)
  FeedHeader get header => $_getN(0);
  @$pb.TagNumber(1)
  set header(FeedHeader v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasHeader() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeader() => clearField(1);
  @$pb.TagNumber(1)
  FeedHeader ensureHeader() => $_ensure(0);

  /// Contents of the feed.
  @$pb.TagNumber(2)
  $core.List<FeedEntity> get entity => $_getList(1);
}

/// Metadata about a feed, included in feed messages.
class FeedHeader extends $pb.GeneratedMessage {
  factory FeedHeader({
    $core.String? gtfsRealtimeVersion,
    FeedHeader_Incrementality? incrementality,
    $fixnum.Int64? timestamp,
  }) {
    final $result = create();
    if (gtfsRealtimeVersion != null) {
      $result.gtfsRealtimeVersion = gtfsRealtimeVersion;
    }
    if (incrementality != null) {
      $result.incrementality = incrementality;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    return $result;
  }
  FeedHeader._() : super();
  factory FeedHeader.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeedHeader.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeedHeader', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'gtfsRealtimeVersion')
    ..e<FeedHeader_Incrementality>(2, _omitFieldNames ? '' : 'incrementality', $pb.PbFieldType.OE, defaultOrMaker: FeedHeader_Incrementality.FULL_DATASET, valueOf: FeedHeader_Incrementality.valueOf, enumValues: FeedHeader_Incrementality.values)
    ..a<$fixnum.Int64>(3, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeedHeader clone() => FeedHeader()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeedHeader copyWith(void Function(FeedHeader) updates) => super.copyWith((message) => updates(message as FeedHeader)) as FeedHeader;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedHeader create() => FeedHeader._();
  FeedHeader createEmptyInstance() => create();
  static $pb.PbList<FeedHeader> createRepeated() => $pb.PbList<FeedHeader>();
  @$core.pragma('dart2js:noInline')
  static FeedHeader getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeedHeader>(create);
  static FeedHeader? _defaultInstance;

  /// Version of the feed specification.
  /// The current version is 2.0.  Valid versions are "2.0", "1.0".
  @$pb.TagNumber(1)
  $core.String get gtfsRealtimeVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set gtfsRealtimeVersion($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasGtfsRealtimeVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearGtfsRealtimeVersion() => clearField(1);

  @$pb.TagNumber(2)
  FeedHeader_Incrementality get incrementality => $_getN(1);
  @$pb.TagNumber(2)
  set incrementality(FeedHeader_Incrementality v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasIncrementality() => $_has(1);
  @$pb.TagNumber(2)
  void clearIncrementality() => clearField(2);

  /// This timestamp identifies the moment when the content of this feed has been
  /// created (in server time). In POSIX time (i.e., number of seconds since
  /// January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(3)
  $fixnum.Int64 get timestamp => $_getI64(2);
  @$pb.TagNumber(3)
  set timestamp($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimestamp() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimestamp() => clearField(3);
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
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (isDeleted != null) {
      $result.isDeleted = isDeleted;
    }
    if (tripUpdate != null) {
      $result.tripUpdate = tripUpdate;
    }
    if (vehicle != null) {
      $result.vehicle = vehicle;
    }
    if (alert != null) {
      $result.alert = alert;
    }
    if (shape != null) {
      $result.shape = shape;
    }
    return $result;
  }
  FeedEntity._() : super();
  factory FeedEntity.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory FeedEntity.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'FeedEntity', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'id')
    ..aOB(2, _omitFieldNames ? '' : 'isDeleted')
    ..aOM<TripUpdate>(3, _omitFieldNames ? '' : 'tripUpdate', subBuilder: TripUpdate.create)
    ..aOM<VehiclePosition>(4, _omitFieldNames ? '' : 'vehicle', subBuilder: VehiclePosition.create)
    ..aOM<Alert>(5, _omitFieldNames ? '' : 'alert', subBuilder: Alert.create)
    ..aOM<Shape>(6, _omitFieldNames ? '' : 'shape', subBuilder: Shape.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  FeedEntity clone() => FeedEntity()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  FeedEntity copyWith(void Function(FeedEntity) updates) => super.copyWith((message) => updates(message as FeedEntity)) as FeedEntity;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static FeedEntity create() => FeedEntity._();
  FeedEntity createEmptyInstance() => create();
  static $pb.PbList<FeedEntity> createRepeated() => $pb.PbList<FeedEntity>();
  @$core.pragma('dart2js:noInline')
  static FeedEntity getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FeedEntity>(create);
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
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// Whether this entity is to be deleted. Relevant only for incremental
  /// fetches.
  @$pb.TagNumber(2)
  $core.bool get isDeleted => $_getBF(1);
  @$pb.TagNumber(2)
  set isDeleted($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIsDeleted() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsDeleted() => clearField(2);

  /// Data about the entity itself. Exactly one of the following fields must be
  /// present (unless the entity is being deleted).
  @$pb.TagNumber(3)
  TripUpdate get tripUpdate => $_getN(2);
  @$pb.TagNumber(3)
  set tripUpdate(TripUpdate v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasTripUpdate() => $_has(2);
  @$pb.TagNumber(3)
  void clearTripUpdate() => clearField(3);
  @$pb.TagNumber(3)
  TripUpdate ensureTripUpdate() => $_ensure(2);

  @$pb.TagNumber(4)
  VehiclePosition get vehicle => $_getN(3);
  @$pb.TagNumber(4)
  set vehicle(VehiclePosition v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasVehicle() => $_has(3);
  @$pb.TagNumber(4)
  void clearVehicle() => clearField(4);
  @$pb.TagNumber(4)
  VehiclePosition ensureVehicle() => $_ensure(3);

  @$pb.TagNumber(5)
  Alert get alert => $_getN(4);
  @$pb.TagNumber(5)
  set alert(Alert v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasAlert() => $_has(4);
  @$pb.TagNumber(5)
  void clearAlert() => clearField(5);
  @$pb.TagNumber(5)
  Alert ensureAlert() => $_ensure(4);

  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(6)
  Shape get shape => $_getN(5);
  @$pb.TagNumber(6)
  set shape(Shape v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasShape() => $_has(5);
  @$pb.TagNumber(6)
  void clearShape() => clearField(6);
  @$pb.TagNumber(6)
  Shape ensureShape() => $_ensure(5);
}

///  Timing information for a single predicted event (either arrival or
///  departure).
///  Timing consists of delay and/or estimated time, and uncertainty.
///  - delay should be used when the prediction is given relative to some
///    existing schedule in GTFS.
///  - time should be given whether there is a predicted schedule or not. If
///    both time and delay are specified, time will take precedence
///    (although normally, time, if given for a scheduled trip, should be
///    equal to scheduled time in GTFS + delay).
///
///  Uncertainty applies equally to both time and delay.
///  The uncertainty roughly specifies the expected error in true delay (but
///  note, we don't yet define its precise statistical meaning). It's possible
///  for the uncertainty to be 0, for example for trains that are driven under
///  computer timing control.
class TripUpdate_StopTimeEvent extends $pb.GeneratedMessage {
  factory TripUpdate_StopTimeEvent({
    $core.int? delay,
    $fixnum.Int64? time,
    $core.int? uncertainty,
  }) {
    final $result = create();
    if (delay != null) {
      $result.delay = delay;
    }
    if (time != null) {
      $result.time = time;
    }
    if (uncertainty != null) {
      $result.uncertainty = uncertainty;
    }
    return $result;
  }
  TripUpdate_StopTimeEvent._() : super();
  factory TripUpdate_StopTimeEvent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripUpdate_StopTimeEvent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripUpdate.StopTimeEvent', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'delay', $pb.PbFieldType.O3)
    ..aInt64(2, _omitFieldNames ? '' : 'time')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'uncertainty', $pb.PbFieldType.O3)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeEvent clone() => TripUpdate_StopTimeEvent()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeEvent copyWith(void Function(TripUpdate_StopTimeEvent) updates) => super.copyWith((message) => updates(message as TripUpdate_StopTimeEvent)) as TripUpdate_StopTimeEvent;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeEvent create() => TripUpdate_StopTimeEvent._();
  TripUpdate_StopTimeEvent createEmptyInstance() => create();
  static $pb.PbList<TripUpdate_StopTimeEvent> createRepeated() => $pb.PbList<TripUpdate_StopTimeEvent>();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeEvent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripUpdate_StopTimeEvent>(create);
  static TripUpdate_StopTimeEvent? _defaultInstance;

  /// Delay (in seconds) can be positive (meaning that the vehicle is late) or
  /// negative (meaning that the vehicle is ahead of schedule). Delay of 0
  /// means that the vehicle is exactly on time.
  @$pb.TagNumber(1)
  $core.int get delay => $_getIZ(0);
  @$pb.TagNumber(1)
  set delay($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDelay() => $_has(0);
  @$pb.TagNumber(1)
  void clearDelay() => clearField(1);

  /// Event as absolute time.
  /// In Unix time (i.e., number of seconds since January 1st 1970 00:00:00
  /// UTC).
  @$pb.TagNumber(2)
  $fixnum.Int64 get time => $_getI64(1);
  @$pb.TagNumber(2)
  set time($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearTime() => clearField(2);

  /// If uncertainty is omitted, it is interpreted as unknown.
  /// If the prediction is unknown or too uncertain, the delay (or time) field
  /// should be empty. In such case, the uncertainty field is ignored.
  /// To specify a completely certain prediction, set its uncertainty to 0.
  @$pb.TagNumber(3)
  $core.int get uncertainty => $_getIZ(2);
  @$pb.TagNumber(3)
  set uncertainty($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasUncertainty() => $_has(2);
  @$pb.TagNumber(3)
  void clearUncertainty() => clearField(3);
}

/// Provides the updated values for the stop time.
/// NOTE: This message is still experimental, and subject to change. It may be formally adopted in the future.
class TripUpdate_StopTimeUpdate_StopTimeProperties extends $pb.GeneratedMessage {
  factory TripUpdate_StopTimeUpdate_StopTimeProperties({
    $core.String? assignedStopId,
  }) {
    final $result = create();
    if (assignedStopId != null) {
      $result.assignedStopId = assignedStopId;
    }
    return $result;
  }
  TripUpdate_StopTimeUpdate_StopTimeProperties._() : super();
  factory TripUpdate_StopTimeUpdate_StopTimeProperties.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripUpdate_StopTimeUpdate_StopTimeProperties.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripUpdate.StopTimeUpdate.StopTimeProperties', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'assignedStopId')
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeUpdate_StopTimeProperties clone() => TripUpdate_StopTimeUpdate_StopTimeProperties()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeUpdate_StopTimeProperties copyWith(void Function(TripUpdate_StopTimeUpdate_StopTimeProperties) updates) => super.copyWith((message) => updates(message as TripUpdate_StopTimeUpdate_StopTimeProperties)) as TripUpdate_StopTimeUpdate_StopTimeProperties;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate_StopTimeProperties create() => TripUpdate_StopTimeUpdate_StopTimeProperties._();
  TripUpdate_StopTimeUpdate_StopTimeProperties createEmptyInstance() => create();
  static $pb.PbList<TripUpdate_StopTimeUpdate_StopTimeProperties> createRepeated() => $pb.PbList<TripUpdate_StopTimeUpdate_StopTimeProperties>();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate_StopTimeProperties getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripUpdate_StopTimeUpdate_StopTimeProperties>(create);
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
  set assignedStopId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAssignedStopId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAssignedStopId() => clearField(1);
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
    final $result = create();
    if (stopSequence != null) {
      $result.stopSequence = stopSequence;
    }
    if (arrival != null) {
      $result.arrival = arrival;
    }
    if (departure != null) {
      $result.departure = departure;
    }
    if (stopId != null) {
      $result.stopId = stopId;
    }
    if (scheduleRelationship != null) {
      $result.scheduleRelationship = scheduleRelationship;
    }
    if (stopTimeProperties != null) {
      $result.stopTimeProperties = stopTimeProperties;
    }
    if (departureOccupancyStatus != null) {
      $result.departureOccupancyStatus = departureOccupancyStatus;
    }
    return $result;
  }
  TripUpdate_StopTimeUpdate._() : super();
  factory TripUpdate_StopTimeUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripUpdate_StopTimeUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripUpdate.StopTimeUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'stopSequence', $pb.PbFieldType.OU3)
    ..aOM<TripUpdate_StopTimeEvent>(2, _omitFieldNames ? '' : 'arrival', subBuilder: TripUpdate_StopTimeEvent.create)
    ..aOM<TripUpdate_StopTimeEvent>(3, _omitFieldNames ? '' : 'departure', subBuilder: TripUpdate_StopTimeEvent.create)
    ..aOS(4, _omitFieldNames ? '' : 'stopId')
    ..e<TripUpdate_StopTimeUpdate_ScheduleRelationship>(5, _omitFieldNames ? '' : 'scheduleRelationship', $pb.PbFieldType.OE, defaultOrMaker: TripUpdate_StopTimeUpdate_ScheduleRelationship.SCHEDULED, valueOf: TripUpdate_StopTimeUpdate_ScheduleRelationship.valueOf, enumValues: TripUpdate_StopTimeUpdate_ScheduleRelationship.values)
    ..aOM<TripUpdate_StopTimeUpdate_StopTimeProperties>(6, _omitFieldNames ? '' : 'stopTimeProperties', subBuilder: TripUpdate_StopTimeUpdate_StopTimeProperties.create)
    ..e<VehiclePosition_OccupancyStatus>(7, _omitFieldNames ? '' : 'departureOccupancyStatus', $pb.PbFieldType.OE, defaultOrMaker: VehiclePosition_OccupancyStatus.EMPTY, valueOf: VehiclePosition_OccupancyStatus.valueOf, enumValues: VehiclePosition_OccupancyStatus.values)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeUpdate clone() => TripUpdate_StopTimeUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripUpdate_StopTimeUpdate copyWith(void Function(TripUpdate_StopTimeUpdate) updates) => super.copyWith((message) => updates(message as TripUpdate_StopTimeUpdate)) as TripUpdate_StopTimeUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate create() => TripUpdate_StopTimeUpdate._();
  TripUpdate_StopTimeUpdate createEmptyInstance() => create();
  static $pb.PbList<TripUpdate_StopTimeUpdate> createRepeated() => $pb.PbList<TripUpdate_StopTimeUpdate>();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_StopTimeUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripUpdate_StopTimeUpdate>(create);
  static TripUpdate_StopTimeUpdate? _defaultInstance;

  /// Must be the same as in stop_times.txt in the corresponding GTFS feed.
  @$pb.TagNumber(1)
  $core.int get stopSequence => $_getIZ(0);
  @$pb.TagNumber(1)
  set stopSequence($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStopSequence() => $_has(0);
  @$pb.TagNumber(1)
  void clearStopSequence() => clearField(1);

  @$pb.TagNumber(2)
  TripUpdate_StopTimeEvent get arrival => $_getN(1);
  @$pb.TagNumber(2)
  set arrival(TripUpdate_StopTimeEvent v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasArrival() => $_has(1);
  @$pb.TagNumber(2)
  void clearArrival() => clearField(2);
  @$pb.TagNumber(2)
  TripUpdate_StopTimeEvent ensureArrival() => $_ensure(1);

  @$pb.TagNumber(3)
  TripUpdate_StopTimeEvent get departure => $_getN(2);
  @$pb.TagNumber(3)
  set departure(TripUpdate_StopTimeEvent v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasDeparture() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeparture() => clearField(3);
  @$pb.TagNumber(3)
  TripUpdate_StopTimeEvent ensureDeparture() => $_ensure(2);

  /// Must be the same as in stops.txt in the corresponding GTFS feed.
  @$pb.TagNumber(4)
  $core.String get stopId => $_getSZ(3);
  @$pb.TagNumber(4)
  set stopId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasStopId() => $_has(3);
  @$pb.TagNumber(4)
  void clearStopId() => clearField(4);

  @$pb.TagNumber(5)
  TripUpdate_StopTimeUpdate_ScheduleRelationship get scheduleRelationship => $_getN(4);
  @$pb.TagNumber(5)
  set scheduleRelationship(TripUpdate_StopTimeUpdate_ScheduleRelationship v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasScheduleRelationship() => $_has(4);
  @$pb.TagNumber(5)
  void clearScheduleRelationship() => clearField(5);

  /// Realtime updates for certain properties defined within GTFS stop_times.txt
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(6)
  TripUpdate_StopTimeUpdate_StopTimeProperties get stopTimeProperties => $_getN(5);
  @$pb.TagNumber(6)
  set stopTimeProperties(TripUpdate_StopTimeUpdate_StopTimeProperties v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasStopTimeProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearStopTimeProperties() => clearField(6);
  @$pb.TagNumber(6)
  TripUpdate_StopTimeUpdate_StopTimeProperties ensureStopTimeProperties() => $_ensure(5);

  /// Expected occupancy after departure from the given stop.
  /// Should be provided only for future stops.
  /// In order to provide departure_occupancy_status without either arrival or
  /// departure StopTimeEvents, ScheduleRelationship should be set to NO_DATA.
  @$pb.TagNumber(7)
  VehiclePosition_OccupancyStatus get departureOccupancyStatus => $_getN(6);
  @$pb.TagNumber(7)
  set departureOccupancyStatus(VehiclePosition_OccupancyStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasDepartureOccupancyStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearDepartureOccupancyStatus() => clearField(7);
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
  }) {
    final $result = create();
    if (tripId != null) {
      $result.tripId = tripId;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (shapeId != null) {
      $result.shapeId = shapeId;
    }
    return $result;
  }
  TripUpdate_TripProperties._() : super();
  factory TripUpdate_TripProperties.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripUpdate_TripProperties.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripUpdate.TripProperties', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tripId')
    ..aOS(2, _omitFieldNames ? '' : 'startDate')
    ..aOS(3, _omitFieldNames ? '' : 'startTime')
    ..aOS(4, _omitFieldNames ? '' : 'shapeId')
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripUpdate_TripProperties clone() => TripUpdate_TripProperties()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripUpdate_TripProperties copyWith(void Function(TripUpdate_TripProperties) updates) => super.copyWith((message) => updates(message as TripUpdate_TripProperties)) as TripUpdate_TripProperties;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate_TripProperties create() => TripUpdate_TripProperties._();
  TripUpdate_TripProperties createEmptyInstance() => create();
  static $pb.PbList<TripUpdate_TripProperties> createRepeated() => $pb.PbList<TripUpdate_TripProperties>();
  @$core.pragma('dart2js:noInline')
  static TripUpdate_TripProperties getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripUpdate_TripProperties>(create);
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
  set tripId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => clearField(1);

  /// Service date on which the DUPLICATED trip will be run, in YYYYMMDD format. Required if
  /// schedule_relationship=DUPLICATED, otherwise this field must not be populated and will be ignored by consumers.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get startDate => $_getSZ(1);
  @$pb.TagNumber(2)
  set startDate($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartDate() => clearField(2);

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
  set startTime($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartTime() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartTime() => clearField(3);

  /// Specifies the shape of the vehicle travel path when the trip shape differs from the shape specified in
  /// (CSV) GTFS or to specify it in real-time when it's not provided by (CSV) GTFS, such as a vehicle that takes differing
  /// paths based on rider demand. See definition of trips.shape_id in (CSV) GTFS. If a shape is neither defined in (CSV) GTFS
  /// nor in real-time, the shape is considered unknown. This field can refer to a shape defined in the (CSV) GTFS in shapes.txt
  /// or a Shape in the (protobuf) real-time feed. The order of stops (stop sequences) for this trip must remain the same as
  /// (CSV) GTFS. Stops that are a part of the original trip but will no longer be made, such as when a detour occurs, should
  /// be marked as schedule_relationship=SKIPPED.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  $core.String get shapeId => $_getSZ(3);
  @$pb.TagNumber(4)
  set shapeId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasShapeId() => $_has(3);
  @$pb.TagNumber(4)
  void clearShapeId() => clearField(4);
}

///  Realtime update of the progress of a vehicle along a trip.
///  Depending on the value of ScheduleRelationship, a TripUpdate can specify:
///  - A trip that proceeds along the schedule.
///  - A trip that proceeds along a route but has no fixed schedule.
///  - A trip that have been added or removed with regard to schedule.
///
///  The updates can be for future, predicted arrival/departure events, or for
///  past events that already occurred.
///  Normally, updates should get more precise and more certain (see
///  uncertainty below) as the events gets closer to current time.
///  Even if that is not possible, the information for past events should be
///  precise and certain. In particular, if an update points to time in the past
///  but its update's uncertainty is not 0, the client should conclude that the
///  update is a (wrong) prediction and that the trip has not completed yet.
///
///  Note that the update can describe a trip that is already completed.
///  To this end, it is enough to provide an update for the last stop of the trip.
///  If the time of that is in the past, the client will conclude from that that
///  the whole trip is in the past (it is possible, although inconsequential, to
///  also provide updates for preceding stops).
///  This option is most relevant for a trip that has completed ahead of schedule,
///  but according to the schedule, the trip is still proceeding at the current
///  time. Removing the updates for this trip could make the client assume
///  that the trip is still proceeding.
///  Note that the feed provider is allowed, but not required, to purge past
///  updates - this is one case where this would be practically useful.
class TripUpdate extends $pb.GeneratedMessage {
  factory TripUpdate({
    TripDescriptor? trip,
    $core.Iterable<TripUpdate_StopTimeUpdate>? stopTimeUpdate,
    VehicleDescriptor? vehicle,
    $fixnum.Int64? timestamp,
    $core.int? delay,
    TripUpdate_TripProperties? tripProperties,
  }) {
    final $result = create();
    if (trip != null) {
      $result.trip = trip;
    }
    if (stopTimeUpdate != null) {
      $result.stopTimeUpdate.addAll(stopTimeUpdate);
    }
    if (vehicle != null) {
      $result.vehicle = vehicle;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (delay != null) {
      $result.delay = delay;
    }
    if (tripProperties != null) {
      $result.tripProperties = tripProperties;
    }
    return $result;
  }
  TripUpdate._() : super();
  factory TripUpdate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripUpdate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripUpdate', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQM<TripDescriptor>(1, _omitFieldNames ? '' : 'trip', subBuilder: TripDescriptor.create)
    ..pc<TripUpdate_StopTimeUpdate>(2, _omitFieldNames ? '' : 'stopTimeUpdate', $pb.PbFieldType.PM, subBuilder: TripUpdate_StopTimeUpdate.create)
    ..aOM<VehicleDescriptor>(3, _omitFieldNames ? '' : 'vehicle', subBuilder: VehicleDescriptor.create)
    ..a<$fixnum.Int64>(4, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'delay', $pb.PbFieldType.O3)
    ..aOM<TripUpdate_TripProperties>(6, _omitFieldNames ? '' : 'tripProperties', subBuilder: TripUpdate_TripProperties.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripUpdate clone() => TripUpdate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripUpdate copyWith(void Function(TripUpdate) updates) => super.copyWith((message) => updates(message as TripUpdate)) as TripUpdate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripUpdate create() => TripUpdate._();
  TripUpdate createEmptyInstance() => create();
  static $pb.PbList<TripUpdate> createRepeated() => $pb.PbList<TripUpdate>();
  @$core.pragma('dart2js:noInline')
  static TripUpdate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripUpdate>(create);
  static TripUpdate? _defaultInstance;

  /// The Trip that this message applies to. There can be at most one
  /// TripUpdate entity for each actual trip instance.
  /// If there is none, that means there is no prediction information available.
  /// It does *not* mean that the trip is progressing according to schedule.
  @$pb.TagNumber(1)
  TripDescriptor get trip => $_getN(0);
  @$pb.TagNumber(1)
  set trip(TripDescriptor v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTrip() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrip() => clearField(1);
  @$pb.TagNumber(1)
  TripDescriptor ensureTrip() => $_ensure(0);

  ///  Updates to StopTimes for the trip (both future, i.e., predictions, and in
  ///  some cases, past ones, i.e., those that already happened).
  ///  The updates must be sorted by stop_sequence, and apply for all the
  ///  following stops of the trip up to the next specified one.
  ///
  ///  Example 1:
  ///  For a trip with 20 stops, a StopTimeUpdate with arrival delay and departure
  ///  delay of 0 for stop_sequence of the current stop means that the trip is
  ///  exactly on time.
  ///
  ///  Example 2:
  ///  For the same trip instance, 3 StopTimeUpdates are provided:
  ///  - delay of 5 min for stop_sequence 3
  ///  - delay of 1 min for stop_sequence 8
  ///  - delay of unspecified duration for stop_sequence 10
  ///  This will be interpreted as:
  ///  - stop_sequences 3,4,5,6,7 have delay of 5 min.
  ///  - stop_sequences 8,9 have delay of 1 min.
  ///  - stop_sequences 10,... have unknown delay.
  @$pb.TagNumber(2)
  $core.List<TripUpdate_StopTimeUpdate> get stopTimeUpdate => $_getList(1);

  /// Additional information on the vehicle that is serving this trip.
  @$pb.TagNumber(3)
  VehicleDescriptor get vehicle => $_getN(2);
  @$pb.TagNumber(3)
  set vehicle(VehicleDescriptor v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasVehicle() => $_has(2);
  @$pb.TagNumber(3)
  void clearVehicle() => clearField(3);
  @$pb.TagNumber(3)
  VehicleDescriptor ensureVehicle() => $_ensure(2);

  /// The most recent moment at which the vehicle's real-time progress was measured
  /// to estimate StopTimes in the future. When StopTimes in the past are provided,
  /// arrival/departure times may be earlier than this value. In POSIX
  /// time (i.e., the number of seconds since January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(4)
  $fixnum.Int64 get timestamp => $_getI64(3);
  @$pb.TagNumber(4)
  set timestamp($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTimestamp() => $_has(3);
  @$pb.TagNumber(4)
  void clearTimestamp() => clearField(4);

  ///  The current schedule deviation for the trip.  Delay should only be
  ///  specified when the prediction is given relative to some existing schedule
  ///  in GTFS.
  ///
  ///  Delay (in seconds) can be positive (meaning that the vehicle is late) or
  ///  negative (meaning that the vehicle is ahead of schedule). Delay of 0
  ///  means that the vehicle is exactly on time.
  ///
  ///  Delay information in StopTimeUpdates take precedent of trip-level delay
  ///  information, such that trip-level delay is only propagated until the next
  ///  stop along the trip with a StopTimeUpdate delay value specified.
  ///
  ///  Feed providers are strongly encouraged to provide a TripUpdate.timestamp
  ///  value indicating when the delay value was last updated, in order to
  ///  evaluate the freshness of the data.
  ///
  ///  NOTE: This field is still experimental, and subject to change. It may be
  ///  formally adopted in the future.
  @$pb.TagNumber(5)
  $core.int get delay => $_getIZ(4);
  @$pb.TagNumber(5)
  set delay($core.int v) { $_setSignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDelay() => $_has(4);
  @$pb.TagNumber(5)
  void clearDelay() => clearField(5);

  @$pb.TagNumber(6)
  TripUpdate_TripProperties get tripProperties => $_getN(5);
  @$pb.TagNumber(6)
  set tripProperties(TripUpdate_TripProperties v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasTripProperties() => $_has(5);
  @$pb.TagNumber(6)
  void clearTripProperties() => clearField(6);
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
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (label != null) {
      $result.label = label;
    }
    if (occupancyStatus != null) {
      $result.occupancyStatus = occupancyStatus;
    }
    if (occupancyPercentage != null) {
      $result.occupancyPercentage = occupancyPercentage;
    }
    if (carriageSequence != null) {
      $result.carriageSequence = carriageSequence;
    }
    return $result;
  }
  VehiclePosition_CarriageDetails._() : super();
  factory VehiclePosition_CarriageDetails.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VehiclePosition_CarriageDetails.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VehiclePosition.CarriageDetails', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..e<VehiclePosition_OccupancyStatus>(3, _omitFieldNames ? '' : 'occupancyStatus', $pb.PbFieldType.OE, defaultOrMaker: VehiclePosition_OccupancyStatus.NO_DATA_AVAILABLE, valueOf: VehiclePosition_OccupancyStatus.valueOf, enumValues: VehiclePosition_OccupancyStatus.values)
    ..a<$core.int>(4, _omitFieldNames ? '' : 'occupancyPercentage', $pb.PbFieldType.O3, defaultOrMaker: -1)
    ..a<$core.int>(5, _omitFieldNames ? '' : 'carriageSequence', $pb.PbFieldType.OU3)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VehiclePosition_CarriageDetails clone() => VehiclePosition_CarriageDetails()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VehiclePosition_CarriageDetails copyWith(void Function(VehiclePosition_CarriageDetails) updates) => super.copyWith((message) => updates(message as VehiclePosition_CarriageDetails)) as VehiclePosition_CarriageDetails;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehiclePosition_CarriageDetails create() => VehiclePosition_CarriageDetails._();
  VehiclePosition_CarriageDetails createEmptyInstance() => create();
  static $pb.PbList<VehiclePosition_CarriageDetails> createRepeated() => $pb.PbList<VehiclePosition_CarriageDetails>();
  @$core.pragma('dart2js:noInline')
  static VehiclePosition_CarriageDetails getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VehiclePosition_CarriageDetails>(create);
  static VehiclePosition_CarriageDetails? _defaultInstance;

  /// Identification of the carriage. Should be unique per vehicle.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// User visible label that may be shown to the passenger to help identify
  /// the carriage. Example: "7712", "Car ABC-32", etc...
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  /// Occupancy status for this given carriage, in this vehicle
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(3)
  VehiclePosition_OccupancyStatus get occupancyStatus => $_getN(2);
  @$pb.TagNumber(3)
  set occupancyStatus(VehiclePosition_OccupancyStatus v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasOccupancyStatus() => $_has(2);
  @$pb.TagNumber(3)
  void clearOccupancyStatus() => clearField(3);

  /// Occupancy percentage for this given carriage, in this vehicle.
  /// Follows the same rules as "VehiclePosition.occupancy_percentage"
  /// -1 in case data is not available for this given carriage (as protobuf defaults to 0 otherwise)
  /// This message/field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(4)
  $core.int get occupancyPercentage => $_getI(3, -1);
  @$pb.TagNumber(4)
  set occupancyPercentage($core.int v) { $_setSignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOccupancyPercentage() => $_has(3);
  @$pb.TagNumber(4)
  void clearOccupancyPercentage() => clearField(4);

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
  set carriageSequence($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCarriageSequence() => $_has(4);
  @$pb.TagNumber(5)
  void clearCarriageSequence() => clearField(5);
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
    final $result = create();
    if (trip != null) {
      $result.trip = trip;
    }
    if (position != null) {
      $result.position = position;
    }
    if (currentStopSequence != null) {
      $result.currentStopSequence = currentStopSequence;
    }
    if (currentStatus != null) {
      $result.currentStatus = currentStatus;
    }
    if (timestamp != null) {
      $result.timestamp = timestamp;
    }
    if (congestionLevel != null) {
      $result.congestionLevel = congestionLevel;
    }
    if (stopId != null) {
      $result.stopId = stopId;
    }
    if (vehicle != null) {
      $result.vehicle = vehicle;
    }
    if (occupancyStatus != null) {
      $result.occupancyStatus = occupancyStatus;
    }
    if (occupancyPercentage != null) {
      $result.occupancyPercentage = occupancyPercentage;
    }
    if (multiCarriageDetails != null) {
      $result.multiCarriageDetails.addAll(multiCarriageDetails);
    }
    return $result;
  }
  VehiclePosition._() : super();
  factory VehiclePosition.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VehiclePosition.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VehiclePosition', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOM<TripDescriptor>(1, _omitFieldNames ? '' : 'trip', subBuilder: TripDescriptor.create)
    ..aOM<Position>(2, _omitFieldNames ? '' : 'position', subBuilder: Position.create)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'currentStopSequence', $pb.PbFieldType.OU3)
    ..e<VehiclePosition_VehicleStopStatus>(4, _omitFieldNames ? '' : 'currentStatus', $pb.PbFieldType.OE, defaultOrMaker: VehiclePosition_VehicleStopStatus.IN_TRANSIT_TO, valueOf: VehiclePosition_VehicleStopStatus.valueOf, enumValues: VehiclePosition_VehicleStopStatus.values)
    ..a<$fixnum.Int64>(5, _omitFieldNames ? '' : 'timestamp', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<VehiclePosition_CongestionLevel>(6, _omitFieldNames ? '' : 'congestionLevel', $pb.PbFieldType.OE, defaultOrMaker: VehiclePosition_CongestionLevel.UNKNOWN_CONGESTION_LEVEL, valueOf: VehiclePosition_CongestionLevel.valueOf, enumValues: VehiclePosition_CongestionLevel.values)
    ..aOS(7, _omitFieldNames ? '' : 'stopId')
    ..aOM<VehicleDescriptor>(8, _omitFieldNames ? '' : 'vehicle', subBuilder: VehicleDescriptor.create)
    ..e<VehiclePosition_OccupancyStatus>(9, _omitFieldNames ? '' : 'occupancyStatus', $pb.PbFieldType.OE, defaultOrMaker: VehiclePosition_OccupancyStatus.EMPTY, valueOf: VehiclePosition_OccupancyStatus.valueOf, enumValues: VehiclePosition_OccupancyStatus.values)
    ..a<$core.int>(10, _omitFieldNames ? '' : 'occupancyPercentage', $pb.PbFieldType.OU3)
    ..pc<VehiclePosition_CarriageDetails>(11, _omitFieldNames ? '' : 'multiCarriageDetails', $pb.PbFieldType.PM, subBuilder: VehiclePosition_CarriageDetails.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VehiclePosition clone() => VehiclePosition()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VehiclePosition copyWith(void Function(VehiclePosition) updates) => super.copyWith((message) => updates(message as VehiclePosition)) as VehiclePosition;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehiclePosition create() => VehiclePosition._();
  VehiclePosition createEmptyInstance() => create();
  static $pb.PbList<VehiclePosition> createRepeated() => $pb.PbList<VehiclePosition>();
  @$core.pragma('dart2js:noInline')
  static VehiclePosition getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VehiclePosition>(create);
  static VehiclePosition? _defaultInstance;

  /// The Trip that this vehicle is serving.
  /// Can be empty or partial if the vehicle can not be identified with a given
  /// trip instance.
  @$pb.TagNumber(1)
  TripDescriptor get trip => $_getN(0);
  @$pb.TagNumber(1)
  set trip(TripDescriptor v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasTrip() => $_has(0);
  @$pb.TagNumber(1)
  void clearTrip() => clearField(1);
  @$pb.TagNumber(1)
  TripDescriptor ensureTrip() => $_ensure(0);

  /// Current position of this vehicle.
  @$pb.TagNumber(2)
  Position get position => $_getN(1);
  @$pb.TagNumber(2)
  set position(Position v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPosition() => $_has(1);
  @$pb.TagNumber(2)
  void clearPosition() => clearField(2);
  @$pb.TagNumber(2)
  Position ensurePosition() => $_ensure(1);

  /// The stop sequence index of the current stop. The meaning of
  /// current_stop_sequence (i.e., the stop that it refers to) is determined by
  /// current_status.
  /// If current_status is missing IN_TRANSIT_TO is assumed.
  @$pb.TagNumber(3)
  $core.int get currentStopSequence => $_getIZ(2);
  @$pb.TagNumber(3)
  set currentStopSequence($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasCurrentStopSequence() => $_has(2);
  @$pb.TagNumber(3)
  void clearCurrentStopSequence() => clearField(3);

  /// The exact status of the vehicle with respect to the current stop.
  /// Ignored if current_stop_sequence is missing.
  @$pb.TagNumber(4)
  VehiclePosition_VehicleStopStatus get currentStatus => $_getN(3);
  @$pb.TagNumber(4)
  set currentStatus(VehiclePosition_VehicleStopStatus v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasCurrentStatus() => $_has(3);
  @$pb.TagNumber(4)
  void clearCurrentStatus() => clearField(4);

  /// Moment at which the vehicle's position was measured. In POSIX time
  /// (i.e., number of seconds since January 1st 1970 00:00:00 UTC).
  @$pb.TagNumber(5)
  $fixnum.Int64 get timestamp => $_getI64(4);
  @$pb.TagNumber(5)
  set timestamp($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTimestamp() => $_has(4);
  @$pb.TagNumber(5)
  void clearTimestamp() => clearField(5);

  @$pb.TagNumber(6)
  VehiclePosition_CongestionLevel get congestionLevel => $_getN(5);
  @$pb.TagNumber(6)
  set congestionLevel(VehiclePosition_CongestionLevel v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCongestionLevel() => $_has(5);
  @$pb.TagNumber(6)
  void clearCongestionLevel() => clearField(6);

  /// Identifies the current stop. The value must be the same as in stops.txt in
  /// the corresponding GTFS feed.
  @$pb.TagNumber(7)
  $core.String get stopId => $_getSZ(6);
  @$pb.TagNumber(7)
  set stopId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasStopId() => $_has(6);
  @$pb.TagNumber(7)
  void clearStopId() => clearField(7);

  /// Additional information on the vehicle that is serving this trip.
  @$pb.TagNumber(8)
  VehicleDescriptor get vehicle => $_getN(7);
  @$pb.TagNumber(8)
  set vehicle(VehicleDescriptor v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasVehicle() => $_has(7);
  @$pb.TagNumber(8)
  void clearVehicle() => clearField(8);
  @$pb.TagNumber(8)
  VehicleDescriptor ensureVehicle() => $_ensure(7);

  /// If multi_carriage_status is populated with per-carriage OccupancyStatus,
  /// then this field should describe the entire vehicle with all carriages accepting passengers considered.
  @$pb.TagNumber(9)
  VehiclePosition_OccupancyStatus get occupancyStatus => $_getN(8);
  @$pb.TagNumber(9)
  set occupancyStatus(VehiclePosition_OccupancyStatus v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasOccupancyStatus() => $_has(8);
  @$pb.TagNumber(9)
  void clearOccupancyStatus() => clearField(9);

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
  set occupancyPercentage($core.int v) { $_setUnsignedInt32(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasOccupancyPercentage() => $_has(9);
  @$pb.TagNumber(10)
  void clearOccupancyPercentage() => clearField(10);

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
  $core.List<VehiclePosition_CarriageDetails> get multiCarriageDetails => $_getList(10);
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
    final $result = create();
    if (activePeriod != null) {
      $result.activePeriod.addAll(activePeriod);
    }
    if (informedEntity != null) {
      $result.informedEntity.addAll(informedEntity);
    }
    if (cause != null) {
      $result.cause = cause;
    }
    if (effect != null) {
      $result.effect = effect;
    }
    if (url != null) {
      $result.url = url;
    }
    if (headerText != null) {
      $result.headerText = headerText;
    }
    if (descriptionText != null) {
      $result.descriptionText = descriptionText;
    }
    if (ttsHeaderText != null) {
      $result.ttsHeaderText = ttsHeaderText;
    }
    if (ttsDescriptionText != null) {
      $result.ttsDescriptionText = ttsDescriptionText;
    }
    if (severityLevel != null) {
      $result.severityLevel = severityLevel;
    }
    if (image != null) {
      $result.image = image;
    }
    if (imageAlternativeText != null) {
      $result.imageAlternativeText = imageAlternativeText;
    }
    if (causeDetail != null) {
      $result.causeDetail = causeDetail;
    }
    if (effectDetail != null) {
      $result.effectDetail = effectDetail;
    }
    return $result;
  }
  Alert._() : super();
  factory Alert.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Alert.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Alert', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..pc<TimeRange>(1, _omitFieldNames ? '' : 'activePeriod', $pb.PbFieldType.PM, subBuilder: TimeRange.create)
    ..pc<EntitySelector>(5, _omitFieldNames ? '' : 'informedEntity', $pb.PbFieldType.PM, subBuilder: EntitySelector.create)
    ..e<Alert_Cause>(6, _omitFieldNames ? '' : 'cause', $pb.PbFieldType.OE, defaultOrMaker: Alert_Cause.UNKNOWN_CAUSE, valueOf: Alert_Cause.valueOf, enumValues: Alert_Cause.values)
    ..e<Alert_Effect>(7, _omitFieldNames ? '' : 'effect', $pb.PbFieldType.OE, defaultOrMaker: Alert_Effect.UNKNOWN_EFFECT, valueOf: Alert_Effect.valueOf, enumValues: Alert_Effect.values)
    ..aOM<TranslatedString>(8, _omitFieldNames ? '' : 'url', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(10, _omitFieldNames ? '' : 'headerText', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(11, _omitFieldNames ? '' : 'descriptionText', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(12, _omitFieldNames ? '' : 'ttsHeaderText', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(13, _omitFieldNames ? '' : 'ttsDescriptionText', subBuilder: TranslatedString.create)
    ..e<Alert_SeverityLevel>(14, _omitFieldNames ? '' : 'severityLevel', $pb.PbFieldType.OE, defaultOrMaker: Alert_SeverityLevel.UNKNOWN_SEVERITY, valueOf: Alert_SeverityLevel.valueOf, enumValues: Alert_SeverityLevel.values)
    ..aOM<TranslatedImage>(15, _omitFieldNames ? '' : 'image', subBuilder: TranslatedImage.create)
    ..aOM<TranslatedString>(16, _omitFieldNames ? '' : 'imageAlternativeText', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(17, _omitFieldNames ? '' : 'causeDetail', subBuilder: TranslatedString.create)
    ..aOM<TranslatedString>(18, _omitFieldNames ? '' : 'effectDetail', subBuilder: TranslatedString.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Alert clone() => Alert()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Alert copyWith(void Function(Alert) updates) => super.copyWith((message) => updates(message as Alert)) as Alert;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Alert create() => Alert._();
  Alert createEmptyInstance() => create();
  static $pb.PbList<Alert> createRepeated() => $pb.PbList<Alert>();
  @$core.pragma('dart2js:noInline')
  static Alert getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Alert>(create);
  static Alert? _defaultInstance;

  /// Time when the alert should be shown to the user. If missing, the
  /// alert will be shown as long as it appears in the feed.
  /// If multiple ranges are given, the alert will be shown during all of them.
  @$pb.TagNumber(1)
  $core.List<TimeRange> get activePeriod => $_getList(0);

  /// Entities whose users we should notify of this alert.
  @$pb.TagNumber(5)
  $core.List<EntitySelector> get informedEntity => $_getList(1);

  @$pb.TagNumber(6)
  Alert_Cause get cause => $_getN(2);
  @$pb.TagNumber(6)
  set cause(Alert_Cause v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCause() => $_has(2);
  @$pb.TagNumber(6)
  void clearCause() => clearField(6);

  @$pb.TagNumber(7)
  Alert_Effect get effect => $_getN(3);
  @$pb.TagNumber(7)
  set effect(Alert_Effect v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasEffect() => $_has(3);
  @$pb.TagNumber(7)
  void clearEffect() => clearField(7);

  /// The URL which provides additional information about the alert.
  @$pb.TagNumber(8)
  TranslatedString get url => $_getN(4);
  @$pb.TagNumber(8)
  set url(TranslatedString v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasUrl() => $_has(4);
  @$pb.TagNumber(8)
  void clearUrl() => clearField(8);
  @$pb.TagNumber(8)
  TranslatedString ensureUrl() => $_ensure(4);

  /// Alert header. Contains a short summary of the alert text as plain-text.
  @$pb.TagNumber(10)
  TranslatedString get headerText => $_getN(5);
  @$pb.TagNumber(10)
  set headerText(TranslatedString v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasHeaderText() => $_has(5);
  @$pb.TagNumber(10)
  void clearHeaderText() => clearField(10);
  @$pb.TagNumber(10)
  TranslatedString ensureHeaderText() => $_ensure(5);

  /// Full description for the alert as plain-text. The information in the
  /// description should add to the information of the header.
  @$pb.TagNumber(11)
  TranslatedString get descriptionText => $_getN(6);
  @$pb.TagNumber(11)
  set descriptionText(TranslatedString v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasDescriptionText() => $_has(6);
  @$pb.TagNumber(11)
  void clearDescriptionText() => clearField(11);
  @$pb.TagNumber(11)
  TranslatedString ensureDescriptionText() => $_ensure(6);

  /// Text for alert header to be used in text-to-speech implementations. This field is the text-to-speech version of header_text.
  @$pb.TagNumber(12)
  TranslatedString get ttsHeaderText => $_getN(7);
  @$pb.TagNumber(12)
  set ttsHeaderText(TranslatedString v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasTtsHeaderText() => $_has(7);
  @$pb.TagNumber(12)
  void clearTtsHeaderText() => clearField(12);
  @$pb.TagNumber(12)
  TranslatedString ensureTtsHeaderText() => $_ensure(7);

  /// Text for full description for the alert to be used in text-to-speech implementations. This field is the text-to-speech version of description_text.
  @$pb.TagNumber(13)
  TranslatedString get ttsDescriptionText => $_getN(8);
  @$pb.TagNumber(13)
  set ttsDescriptionText(TranslatedString v) { setField(13, v); }
  @$pb.TagNumber(13)
  $core.bool hasTtsDescriptionText() => $_has(8);
  @$pb.TagNumber(13)
  void clearTtsDescriptionText() => clearField(13);
  @$pb.TagNumber(13)
  TranslatedString ensureTtsDescriptionText() => $_ensure(8);

  @$pb.TagNumber(14)
  Alert_SeverityLevel get severityLevel => $_getN(9);
  @$pb.TagNumber(14)
  set severityLevel(Alert_SeverityLevel v) { setField(14, v); }
  @$pb.TagNumber(14)
  $core.bool hasSeverityLevel() => $_has(9);
  @$pb.TagNumber(14)
  void clearSeverityLevel() => clearField(14);

  /// TranslatedImage to be displayed along the alert text. Used to explain visually the alert effect of a detour, station closure, etc. The image must enhance the understanding of the alert. Any essential information communicated within the image must also be contained in the alert text.
  /// The following types of images are discouraged : image containing mainly text, marketing or branded images that add no additional information.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(15)
  TranslatedImage get image => $_getN(10);
  @$pb.TagNumber(15)
  set image(TranslatedImage v) { setField(15, v); }
  @$pb.TagNumber(15)
  $core.bool hasImage() => $_has(10);
  @$pb.TagNumber(15)
  void clearImage() => clearField(15);
  @$pb.TagNumber(15)
  TranslatedImage ensureImage() => $_ensure(10);

  /// Text describing the appearance of the linked image in the `image` field (e.g., in case the image can't be displayed
  /// or the user can't see the image for accessibility reasons). See the HTML spec for alt image text - https://html.spec.whatwg.org/#alt.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(16)
  TranslatedString get imageAlternativeText => $_getN(11);
  @$pb.TagNumber(16)
  set imageAlternativeText(TranslatedString v) { setField(16, v); }
  @$pb.TagNumber(16)
  $core.bool hasImageAlternativeText() => $_has(11);
  @$pb.TagNumber(16)
  void clearImageAlternativeText() => clearField(16);
  @$pb.TagNumber(16)
  TranslatedString ensureImageAlternativeText() => $_ensure(11);

  /// Description of the cause of the alert that allows for agency-specific language; more specific than the Cause. If cause_detail is included, then Cause must also be included.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(17)
  TranslatedString get causeDetail => $_getN(12);
  @$pb.TagNumber(17)
  set causeDetail(TranslatedString v) { setField(17, v); }
  @$pb.TagNumber(17)
  $core.bool hasCauseDetail() => $_has(12);
  @$pb.TagNumber(17)
  void clearCauseDetail() => clearField(17);
  @$pb.TagNumber(17)
  TranslatedString ensureCauseDetail() => $_ensure(12);

  /// Description of the effect of the alert that allows for agency-specific language; more specific than the Effect. If effect_detail is included, then Effect must also be included.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(18)
  TranslatedString get effectDetail => $_getN(13);
  @$pb.TagNumber(18)
  set effectDetail(TranslatedString v) { setField(18, v); }
  @$pb.TagNumber(18)
  $core.bool hasEffectDetail() => $_has(13);
  @$pb.TagNumber(18)
  void clearEffectDetail() => clearField(18);
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
    final $result = create();
    if (start != null) {
      $result.start = start;
    }
    if (end != null) {
      $result.end = end;
    }
    return $result;
  }
  TimeRange._() : super();
  factory TimeRange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TimeRange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TimeRange', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'start', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, _omitFieldNames ? '' : 'end', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TimeRange clone() => TimeRange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TimeRange copyWith(void Function(TimeRange) updates) => super.copyWith((message) => updates(message as TimeRange)) as TimeRange;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TimeRange create() => TimeRange._();
  TimeRange createEmptyInstance() => create();
  static $pb.PbList<TimeRange> createRepeated() => $pb.PbList<TimeRange>();
  @$core.pragma('dart2js:noInline')
  static TimeRange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TimeRange>(create);
  static TimeRange? _defaultInstance;

  /// Start time, in POSIX time (i.e., number of seconds since January 1st 1970
  /// 00:00:00 UTC).
  /// If missing, the interval starts at minus infinity.
  @$pb.TagNumber(1)
  $fixnum.Int64 get start => $_getI64(0);
  @$pb.TagNumber(1)
  set start($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStart() => $_has(0);
  @$pb.TagNumber(1)
  void clearStart() => clearField(1);

  /// End time, in POSIX time (i.e., number of seconds since January 1st 1970
  /// 00:00:00 UTC).
  /// If missing, the interval ends at plus infinity.
  @$pb.TagNumber(2)
  $fixnum.Int64 get end => $_getI64(1);
  @$pb.TagNumber(2)
  set end($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEnd() => $_has(1);
  @$pb.TagNumber(2)
  void clearEnd() => clearField(2);
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
    final $result = create();
    if (latitude != null) {
      $result.latitude = latitude;
    }
    if (longitude != null) {
      $result.longitude = longitude;
    }
    if (bearing != null) {
      $result.bearing = bearing;
    }
    if (odometer != null) {
      $result.odometer = odometer;
    }
    if (speed != null) {
      $result.speed = speed;
    }
    return $result;
  }
  Position._() : super();
  factory Position.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Position.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Position', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..a<$core.double>(1, _omitFieldNames ? '' : 'latitude', $pb.PbFieldType.QF)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'longitude', $pb.PbFieldType.QF)
    ..a<$core.double>(3, _omitFieldNames ? '' : 'bearing', $pb.PbFieldType.OF)
    ..a<$core.double>(4, _omitFieldNames ? '' : 'odometer', $pb.PbFieldType.OD)
    ..a<$core.double>(5, _omitFieldNames ? '' : 'speed', $pb.PbFieldType.OF)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Position clone() => Position()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Position copyWith(void Function(Position) updates) => super.copyWith((message) => updates(message as Position)) as Position;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Position create() => Position._();
  Position createEmptyInstance() => create();
  static $pb.PbList<Position> createRepeated() => $pb.PbList<Position>();
  @$core.pragma('dart2js:noInline')
  static Position getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Position>(create);
  static Position? _defaultInstance;

  /// Degrees North, in the WGS-84 coordinate system.
  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => clearField(1);

  /// Degrees East, in the WGS-84 coordinate system.
  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => clearField(2);

  /// Bearing, in degrees, clockwise from North, i.e., 0 is North and 90 is East.
  /// This can be the compass bearing, or the direction towards the next stop
  /// or intermediate location.
  /// This should not be direction deduced from the sequence of previous
  /// positions, which can be computed from previous data.
  @$pb.TagNumber(3)
  $core.double get bearing => $_getN(2);
  @$pb.TagNumber(3)
  set bearing($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBearing() => $_has(2);
  @$pb.TagNumber(3)
  void clearBearing() => clearField(3);

  /// Odometer value, in meters.
  @$pb.TagNumber(4)
  $core.double get odometer => $_getN(3);
  @$pb.TagNumber(4)
  set odometer($core.double v) { $_setDouble(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasOdometer() => $_has(3);
  @$pb.TagNumber(4)
  void clearOdometer() => clearField(4);

  /// Momentary speed measured by the vehicle, in meters per second.
  @$pb.TagNumber(5)
  $core.double get speed => $_getN(4);
  @$pb.TagNumber(5)
  set speed($core.double v) { $_setFloat(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasSpeed() => $_has(4);
  @$pb.TagNumber(5)
  void clearSpeed() => clearField(5);
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
  }) {
    final $result = create();
    if (tripId != null) {
      $result.tripId = tripId;
    }
    if (startTime != null) {
      $result.startTime = startTime;
    }
    if (startDate != null) {
      $result.startDate = startDate;
    }
    if (scheduleRelationship != null) {
      $result.scheduleRelationship = scheduleRelationship;
    }
    if (routeId != null) {
      $result.routeId = routeId;
    }
    if (directionId != null) {
      $result.directionId = directionId;
    }
    return $result;
  }
  TripDescriptor._() : super();
  factory TripDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TripDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TripDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'tripId')
    ..aOS(2, _omitFieldNames ? '' : 'startTime')
    ..aOS(3, _omitFieldNames ? '' : 'startDate')
    ..e<TripDescriptor_ScheduleRelationship>(4, _omitFieldNames ? '' : 'scheduleRelationship', $pb.PbFieldType.OE, defaultOrMaker: TripDescriptor_ScheduleRelationship.SCHEDULED, valueOf: TripDescriptor_ScheduleRelationship.valueOf, enumValues: TripDescriptor_ScheduleRelationship.values)
    ..aOS(5, _omitFieldNames ? '' : 'routeId')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'directionId', $pb.PbFieldType.OU3)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TripDescriptor clone() => TripDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TripDescriptor copyWith(void Function(TripDescriptor) updates) => super.copyWith((message) => updates(message as TripDescriptor)) as TripDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TripDescriptor create() => TripDescriptor._();
  TripDescriptor createEmptyInstance() => create();
  static $pb.PbList<TripDescriptor> createRepeated() => $pb.PbList<TripDescriptor>();
  @$core.pragma('dart2js:noInline')
  static TripDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TripDescriptor>(create);
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
  set tripId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasTripId() => $_has(0);
  @$pb.TagNumber(1)
  void clearTripId() => clearField(1);

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
  set startTime($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasStartTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearStartTime() => clearField(2);

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
  set startDate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasStartDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearStartDate() => clearField(3);

  @$pb.TagNumber(4)
  TripDescriptor_ScheduleRelationship get scheduleRelationship => $_getN(3);
  @$pb.TagNumber(4)
  set scheduleRelationship(TripDescriptor_ScheduleRelationship v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasScheduleRelationship() => $_has(3);
  @$pb.TagNumber(4)
  void clearScheduleRelationship() => clearField(4);

  /// The route_id from the GTFS that this selector refers to.
  @$pb.TagNumber(5)
  $core.String get routeId => $_getSZ(4);
  @$pb.TagNumber(5)
  set routeId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasRouteId() => $_has(4);
  @$pb.TagNumber(5)
  void clearRouteId() => clearField(5);

  /// The direction_id from the GTFS feed trips.txt file, indicating the
  /// direction of travel for trips this selector refers to.
  @$pb.TagNumber(6)
  $core.int get directionId => $_getIZ(5);
  @$pb.TagNumber(6)
  set directionId($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDirectionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirectionId() => clearField(6);
}

/// Identification information for the vehicle performing the trip.
class VehicleDescriptor extends $pb.GeneratedMessage {
  factory VehicleDescriptor({
    $core.String? id,
    $core.String? label,
    $core.String? licensePlate,
    VehicleDescriptor_WheelchairAccessible? wheelchairAccessible,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (label != null) {
      $result.label = label;
    }
    if (licensePlate != null) {
      $result.licensePlate = licensePlate;
    }
    if (wheelchairAccessible != null) {
      $result.wheelchairAccessible = wheelchairAccessible;
    }
    return $result;
  }
  VehicleDescriptor._() : super();
  factory VehicleDescriptor.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VehicleDescriptor.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VehicleDescriptor', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'label')
    ..aOS(3, _omitFieldNames ? '' : 'licensePlate')
    ..e<VehicleDescriptor_WheelchairAccessible>(4, _omitFieldNames ? '' : 'wheelchairAccessible', $pb.PbFieldType.OE, defaultOrMaker: VehicleDescriptor_WheelchairAccessible.NO_VALUE, valueOf: VehicleDescriptor_WheelchairAccessible.valueOf, enumValues: VehicleDescriptor_WheelchairAccessible.values)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VehicleDescriptor clone() => VehicleDescriptor()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VehicleDescriptor copyWith(void Function(VehicleDescriptor) updates) => super.copyWith((message) => updates(message as VehicleDescriptor)) as VehicleDescriptor;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VehicleDescriptor create() => VehicleDescriptor._();
  VehicleDescriptor createEmptyInstance() => create();
  static $pb.PbList<VehicleDescriptor> createRepeated() => $pb.PbList<VehicleDescriptor>();
  @$core.pragma('dart2js:noInline')
  static VehicleDescriptor getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VehicleDescriptor>(create);
  static VehicleDescriptor? _defaultInstance;

  /// Internal system identification of the vehicle. Should be unique per
  /// vehicle, and can be used for tracking the vehicle as it proceeds through
  /// the system.
  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  /// User visible label, i.e., something that must be shown to the passenger to
  /// help identify the correct vehicle.
  @$pb.TagNumber(2)
  $core.String get label => $_getSZ(1);
  @$pb.TagNumber(2)
  set label($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLabel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLabel() => clearField(2);

  /// The license plate of the vehicle.
  @$pb.TagNumber(3)
  $core.String get licensePlate => $_getSZ(2);
  @$pb.TagNumber(3)
  set licensePlate($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLicensePlate() => $_has(2);
  @$pb.TagNumber(3)
  void clearLicensePlate() => clearField(3);

  @$pb.TagNumber(4)
  VehicleDescriptor_WheelchairAccessible get wheelchairAccessible => $_getN(3);
  @$pb.TagNumber(4)
  set wheelchairAccessible(VehicleDescriptor_WheelchairAccessible v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasWheelchairAccessible() => $_has(3);
  @$pb.TagNumber(4)
  void clearWheelchairAccessible() => clearField(4);
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
    final $result = create();
    if (agencyId != null) {
      $result.agencyId = agencyId;
    }
    if (routeId != null) {
      $result.routeId = routeId;
    }
    if (routeType != null) {
      $result.routeType = routeType;
    }
    if (trip != null) {
      $result.trip = trip;
    }
    if (stopId != null) {
      $result.stopId = stopId;
    }
    if (directionId != null) {
      $result.directionId = directionId;
    }
    return $result;
  }
  EntitySelector._() : super();
  factory EntitySelector.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EntitySelector.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EntitySelector', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'agencyId')
    ..aOS(2, _omitFieldNames ? '' : 'routeId')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'routeType', $pb.PbFieldType.O3)
    ..aOM<TripDescriptor>(4, _omitFieldNames ? '' : 'trip', subBuilder: TripDescriptor.create)
    ..aOS(5, _omitFieldNames ? '' : 'stopId')
    ..a<$core.int>(6, _omitFieldNames ? '' : 'directionId', $pb.PbFieldType.OU3)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EntitySelector clone() => EntitySelector()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EntitySelector copyWith(void Function(EntitySelector) updates) => super.copyWith((message) => updates(message as EntitySelector)) as EntitySelector;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EntitySelector create() => EntitySelector._();
  EntitySelector createEmptyInstance() => create();
  static $pb.PbList<EntitySelector> createRepeated() => $pb.PbList<EntitySelector>();
  @$core.pragma('dart2js:noInline')
  static EntitySelector getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EntitySelector>(create);
  static EntitySelector? _defaultInstance;

  /// The values of the fields should correspond to the appropriate fields in the
  /// GTFS feed.
  /// At least one specifier must be given. If several are given, then the
  /// matching has to apply to all the given specifiers.
  @$pb.TagNumber(1)
  $core.String get agencyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set agencyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasAgencyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearAgencyId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get routeId => $_getSZ(1);
  @$pb.TagNumber(2)
  set routeId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRouteId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRouteId() => clearField(2);

  /// corresponds to route_type in GTFS.
  @$pb.TagNumber(3)
  $core.int get routeType => $_getIZ(2);
  @$pb.TagNumber(3)
  set routeType($core.int v) { $_setSignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasRouteType() => $_has(2);
  @$pb.TagNumber(3)
  void clearRouteType() => clearField(3);

  @$pb.TagNumber(4)
  TripDescriptor get trip => $_getN(3);
  @$pb.TagNumber(4)
  set trip(TripDescriptor v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasTrip() => $_has(3);
  @$pb.TagNumber(4)
  void clearTrip() => clearField(4);
  @$pb.TagNumber(4)
  TripDescriptor ensureTrip() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get stopId => $_getSZ(4);
  @$pb.TagNumber(5)
  set stopId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasStopId() => $_has(4);
  @$pb.TagNumber(5)
  void clearStopId() => clearField(5);

  /// Corresponds to trip direction_id in GTFS trips.txt. If provided the
  /// route_id must also be provided.
  @$pb.TagNumber(6)
  $core.int get directionId => $_getIZ(5);
  @$pb.TagNumber(6)
  set directionId($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDirectionId() => $_has(5);
  @$pb.TagNumber(6)
  void clearDirectionId() => clearField(6);
}

class TranslatedString_Translation extends $pb.GeneratedMessage {
  factory TranslatedString_Translation({
    $core.String? text,
    $core.String? language,
  }) {
    final $result = create();
    if (text != null) {
      $result.text = text;
    }
    if (language != null) {
      $result.language = language;
    }
    return $result;
  }
  TranslatedString_Translation._() : super();
  factory TranslatedString_Translation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranslatedString_Translation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranslatedString.Translation', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'text')
    ..aOS(2, _omitFieldNames ? '' : 'language')
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranslatedString_Translation clone() => TranslatedString_Translation()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranslatedString_Translation copyWith(void Function(TranslatedString_Translation) updates) => super.copyWith((message) => updates(message as TranslatedString_Translation)) as TranslatedString_Translation;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedString_Translation create() => TranslatedString_Translation._();
  TranslatedString_Translation createEmptyInstance() => create();
  static $pb.PbList<TranslatedString_Translation> createRepeated() => $pb.PbList<TranslatedString_Translation>();
  @$core.pragma('dart2js:noInline')
  static TranslatedString_Translation getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslatedString_Translation>(create);
  static TranslatedString_Translation? _defaultInstance;

  /// A UTF-8 string containing the message.
  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => clearField(1);

  /// BCP-47 language code. Can be omitted if the language is unknown or if
  /// no i18n is done at all for the feed. At most one translation is
  /// allowed to have an unspecified language tag.
  @$pb.TagNumber(2)
  $core.String get language => $_getSZ(1);
  @$pb.TagNumber(2)
  set language($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLanguage() => $_has(1);
  @$pb.TagNumber(2)
  void clearLanguage() => clearField(2);
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
    final $result = create();
    if (translation != null) {
      $result.translation.addAll(translation);
    }
    return $result;
  }
  TranslatedString._() : super();
  factory TranslatedString.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranslatedString.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranslatedString', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..pc<TranslatedString_Translation>(1, _omitFieldNames ? '' : 'translation', $pb.PbFieldType.PM, subBuilder: TranslatedString_Translation.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranslatedString clone() => TranslatedString()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranslatedString copyWith(void Function(TranslatedString) updates) => super.copyWith((message) => updates(message as TranslatedString)) as TranslatedString;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedString create() => TranslatedString._();
  TranslatedString createEmptyInstance() => create();
  static $pb.PbList<TranslatedString> createRepeated() => $pb.PbList<TranslatedString>();
  @$core.pragma('dart2js:noInline')
  static TranslatedString getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslatedString>(create);
  static TranslatedString? _defaultInstance;

  /// At least one translation must be provided.
  @$pb.TagNumber(1)
  $core.List<TranslatedString_Translation> get translation => $_getList(0);
}

class TranslatedImage_LocalizedImage extends $pb.GeneratedMessage {
  factory TranslatedImage_LocalizedImage({
    $core.String? url,
    $core.String? mediaType,
    $core.String? language,
  }) {
    final $result = create();
    if (url != null) {
      $result.url = url;
    }
    if (mediaType != null) {
      $result.mediaType = mediaType;
    }
    if (language != null) {
      $result.language = language;
    }
    return $result;
  }
  TranslatedImage_LocalizedImage._() : super();
  factory TranslatedImage_LocalizedImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranslatedImage_LocalizedImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranslatedImage.LocalizedImage', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aQS(1, _omitFieldNames ? '' : 'url')
    ..aQS(2, _omitFieldNames ? '' : 'mediaType')
    ..aOS(3, _omitFieldNames ? '' : 'language')
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranslatedImage_LocalizedImage clone() => TranslatedImage_LocalizedImage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranslatedImage_LocalizedImage copyWith(void Function(TranslatedImage_LocalizedImage) updates) => super.copyWith((message) => updates(message as TranslatedImage_LocalizedImage)) as TranslatedImage_LocalizedImage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedImage_LocalizedImage create() => TranslatedImage_LocalizedImage._();
  TranslatedImage_LocalizedImage createEmptyInstance() => create();
  static $pb.PbList<TranslatedImage_LocalizedImage> createRepeated() => $pb.PbList<TranslatedImage_LocalizedImage>();
  @$core.pragma('dart2js:noInline')
  static TranslatedImage_LocalizedImage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslatedImage_LocalizedImage>(create);
  static TranslatedImage_LocalizedImage? _defaultInstance;

  /// String containing an URL linking to an image
  /// The image linked must be less than 2MB.
  /// If an image changes in a significant enough way that an update is required on the consumer side, the producer must update the URL to a new one.
  /// The URL should be a fully qualified URL that includes http:// or https://, and any special characters in the URL must be correctly escaped. See the following http://www.w3.org/Addressing/URL/4_URI_Recommentations.html for a description of how to create fully qualified URL values.
  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  /// IANA media type as to specify the type of image to be displayed.
  /// The type must start with "image/"
  @$pb.TagNumber(2)
  $core.String get mediaType => $_getSZ(1);
  @$pb.TagNumber(2)
  set mediaType($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasMediaType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaType() => clearField(2);

  /// BCP-47 language code. Can be omitted if the language is unknown or if
  /// no i18n is done at all for the feed. At most one translation is
  /// allowed to have an unspecified language tag.
  @$pb.TagNumber(3)
  $core.String get language => $_getSZ(2);
  @$pb.TagNumber(3)
  set language($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLanguage() => $_has(2);
  @$pb.TagNumber(3)
  void clearLanguage() => clearField(3);
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
    final $result = create();
    if (localizedImage != null) {
      $result.localizedImage.addAll(localizedImage);
    }
    return $result;
  }
  TranslatedImage._() : super();
  factory TranslatedImage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory TranslatedImage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'TranslatedImage', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..pc<TranslatedImage_LocalizedImage>(1, _omitFieldNames ? '' : 'localizedImage', $pb.PbFieldType.PM, subBuilder: TranslatedImage_LocalizedImage.create)
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  TranslatedImage clone() => TranslatedImage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  TranslatedImage copyWith(void Function(TranslatedImage) updates) => super.copyWith((message) => updates(message as TranslatedImage)) as TranslatedImage;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static TranslatedImage create() => TranslatedImage._();
  TranslatedImage createEmptyInstance() => create();
  static $pb.PbList<TranslatedImage> createRepeated() => $pb.PbList<TranslatedImage>();
  @$core.pragma('dart2js:noInline')
  static TranslatedImage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TranslatedImage>(create);
  static TranslatedImage? _defaultInstance;

  /// At least one localized image must be provided.
  @$pb.TagNumber(1)
  $core.List<TranslatedImage_LocalizedImage> get localizedImage => $_getList(0);
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
    final $result = create();
    if (shapeId != null) {
      $result.shapeId = shapeId;
    }
    if (encodedPolyline != null) {
      $result.encodedPolyline = encodedPolyline;
    }
    return $result;
  }
  Shape._() : super();
  factory Shape.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Shape.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Shape', package: const $pb.PackageName(_omitMessageNames ? '' : 'transit_realtime'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'shapeId')
    ..aOS(2, _omitFieldNames ? '' : 'encodedPolyline')
    ..hasExtensions = true
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Shape clone() => Shape()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Shape copyWith(void Function(Shape) updates) => super.copyWith((message) => updates(message as Shape)) as Shape;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Shape create() => Shape._();
  Shape createEmptyInstance() => create();
  static $pb.PbList<Shape> createRepeated() => $pb.PbList<Shape>();
  @$core.pragma('dart2js:noInline')
  static Shape getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Shape>(create);
  static Shape? _defaultInstance;

  /// Identifier of the shape. Must be different than any shape_id defined in the (CSV) GTFS.
  /// This field is required as per reference.md, but needs to be specified here optional because "Required is Forever"
  /// See https://developers.google.com/protocol-buffers/docs/proto#specifying_field_rules
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(1)
  $core.String get shapeId => $_getSZ(0);
  @$pb.TagNumber(1)
  set shapeId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasShapeId() => $_has(0);
  @$pb.TagNumber(1)
  void clearShapeId() => clearField(1);

  /// Encoded polyline representation of the shape. This polyline must contain at least two points.
  /// For more information about encoded polylines, see https://developers.google.com/maps/documentation/utilities/polylinealgorithm
  /// This field is required as per reference.md, but needs to be specified here optional because "Required is Forever"
  /// See https://developers.google.com/protocol-buffers/docs/proto#specifying_field_rules
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  @$pb.TagNumber(2)
  $core.String get encodedPolyline => $_getSZ(1);
  @$pb.TagNumber(2)
  set encodedPolyline($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEncodedPolyline() => $_has(1);
  @$pb.TagNumber(2)
  void clearEncodedPolyline() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
