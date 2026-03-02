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

import 'package:protobuf/protobuf.dart' as $pb;

/// Determines whether the current fetch is incremental.  Currently,
/// DIFFERENTIAL mode is unsupported and behavior is unspecified for feeds
/// that use this mode.  There are discussions on the GTFS Realtime mailing
/// list around fully specifying the behavior of DIFFERENTIAL mode and the
/// documentation will be updated when those discussions are finalized.
class FeedHeader_Incrementality extends $pb.ProtobufEnum {
  static const FeedHeader_Incrementality FULL_DATASET =
      FeedHeader_Incrementality._(0, _omitEnumNames ? '' : 'FULL_DATASET');
  static const FeedHeader_Incrementality DIFFERENTIAL =
      FeedHeader_Incrementality._(1, _omitEnumNames ? '' : 'DIFFERENTIAL');

  static const $core.List<FeedHeader_Incrementality> values =
      <FeedHeader_Incrementality>[
    FULL_DATASET,
    DIFFERENTIAL,
  ];

  static final $core.List<FeedHeader_Incrementality?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static FeedHeader_Incrementality? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const FeedHeader_Incrementality._(super.value, super.name);
}

/// The relation between the StopTimeEvents and the static schedule.
class TripUpdate_StopTimeUpdate_ScheduleRelationship extends $pb.ProtobufEnum {
  /// The vehicle is proceeding in accordance with its static schedule of
  /// stops, although not necessarily according to the times of the schedule.
  /// At least one of arrival and departure must be provided. If the schedule
  /// for this stop contains both arrival and departure times then so must
  /// this update. Frequency-based trips (GTFS frequencies.txt with exact_times = 0)
  /// should not have a SCHEDULED value and should use UNSCHEDULED instead.
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship SCHEDULED =
      TripUpdate_StopTimeUpdate_ScheduleRelationship._(
          0, _omitEnumNames ? '' : 'SCHEDULED');

  /// The stop is skipped, i.e., the vehicle will not stop at this stop.
  /// Arrival and departure are optional.
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship SKIPPED =
      TripUpdate_StopTimeUpdate_ScheduleRelationship._(
          1, _omitEnumNames ? '' : 'SKIPPED');

  /// No StopTimeEvents are given for this stop.
  /// The main intention for this value is to give time predictions only for
  /// part of a trip, i.e., if the last update for a trip has a NO_DATA
  /// specifier, then StopTimeEvents for the rest of the stops in the trip
  /// are considered to be unspecified as well.
  /// Neither arrival nor departure should be supplied.
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship NO_DATA =
      TripUpdate_StopTimeUpdate_ScheduleRelationship._(
          2, _omitEnumNames ? '' : 'NO_DATA');

  /// The vehicle is operating a trip defined in GTFS frequencies.txt with exact_times = 0.
  /// This value should not be used for trips that are not defined in GTFS frequencies.txt,
  /// or trips in GTFS frequencies.txt with exact_times = 1. Trips containing StopTimeUpdates
  /// with ScheduleRelationship=UNSCHEDULED must also set TripDescriptor.ScheduleRelationship=UNSCHEDULED.
  /// NOTE: This field is still experimental, and subject to change. It may be
  /// formally adopted in the future.
  static const TripUpdate_StopTimeUpdate_ScheduleRelationship UNSCHEDULED =
      TripUpdate_StopTimeUpdate_ScheduleRelationship._(
          3, _omitEnumNames ? '' : 'UNSCHEDULED');

  static const $core.List<TripUpdate_StopTimeUpdate_ScheduleRelationship>
      values = <TripUpdate_StopTimeUpdate_ScheduleRelationship>[
    SCHEDULED,
    SKIPPED,
    NO_DATA,
    UNSCHEDULED,
  ];

