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

import 'package:protobuf/protobuf.dart' as $pb;

/// Determines whether the current fetch is incremental.  Currently,
/// DIFFERENTIAL mode is unsupported and behavior is unspecified for feeds
/// that use this mode.  There are discussions on the GTFS Realtime mailing
/// list around fully specifying the behavior of DIFFERENTIAL mode and the
/// documentation will be updated when those discussions are finalized.
class FeedHeader_Incrementality extends $pb.ProtobufEnum {
  static const FeedHeader_Incrementality FULL_DATASET = FeedHeader_Incrementality._(0, _omitEnumNames ? '' : 'FULL_DATASET');
  static const FeedHeader_Incrementality DIFFERENTIAL = FeedHeader_Incrementality._(1, _omitEnumNames ? '' : 'DIFFERENTIAL');

  static const $core.List<FeedHeader_Incrementality> values = <FeedHeader_Incrementality> [
    FULL_DATASET,
    DIFFERENTIAL,
  ];

  static final $core.Map<$core.int, FeedHeader_Incrementality> _byValue = $pb.ProtobufEnum.initByValue(values);
  static FeedHeader_Incrementality? valueOf($core.int value) => _byValue[value];

  const FeedHeader_Incrementality._($core.int v, $core.String n) : super(v, n);
}

/// The relation between this StopTime and the static schedule.
class TripUpdate_StopTimeUpdate_ScheduleRelationship extends $pb.ProtobufEnum {
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship SCHEDULED = TripUpdate_StopTimeUpdate_ScheduleRelationship._(0, _omitEnumNames ? '' : 'SCHEDULED');
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship SKIPPED = TripUpdate_StopTimeUpdate_ScheduleRelationship._(1, _omitEnumNames ? '' : 'SKIPPED');
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship NO_DATA = TripUpdate_StopTimeUpdate_ScheduleRelationship._(2, _omitEnumNames ? '' : 'NO_DATA');

  static const $core.List<TripUpdate_StopTimeUpdate_ScheduleRelationship> values = <TripUpdate_StopTimeUpdate_ScheduleRelationship> [
    SCHEDULED,
    SKIPPED,
    NO_DATA,
  ];

  static final $core.Map<$core.int, TripUpdate_StopTimeUpdate_ScheduleRelationship> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TripUpdate_StopTimeUpdate_ScheduleRelationship? valueOf($core.int value) => _byValue[value];

  const TripUpdate_StopTimeUpdate_ScheduleRelationship._($core.int v, $core.String n) : super(v, n);
}

class VehiclePosition_VehicleStopStatus extends $pb.ProtobufEnum {
  static const VehiclePosition_VehicleStopStatus INCOMING_AT = VehiclePosition_VehicleStopStatus._(0, _omitEnumNames ? '' : 'INCOMING_AT');
  static const VehiclePosition_VehicleStopStatus STOPPED_AT = VehiclePosition_VehicleStopStatus._(1, _omitEnumNames ? '' : 'STOPPED_AT');
  static const VehiclePosition_VehicleStopStatus IN_TRANSIT_TO = VehiclePosition_VehicleStopStatus._(2, _omitEnumNames ? '' : 'IN_TRANSIT_TO');

  static const $core.List<VehiclePosition_VehicleStopStatus> values = <VehiclePosition_VehicleStopStatus> [
    INCOMING_AT,
    STOPPED_AT,
    IN_TRANSIT_TO,
  ];

  static final $core.Map<$core.int, VehiclePosition_VehicleStopStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VehiclePosition_VehicleStopStatus? valueOf($core.int value) => _byValue[value];

  const VehiclePosition_VehicleStopStatus._($core.int v, $core.String n) : super(v, n);
}

/// Congestion level that is affecting this vehicle.
class VehiclePosition_CongestionLevel extends $pb.ProtobufEnum {
  static const VehiclePosition_CongestionLevel UNKNOWN_CONGESTION_LEVEL = VehiclePosition_CongestionLevel._(0, _omitEnumNames ? '' : 'UNKNOWN_CONGESTION_LEVEL');
  static const VehiclePosition_CongestionLevel RUNNING_SMOOTHLY = VehiclePosition_CongestionLevel._(1, _omitEnumNames ? '' : 'RUNNING_SMOOTHLY');
  static const VehiclePosition_CongestionLevel STOP_AND_GO = VehiclePosition_CongestionLevel._(2, _omitEnumNames ? '' : 'STOP_AND_GO');
  static const VehiclePosition_CongestionLevel CONGESTION = VehiclePosition_CongestionLevel._(3, _omitEnumNames ? '' : 'CONGESTION');
  static const VehiclePosition_CongestionLevel SEVERE_CONGESTION = VehiclePosition_CongestionLevel._(4, _omitEnumNames ? '' : 'SEVERE_CONGESTION');