  static final $core.List<TripUpdate_StopTimeUpdate_ScheduleRelationship?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TripUpdate_StopTimeUpdate_ScheduleRelationship? valueOf(
          $core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TripUpdate_StopTimeUpdate_ScheduleRelationship._(
      super.value, super.name);
}

class TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
    extends $pb.ProtobufEnum {
  /// Regularly scheduled pickup/dropoff.
  static const TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      REGULAR =
      TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType._(
          0, _omitEnumNames ? '' : 'REGULAR');

  /// No pickup/dropoff available
  static const TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      NONE = TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType._(
          1, _omitEnumNames ? '' : 'NONE');

  /// Must phone agency to arrange pickup/dropoff.
  static const TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      PHONE_AGENCY =
      TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType._(
          2, _omitEnumNames ? '' : 'PHONE_AGENCY');

  /// Must coordinate with driver to arrange pickup/dropoff.
  static const TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType
      COORDINATE_WITH_DRIVER =
      TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType._(
          3, _omitEnumNames ? '' : 'COORDINATE_WITH_DRIVER');

  static const $core
      .List<TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType>
      values = <TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType>[
    REGULAR,
    NONE,
    PHONE_AGENCY,
    COORDINATE_WITH_DRIVER,
  ];

  static final $core
      .List<TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType?>
      _byValue = $pb.ProtobufEnum.$_initByValueList(values, 3);
  static TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType?
      valueOf($core.int value) =>
          value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TripUpdate_StopTimeUpdate_StopTimeProperties_DropOffPickupType._(
      super.value, super.name);
}

class VehiclePosition_VehicleStopStatus extends $pb.ProtobufEnum {
  /// The vehicle is just about to arrive at the stop (on a stop
  /// display, the vehicle symbol typically flashes).
  static const VehiclePosition_VehicleStopStatus INCOMING_AT =
      VehiclePosition_VehicleStopStatus._(
          0, _omitEnumNames ? '' : 'INCOMING_AT');

  /// The vehicle is standing at the stop.
  static const VehiclePosition_VehicleStopStatus STOPPED_AT =
      VehiclePosition_VehicleStopStatus._(
          1, _omitEnumNames ? '' : 'STOPPED_AT');

  /// The vehicle has departed and is in transit to the next stop.
  static const VehiclePosition_VehicleStopStatus IN_TRANSIT_TO =
      VehiclePosition_VehicleStopStatus._(
          2, _omitEnumNames ? '' : 'IN_TRANSIT_TO');

  static const $core.List<VehiclePosition_VehicleStopStatus> values =
      <VehiclePosition_VehicleStopStatus>[
    INCOMING_AT,
    STOPPED_AT,
    IN_TRANSIT_TO,
  ];

  static final $core.List<VehiclePosition_VehicleStopStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static VehiclePosition_VehicleStopStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VehiclePosition_VehicleStopStatus._(super.value, super.name);
}

/// Congestion level that is affecting this vehicle.
class VehiclePosition_CongestionLevel extends $pb.ProtobufEnum {
  static const VehiclePosition_CongestionLevel UNKNOWN_CONGESTION_LEVEL =
      VehiclePosition_CongestionLevel._(
          0, _omitEnumNames ? '' : 'UNKNOWN_CONGESTION_LEVEL');
  static const VehiclePosition_CongestionLevel RUNNING_SMOOTHLY =
      VehiclePosition_CongestionLevel._(
          1, _omitEnumNames ? '' : 'RUNNING_SMOOTHLY');
  static const VehiclePosition_CongestionLevel STOP_AND_GO =
      VehiclePosition_CongestionLevel._(2, _omitEnumNames ? '' : 'STOP_AND_GO');
  static const VehiclePosition_CongestionLevel CONGESTION =
      VehiclePosition_CongestionLevel._(3, _omitEnumNames ? '' : 'CONGESTION');
  static const VehiclePosition_CongestionLevel SEVERE_CONGESTION =
      VehiclePosition_CongestionLevel._(
          4, _omitEnumNames ? '' : 'SEVERE_CONGESTION');

  static const $core.List<VehiclePosition_CongestionLevel> values =
      <VehiclePosition_CongestionLevel>[
    UNKNOWN_CONGESTION_LEVEL,
    RUNNING_SMOOTHLY,
    STOP_AND_GO,
    CONGESTION,
    SEVERE_CONGESTION,
  ];

  static final $core.List<VehiclePosition_CongestionLevel?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static VehiclePosition_CongestionLevel? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VehiclePosition_CongestionLevel._(super.value, super.name);
}

/// The state of passenger occupancy for the vehicle or carriage.
/// Individual producers may not publish all OccupancyStatus values. Therefore, consumers
/// must not assume that the OccupancyStatus values follow a linear scale.
/// Consumers should represent OccupancyStatus values as the state indicated
/// and intended by the producer. Likewise, producers must use OccupancyStatus values that
/// correspond to actual vehicle occupancy states.
/// For describing passenger occupancy levels on a linear scale, see `occupancy_percentage`.
/// This field is still experimental, and subject to change. It may be formally adopted in the future.
class VehiclePosition_OccupancyStatus extends $pb.ProtobufEnum {
  /// The vehicle or carriage is considered empty by most measures, and has few or no
  /// passengers onboard, but is still accepting passengers.
  static const VehiclePosition_OccupancyStatus EMPTY =
      VehiclePosition_OccupancyStatus._(0, _omitEnumNames ? '' : 'EMPTY');

  /// The vehicle or carriage has a large number of seats available.
  /// The amount of free seats out of the total seats available to be
  /// considered large enough to fall into this category is determined at the
  /// discretion of the producer.
  static const VehiclePosition_OccupancyStatus MANY_SEATS_AVAILABLE =
      VehiclePosition_OccupancyStatus._(
          1, _omitEnumNames ? '' : 'MANY_SEATS_AVAILABLE');

  /// The vehicle or carriage has a relatively small number of seats available.
  /// The amount of free seats out of the total seats available to be
  /// considered small enough to fall into this category is determined at the
  /// discretion of the feed producer.
  static const VehiclePosition_OccupancyStatus FEW_SEATS_AVAILABLE =
      VehiclePosition_OccupancyStatus._(
          2, _omitEnumNames ? '' : 'FEW_SEATS_AVAILABLE');

  /// The vehicle or carriage can currently accommodate only standing passengers.
  static const VehiclePosition_OccupancyStatus STANDING_ROOM_ONLY =
      VehiclePosition_OccupancyStatus._(
          3, _omitEnumNames ? '' : 'STANDING_ROOM_ONLY');

  /// The vehicle or carriage can currently accommodate only standing passengers
  /// and has limited space for them.
  static const VehiclePosition_OccupancyStatus CRUSHED_STANDING_ROOM_ONLY =
      VehiclePosition_OccupancyStatus._(
          4, _omitEnumNames ? '' : 'CRUSHED_STANDING_ROOM_ONLY');

  /// The vehicle or carriage is considered full by most measures, but may still be
  /// allowing passengers to board.
  static const VehiclePosition_OccupancyStatus FULL =
      VehiclePosition_OccupancyStatus._(5, _omitEnumNames ? '' : 'FULL');

  /// The vehicle or carriage is not accepting passengers, but usually accepts passengers for boarding.
  static const VehiclePosition_OccupancyStatus NOT_ACCEPTING_PASSENGERS =
      VehiclePosition_OccupancyStatus._(
          6, _omitEnumNames ? '' : 'NOT_ACCEPTING_PASSENGERS');

  /// The vehicle or carriage doesn't have any occupancy data available at that time.
  static const VehiclePosition_OccupancyStatus NO_DATA_AVAILABLE =
      VehiclePosition_OccupancyStatus._(
          7, _omitEnumNames ? '' : 'NO_DATA_AVAILABLE');

  /// The vehicle or carriage is not boardable and never accepts passengers.
  /// Useful for special vehicles or carriages (engine, maintenance carriage, etc…).
  static const VehiclePosition_OccupancyStatus NOT_BOARDABLE =
      VehiclePosition_OccupancyStatus._(
          8, _omitEnumNames ? '' : 'NOT_BOARDABLE');

  static const $core.List<VehiclePosition_OccupancyStatus> values =
      <VehiclePosition_OccupancyStatus>[
    EMPTY,
    MANY_SEATS_AVAILABLE,
    FEW_SEATS_AVAILABLE,
    STANDING_ROOM_ONLY,
    CRUSHED_STANDING_ROOM_ONLY,
    FULL,
    NOT_ACCEPTING_PASSENGERS,
    NO_DATA_AVAILABLE,
    NOT_BOARDABLE,
  ];