  static const $core.List<VehiclePosition_CongestionLevel> values = <VehiclePosition_CongestionLevel> [
    UNKNOWN_CONGESTION_LEVEL,
    RUNNING_SMOOTHLY,
    STOP_AND_GO,
    CONGESTION,
    SEVERE_CONGESTION,
  ];

  static final $core.Map<$core.int, VehiclePosition_CongestionLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VehiclePosition_CongestionLevel? valueOf($core.int value) => _byValue[value];

  const VehiclePosition_CongestionLevel._($core.int v, $core.String n) : super(v, n);
}

/// The degree of passenger occupancy of the vehicle. This field is still
/// experimental, and subject to change. It may be formally adopted in the
/// future.
class VehiclePosition_OccupancyStatus extends $pb.ProtobufEnum {
  static const VehiclePosition_OccupancyStatus EMPTY = VehiclePosition_OccupancyStatus._(0, _omitEnumNames ? '' : 'EMPTY');
  static const VehiclePosition_OccupancyStatus MANY_SEATS_AVAILABLE = VehiclePosition_OccupancyStatus._(1, _omitEnumNames ? '' : 'MANY_SEATS_AVAILABLE');
  static const VehiclePosition_OccupancyStatus FEW_SEATS_AVAILABLE = VehiclePosition_OccupancyStatus._(2, _omitEnumNames ? '' : 'FEW_SEATS_AVAILABLE');
  static const VehiclePosition_OccupancyStatus STANDING_ROOM_ONLY = VehiclePosition_OccupancyStatus._(3, _omitEnumNames ? '' : 'STANDING_ROOM_ONLY');
  static const VehiclePosition_OccupancyStatus CRUSHED_STANDING_ROOM_ONLY = VehiclePosition_OccupancyStatus._(4, _omitEnumNames ? '' : 'CRUSHED_STANDING_ROOM_ONLY');
  static const VehiclePosition_OccupancyStatus FULL = VehiclePosition_OccupancyStatus._(5, _omitEnumNames ? '' : 'FULL');
  static const VehiclePosition_OccupancyStatus NOT_ACCEPTING_PASSENGERS = VehiclePosition_OccupancyStatus._(6, _omitEnumNames ? '' : 'NOT_ACCEPTING_PASSENGERS');

  static const $core.List<VehiclePosition_OccupancyStatus> values = <VehiclePosition_OccupancyStatus> [
    EMPTY,
    MANY_SEATS_AVAILABLE,
    FEW_SEATS_AVAILABLE,
    STANDING_ROOM_ONLY,
    CRUSHED_STANDING_ROOM_ONLY,
    FULL,
    NOT_ACCEPTING_PASSENGERS,
  ];

  static final $core.Map<$core.int, VehiclePosition_OccupancyStatus> _byValue = $pb.ProtobufEnum.initByValue(values);
  static VehiclePosition_OccupancyStatus? valueOf($core.int value) => _byValue[value];

  const VehiclePosition_OccupancyStatus._($core.int v, $core.String n) : super(v, n);
}

/// Cause of this alert.
class Alert_Cause extends $pb.ProtobufEnum {
  static const Alert_Cause UNKNOWN_CAUSE = Alert_Cause._(1, _omitEnumNames ? '' : 'UNKNOWN_CAUSE');
  static const Alert_Cause OTHER_CAUSE = Alert_Cause._(2, _omitEnumNames ? '' : 'OTHER_CAUSE');
  static const Alert_Cause TECHNICAL_PROBLEM = Alert_Cause._(3, _omitEnumNames ? '' : 'TECHNICAL_PROBLEM');
  static const Alert_Cause STRIKE = Alert_Cause._(4, _omitEnumNames ? '' : 'STRIKE');
  static const Alert_Cause DEMONSTRATION = Alert_Cause._(5, _omitEnumNames ? '' : 'DEMONSTRATION');
  static const Alert_Cause ACCIDENT = Alert_Cause._(6, _omitEnumNames ? '' : 'ACCIDENT');
  static const Alert_Cause HOLIDAY = Alert_Cause._(7, _omitEnumNames ? '' : 'HOLIDAY');
  static const Alert_Cause WEATHER = Alert_Cause._(8, _omitEnumNames ? '' : 'WEATHER');
  static const Alert_Cause MAINTENANCE = Alert_Cause._(9, _omitEnumNames ? '' : 'MAINTENANCE');
  static const Alert_Cause CONSTRUCTION = Alert_Cause._(10, _omitEnumNames ? '' : 'CONSTRUCTION');
  static const Alert_Cause POLICE_ACTIVITY = Alert_Cause._(11, _omitEnumNames ? '' : 'POLICE_ACTIVITY');
  static const Alert_Cause MEDICAL_EMERGENCY = Alert_Cause._(12, _omitEnumNames ? '' : 'MEDICAL_EMERGENCY');