  static final $core.List<VehiclePosition_OccupancyStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static VehiclePosition_OccupancyStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VehiclePosition_OccupancyStatus._(super.value, super.name);
}

/// Cause of this alert. If cause_detail is included, then Cause must also be included.
class Alert_Cause extends $pb.ProtobufEnum {
  static const Alert_Cause UNKNOWN_CAUSE =
      Alert_Cause._(1, _omitEnumNames ? '' : 'UNKNOWN_CAUSE');
  static const Alert_Cause OTHER_CAUSE =
      Alert_Cause._(2, _omitEnumNames ? '' : 'OTHER_CAUSE');
  static const Alert_Cause TECHNICAL_PROBLEM =
      Alert_Cause._(3, _omitEnumNames ? '' : 'TECHNICAL_PROBLEM');
  static const Alert_Cause STRIKE =
      Alert_Cause._(4, _omitEnumNames ? '' : 'STRIKE');
  static const Alert_Cause DEMONSTRATION =
      Alert_Cause._(5, _omitEnumNames ? '' : 'DEMONSTRATION');
  static const Alert_Cause ACCIDENT =
      Alert_Cause._(6, _omitEnumNames ? '' : 'ACCIDENT');
  static const Alert_Cause HOLIDAY =
      Alert_Cause._(7, _omitEnumNames ? '' : 'HOLIDAY');
  static const Alert_Cause WEATHER =
      Alert_Cause._(8, _omitEnumNames ? '' : 'WEATHER');
  static const Alert_Cause MAINTENANCE =
      Alert_Cause._(9, _omitEnumNames ? '' : 'MAINTENANCE');
  static const Alert_Cause CONSTRUCTION =
      Alert_Cause._(10, _omitEnumNames ? '' : 'CONSTRUCTION');
  static const Alert_Cause POLICE_ACTIVITY =
      Alert_Cause._(11, _omitEnumNames ? '' : 'POLICE_ACTIVITY');
  static const Alert_Cause MEDICAL_EMERGENCY =
      Alert_Cause._(12, _omitEnumNames ? '' : 'MEDICAL_EMERGENCY');

  static const $core.List<Alert_Cause> values = <Alert_Cause>[
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

  static final $core.List<Alert_Cause?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static Alert_Cause? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Alert_Cause._(super.value, super.name);
}

/// What is the effect of this problem on the affected entity. If effect_detail is included, then Effect must also be included.
class Alert_Effect extends $pb.ProtobufEnum {
  static const Alert_Effect NO_SERVICE =
      Alert_Effect._(1, _omitEnumNames ? '' : 'NO_SERVICE');
  static const Alert_Effect REDUCED_SERVICE =
      Alert_Effect._(2, _omitEnumNames ? '' : 'REDUCED_SERVICE');

  /// We don't care about INsignificant delays: they are hard to detect, have
  /// little impact on the user, and would clutter the results as they are too
  /// frequent.
  static const Alert_Effect SIGNIFICANT_DELAYS =
      Alert_Effect._(3, _omitEnumNames ? '' : 'SIGNIFICANT_DELAYS');
  static const Alert_Effect DETOUR =
      Alert_Effect._(4, _omitEnumNames ? '' : 'DETOUR');
  static const Alert_Effect ADDITIONAL_SERVICE =
      Alert_Effect._(5, _omitEnumNames ? '' : 'ADDITIONAL_SERVICE');
  static const Alert_Effect MODIFIED_SERVICE =
      Alert_Effect._(6, _omitEnumNames ? '' : 'MODIFIED_SERVICE');
  static const Alert_Effect OTHER_EFFECT =
      Alert_Effect._(7, _omitEnumNames ? '' : 'OTHER_EFFECT');
  static const Alert_Effect UNKNOWN_EFFECT =
      Alert_Effect._(8, _omitEnumNames ? '' : 'UNKNOWN_EFFECT');
  static const Alert_Effect STOP_MOVED =
      Alert_Effect._(9, _omitEnumNames ? '' : 'STOP_MOVED');
  static const Alert_Effect NO_EFFECT =
      Alert_Effect._(10, _omitEnumNames ? '' : 'NO_EFFECT');
  static const Alert_Effect ACCESSIBILITY_ISSUE =
      Alert_Effect._(11, _omitEnumNames ? '' : 'ACCESSIBILITY_ISSUE');

  static const $core.List<Alert_Effect> values = <Alert_Effect>[
    NO_SERVICE,
    REDUCED_SERVICE,
    SIGNIFICANT_DELAYS,
    DETOUR,
    ADDITIONAL_SERVICE,
    MODIFIED_SERVICE,
    OTHER_EFFECT,
    UNKNOWN_EFFECT,
    STOP_MOVED,
    NO_EFFECT,
    ACCESSIBILITY_ISSUE,
  ];

  static final $core.List<Alert_Effect?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 11);
  static Alert_Effect? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Alert_Effect._(super.value, super.name);
}

/// Severity of this alert.
class Alert_SeverityLevel extends $pb.ProtobufEnum {
  static const Alert_SeverityLevel UNKNOWN_SEVERITY =
      Alert_SeverityLevel._(1, _omitEnumNames ? '' : 'UNKNOWN_SEVERITY');
  static const Alert_SeverityLevel INFO =
      Alert_SeverityLevel._(2, _omitEnumNames ? '' : 'INFO');
  static const Alert_SeverityLevel WARNING =
      Alert_SeverityLevel._(3, _omitEnumNames ? '' : 'WARNING');
  static const Alert_SeverityLevel SEVERE =
      Alert_SeverityLevel._(4, _omitEnumNames ? '' : 'SEVERE');

  static const $core.List<Alert_SeverityLevel> values = <Alert_SeverityLevel>[
    UNKNOWN_SEVERITY,
    INFO,
    WARNING,
    SEVERE,
  ];

  static final $core.List<Alert_SeverityLevel?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static Alert_SeverityLevel? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Alert_SeverityLevel._(super.value, super.name);
}

/// The relation between this trip and the static schedule. If a trip is done
/// in accordance with temporary schedule, not reflected in GTFS, then it
/// shouldn't be marked as SCHEDULED, but likely as ADDED.
class TripDescriptor_ScheduleRelationship extends $pb.ProtobufEnum {
  /// Trip that is running in accordance with its GTFS schedule, or is close
  /// enough to the scheduled trip to be associated with it.
  static const TripDescriptor_ScheduleRelationship SCHEDULED =
      TripDescriptor_ScheduleRelationship._(
          0, _omitEnumNames ? '' : 'SCHEDULED');

  /// This value has been deprecated as the behavior was unspecified.
  /// Use DUPLICATED for an extra trip that is the same as a scheduled trip except the start date or time,
  /// or NEW for an extra trip that is unrelated to an existing trip.
  @$core.Deprecated('This enum value is deprecated')
  static const TripDescriptor_ScheduleRelationship ADDED =
      TripDescriptor_ScheduleRelationship._(1, _omitEnumNames ? '' : 'ADDED');

  /// A trip that is running with no schedule associated to it (GTFS frequencies.txt exact_times=0).
  /// Trips with ScheduleRelationship=UNSCHEDULED must also set all StopTimeUpdates.ScheduleRelationship=UNSCHEDULED.
  static const TripDescriptor_ScheduleRelationship UNSCHEDULED =
      TripDescriptor_ScheduleRelationship._(
          2, _omitEnumNames ? '' : 'UNSCHEDULED');

  /// A trip that existed in the schedule but was removed.
  static const TripDescriptor_ScheduleRelationship CANCELED =
      TripDescriptor_ScheduleRelationship._(
          3, _omitEnumNames ? '' : 'CANCELED');

  /// A trip that replaces an existing trip in the schedule.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  static const TripDescriptor_ScheduleRelationship REPLACEMENT =
      TripDescriptor_ScheduleRelationship._(
          5, _omitEnumNames ? '' : 'REPLACEMENT');

  /// An extra trip that was added in addition to a running schedule, for example, to replace a broken vehicle or to
  /// respond to sudden passenger load. Used with TripUpdate.TripProperties.trip_id, TripUpdate.TripProperties.start_date,
  /// and TripUpdate.TripProperties.start_time to copy an existing trip from static GTFS but start at a different service
  /// date and/or time. Duplicating a trip is allowed if the service related to the original trip in (CSV) GTFS
  /// (in calendar.txt or calendar_dates.txt) is operating within the next 30 days. The trip to be duplicated is
  /// identified via TripUpdate.TripDescriptor.trip_id. This enumeration does not modify the existing trip referenced by
  /// TripUpdate.TripDescriptor.trip_id - if a producer wants to cancel the original trip, it must publish a separate
  /// TripUpdate with the value of CANCELED or DELETED. If a producer wants to replace the original trip, a value of
  /// `REPLACEMENT` should be used instead.
  ///
  /// Trips defined in GTFS frequencies.txt with exact_times that is
  /// empty or equal to 0 cannot be duplicated. The VehiclePosition.TripDescriptor.trip_id for the new trip must contain
  /// the matching value from TripUpdate.TripProperties.trip_id and VehiclePosition.TripDescriptor.ScheduleRelationship
  /// must also be set to DUPLICATED.
  /// Existing producers and consumers that were using the ADDED enumeration to represent duplicated trips must follow
  /// the migration guide (https://github.com/google/transit/tree/master/gtfs-realtime/spec/en/examples/migration-duplicated.md)
  /// to transition to the DUPLICATED enumeration.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  static const TripDescriptor_ScheduleRelationship DUPLICATED =
      TripDescriptor_ScheduleRelationship._(
          6, _omitEnumNames ? '' : 'DUPLICATED');