  static const $core.List<Alert_Cause> values = <Alert_Cause> [
    UNKNOWN_CAUSE,
    OTHER_CAUSE,
    TECHNICAL_PROBLEM,
    STRIKE,
    DEMONSTRATION,
    ACCIDENT,
    HOLIDAY,
    WEATHER,
    MAINTENANCE,
    CONSTRUCTION,
    POLICE_ACTIVITY,
    MEDICAL_EMERGENCY,
  ];

  static final $core.Map<$core.int, Alert_Cause> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Alert_Cause? valueOf($core.int value) => _byValue[value];

  const Alert_Cause._($core.int v, $core.String n) : super(v, n);
}

/// What is the effect of this problem on the affected entity.
class Alert_Effect extends $pb.ProtobufEnum {
  static const Alert_Effect NO_SERVICE = Alert_Effect._(1, _omitEnumNames ? '' : 'NO_SERVICE');
  static const Alert_Effect REDUCED_SERVICE = Alert_Effect._(2, _omitEnumNames ? '' : 'REDUCED_SERVICE');
  static const Alert_Effect SIGNIFICANT_DELAYS = Alert_Effect._(3, _omitEnumNames ? '' : 'SIGNIFICANT_DELAYS');
  static const Alert_Effect DETOUR = Alert_Effect._(4, _omitEnumNames ? '' : 'DETOUR');
  static const Alert_Effect ADDITIONAL_SERVICE = Alert_Effect._(5, _omitEnumNames ? '' : 'ADDITIONAL_SERVICE');
  static const Alert_Effect MODIFIED_SERVICE = Alert_Effect._(6, _omitEnumNames ? '' : 'MODIFIED_SERVICE');
  static const Alert_Effect OTHER_EFFECT = Alert_Effect._(7, _omitEnumNames ? '' : 'OTHER_EFFECT');
  static const Alert_Effect UNKNOWN_EFFECT = Alert_Effect._(8, _omitEnumNames ? '' : 'UNKNOWN_EFFECT');
  static const Alert_Effect STOP_MOVED = Alert_Effect._(9, _omitEnumNames ? '' : 'STOP_MOVED');

  static const $core.List<Alert_Effect> values = <Alert_Effect> [
    NO_SERVICE,
    REDUCED_SERVICE,
    SIGNIFICANT_DELAYS,
    DETOUR,
    ADDITIONAL_SERVICE,
    MODIFIED_SERVICE,
    OTHER_EFFECT,
    UNKNOWN_EFFECT,
    STOP_MOVED,
  ];

  static final $core.Map<$core.int, Alert_Effect> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Alert_Effect? valueOf($core.int value) => _byValue[value];

  const Alert_Effect._($core.int v, $core.String n) : super(v, n);
}

/// The relation between this trip and the static schedule. If a trip is done
/// in accordance with temporary schedule, not reflected in GTFS, then it
/// shouldn't be marked as SCHEDULED, but likely as ADDED.
class TripDescriptor_ScheduleRelationship extends $pb.ProtobufEnum {
  static const TripDescriptor_ScheduleRelationship SCHEDULED = TripDescriptor_ScheduleRelationship._(0, _omitEnumNames ? '' : 'SCHEDULED');
  static const TripDescriptor_ScheduleRelationship ADDED = TripDescriptor_ScheduleRelationship._(1, _omitEnumNames ? '' : 'ADDED');
  static const TripDescriptor_ScheduleRelationship UNSCHEDULED = TripDescriptor_ScheduleRelationship._(2, _omitEnumNames ? '' : 'UNSCHEDULED');
  static const TripDescriptor_ScheduleRelationship CANCELED = TripDescriptor_ScheduleRelationship._(3, _omitEnumNames ? '' : 'CANCELED');

  static const $core.List<TripDescriptor_ScheduleRelationship> values = <TripDescriptor_ScheduleRelationship> [
    SCHEDULED,
    ADDED,
    UNSCHEDULED,
    CANCELED,
  ];

  static final $core.Map<$core.int, TripDescriptor_ScheduleRelationship> _byValue = $pb.ProtobufEnum.initByValue(values);
  static TripDescriptor_ScheduleRelationship? valueOf($core.int value) => _byValue[value];

  const TripDescriptor_ScheduleRelationship._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