  /// A trip that existed in the schedule but was removed and must not be shown to users.
  /// DELETED should be used instead of CANCELED to indicate that a transit provider would like to entirely remove
  /// information about the corresponding trip from consuming applications, so the trip is not shown as cancelled to
  /// riders, e.g. a trip that is entirely being replaced by another trip.
  /// This designation becomes particularly important if several trips are cancelled and replaced with substitute service.
  /// If consumers were to show explicit information about the cancellations it would distract from the more important
  /// real-time predictions.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  static const TripDescriptor_ScheduleRelationship DELETED =
      TripDescriptor_ScheduleRelationship._(7, _omitEnumNames ? '' : 'DELETED');

  /// An extra trip unrelated to any existing trips, for example, to respond to sudden passenger load.
  /// NOTE: This field is still experimental, and subject to change. It may be formally adopted in the future.
  static const TripDescriptor_ScheduleRelationship NEW =
      TripDescriptor_ScheduleRelationship._(8, _omitEnumNames ? '' : 'NEW');

  static const $core.List<TripDescriptor_ScheduleRelationship> values =
      <TripDescriptor_ScheduleRelationship>[
    SCHEDULED,
    ADDED,
    UNSCHEDULED,
    CANCELED,
    REPLACEMENT,
    DUPLICATED,
    DELETED,
    NEW,
  ];

  static final $core.List<TripDescriptor_ScheduleRelationship?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 8);
  static TripDescriptor_ScheduleRelationship? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TripDescriptor_ScheduleRelationship._(super.value, super.name);
}

class VehicleDescriptor_WheelchairAccessible extends $pb.ProtobufEnum {
  /// The trip doesn't have information about wheelchair accessibility.
  /// This is the **default** behavior. If the static GTFS contains a
  /// _wheelchair_accessible_ value, it won't be overwritten.
  static const VehicleDescriptor_WheelchairAccessible NO_VALUE =
      VehicleDescriptor_WheelchairAccessible._(
          0, _omitEnumNames ? '' : 'NO_VALUE');

  /// The trip has no accessibility value present.
  /// This value will overwrite the value from the GTFS.
  static const VehicleDescriptor_WheelchairAccessible UNKNOWN =
      VehicleDescriptor_WheelchairAccessible._(
          1, _omitEnumNames ? '' : 'UNKNOWN');

  /// The trip is wheelchair accessible.
  /// This value will overwrite the value from the GTFS.
  static const VehicleDescriptor_WheelchairAccessible WHEELCHAIR_ACCESSIBLE =
      VehicleDescriptor_WheelchairAccessible._(
          2, _omitEnumNames ? '' : 'WHEELCHAIR_ACCESSIBLE');

  /// The trip is **not** wheelchair accessible.
  /// This value will overwrite the value from the GTFS.
  static const VehicleDescriptor_WheelchairAccessible WHEELCHAIR_INACCESSIBLE =
      VehicleDescriptor_WheelchairAccessible._(
          3, _omitEnumNames ? '' : 'WHEELCHAIR_INACCESSIBLE');

  static const $core.List<VehicleDescriptor_WheelchairAccessible> values =
      <VehicleDescriptor_WheelchairAccessible>[
    NO_VALUE,
    UNKNOWN,
    WHEELCHAIR_ACCESSIBLE,
    WHEELCHAIR_INACCESSIBLE,
  ];

  static final $core.List<VehicleDescriptor_WheelchairAccessible?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static VehicleDescriptor_WheelchairAccessible? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const VehicleDescriptor_WheelchairAccessible._(super.value, super.name);
}

class Stop_WheelchairBoarding extends $pb.ProtobufEnum {
  static const Stop_WheelchairBoarding UNKNOWN =
      Stop_WheelchairBoarding._(0, _omitEnumNames ? '' : 'UNKNOWN');
  static const Stop_WheelchairBoarding AVAILABLE =
      Stop_WheelchairBoarding._(1, _omitEnumNames ? '' : 'AVAILABLE');
  static const Stop_WheelchairBoarding NOT_AVAILABLE =
      Stop_WheelchairBoarding._(2, _omitEnumNames ? '' : 'NOT_AVAILABLE');

  static const $core.List<Stop_WheelchairBoarding> values =
      <Stop_WheelchairBoarding>[
    UNKNOWN,
    AVAILABLE,
    NOT_AVAILABLE,
  ];

  static final $core.List<Stop_WheelchairBoarding?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static Stop_WheelchairBoarding? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const Stop_WheelchairBoarding._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
