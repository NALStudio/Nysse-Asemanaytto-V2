//
//  Generated code. Do not modify.
//  source: gtfs-realtime.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use feedMessageDescriptor instead')
const FeedMessage$json = {
  '1': 'FeedMessage',
  '2': [
    {'1': 'header', '3': 1, '4': 2, '5': 11, '6': '.transit_realtime.FeedHeader', '10': 'header'},
    {'1': 'entity', '3': 2, '4': 3, '5': 11, '6': '.transit_realtime.FeedEntity', '10': 'entity'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `FeedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feedMessageDescriptor = $convert.base64Decode(
    'CgtGZWVkTWVzc2FnZRI0CgZoZWFkZXIYASACKAsyHC50cmFuc2l0X3JlYWx0aW1lLkZlZWRIZW'
    'FkZXJSBmhlYWRlchI0CgZlbnRpdHkYAiADKAsyHC50cmFuc2l0X3JlYWx0aW1lLkZlZWRFbnRp'
    'dHlSBmVudGl0eSoGCOgHENAPKgYIqEYQkE4=');

@$core.Deprecated('Use feedHeaderDescriptor instead')
const FeedHeader$json = {
  '1': 'FeedHeader',
  '2': [
    {'1': 'gtfs_realtime_version', '3': 1, '4': 2, '5': 9, '10': 'gtfsRealtimeVersion'},
    {'1': 'incrementality', '3': 2, '4': 1, '5': 14, '6': '.transit_realtime.FeedHeader.Incrementality', '7': 'FULL_DATASET', '10': 'incrementality'},
    {'1': 'timestamp', '3': 3, '4': 1, '5': 4, '10': 'timestamp'},
  ],
  '4': [FeedHeader_Incrementality$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use feedHeaderDescriptor instead')
const FeedHeader_Incrementality$json = {
  '1': 'Incrementality',
  '2': [
    {'1': 'FULL_DATASET', '2': 0},
    {'1': 'DIFFERENTIAL', '2': 1},
  ],
};

/// Descriptor for `FeedHeader`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feedHeaderDescriptor = $convert.base64Decode(
    'CgpGZWVkSGVhZGVyEjIKFWd0ZnNfcmVhbHRpbWVfdmVyc2lvbhgBIAIoCVITZ3Rmc1JlYWx0aW'
    '1lVmVyc2lvbhJhCg5pbmNyZW1lbnRhbGl0eRgCIAEoDjIrLnRyYW5zaXRfcmVhbHRpbWUuRmVl'
    'ZEhlYWRlci5JbmNyZW1lbnRhbGl0eToMRlVMTF9EQVRBU0VUUg5pbmNyZW1lbnRhbGl0eRIcCg'
    'l0aW1lc3RhbXAYAyABKARSCXRpbWVzdGFtcCI0Cg5JbmNyZW1lbnRhbGl0eRIQCgxGVUxMX0RB'
    'VEFTRVQQABIQCgxESUZGRVJFTlRJQUwQASoGCOgHENAPKgYIqEYQkE4=');

@$core.Deprecated('Use feedEntityDescriptor instead')
const FeedEntity$json = {
  '1': 'FeedEntity',
  '2': [
    {'1': 'id', '3': 1, '4': 2, '5': 9, '10': 'id'},
    {'1': 'is_deleted', '3': 2, '4': 1, '5': 8, '7': 'false', '10': 'isDeleted'},
    {'1': 'trip_update', '3': 3, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate', '10': 'tripUpdate'},
    {'1': 'vehicle', '3': 4, '4': 1, '5': 11, '6': '.transit_realtime.VehiclePosition', '10': 'vehicle'},
    {'1': 'alert', '3': 5, '4': 1, '5': 11, '6': '.transit_realtime.Alert', '10': 'alert'},
    {'1': 'shape', '3': 6, '4': 1, '5': 11, '6': '.transit_realtime.Shape', '10': 'shape'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `FeedEntity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feedEntityDescriptor = $convert.base64Decode(
    'CgpGZWVkRW50aXR5Eg4KAmlkGAEgAigJUgJpZBIkCgppc19kZWxldGVkGAIgASgIOgVmYWxzZV'
    'IJaXNEZWxldGVkEj0KC3RyaXBfdXBkYXRlGAMgASgLMhwudHJhbnNpdF9yZWFsdGltZS5Ucmlw'
    'VXBkYXRlUgp0cmlwVXBkYXRlEjsKB3ZlaGljbGUYBCABKAsyIS50cmFuc2l0X3JlYWx0aW1lLl'
    'ZlaGljbGVQb3NpdGlvblIHdmVoaWNsZRItCgVhbGVydBgFIAEoCzIXLnRyYW5zaXRfcmVhbHRp'
    'bWUuQWxlcnRSBWFsZXJ0Ei0KBXNoYXBlGAYgASgLMhcudHJhbnNpdF9yZWFsdGltZS5TaGFwZV'
    'IFc2hhcGUqBgjoBxDQDyoGCKhGEJBO');

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate$json = {
  '1': 'TripUpdate',
  '2': [
    {'1': 'trip', '3': 1, '4': 2, '5': 11, '6': '.transit_realtime.TripDescriptor', '10': 'trip'},
    {'1': 'vehicle', '3': 3, '4': 1, '5': 11, '6': '.transit_realtime.VehicleDescriptor', '10': 'vehicle'},
    {'1': 'stop_time_update', '3': 2, '4': 3, '5': 11, '6': '.transit_realtime.TripUpdate.StopTimeUpdate', '10': 'stopTimeUpdate'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'delay', '3': 5, '4': 1, '5': 5, '10': 'delay'},
    {'1': 'trip_properties', '3': 6, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate.TripProperties', '10': 'tripProperties'},
  ],
  '3': [TripUpdate_StopTimeEvent$json, TripUpdate_StopTimeUpdate$json, TripUpdate_TripProperties$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_StopTimeEvent$json = {
  '1': 'StopTimeEvent',
  '2': [
    {'1': 'delay', '3': 1, '4': 1, '5': 5, '10': 'delay'},
    {'1': 'time', '3': 2, '4': 1, '5': 3, '10': 'time'},
    {'1': 'uncertainty', '3': 3, '4': 1, '5': 5, '10': 'uncertainty'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_StopTimeUpdate$json = {
  '1': 'StopTimeUpdate',
  '2': [
    {'1': 'stop_sequence', '3': 1, '4': 1, '5': 13, '10': 'stopSequence'},
    {'1': 'stop_id', '3': 4, '4': 1, '5': 9, '10': 'stopId'},
    {'1': 'arrival', '3': 2, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate.StopTimeEvent', '10': 'arrival'},
    {'1': 'departure', '3': 3, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate.StopTimeEvent', '10': 'departure'},
    {'1': 'departure_occupancy_status', '3': 7, '4': 1, '5': 14, '6': '.transit_realtime.VehiclePosition.OccupancyStatus', '10': 'departureOccupancyStatus'},
    {'1': 'schedule_relationship', '3': 5, '4': 1, '5': 14, '6': '.transit_realtime.TripUpdate.StopTimeUpdate.ScheduleRelationship', '7': 'SCHEDULED', '10': 'scheduleRelationship'},
    {'1': 'stop_time_properties', '3': 6, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate.StopTimeUpdate.StopTimeProperties', '10': 'stopTimeProperties'},
  ],
  '3': [TripUpdate_StopTimeUpdate_StopTimeProperties$json],
  '4': [TripUpdate_StopTimeUpdate_ScheduleRelationship$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_StopTimeUpdate_StopTimeProperties$json = {
  '1': 'StopTimeProperties',
  '2': [
    {'1': 'assigned_stop_id', '3': 1, '4': 1, '5': 9, '10': 'assignedStopId'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_StopTimeUpdate_ScheduleRelationship$json = {
  '1': 'ScheduleRelationship',
  '2': [
    {'1': 'SCHEDULED', '2': 0},
    {'1': 'SKIPPED', '2': 1},
    {'1': 'NO_DATA', '2': 2},
    {'1': 'UNSCHEDULED', '2': 3},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_TripProperties$json = {
  '1': 'TripProperties',
  '2': [
    {'1': 'trip_id', '3': 1, '4': 1, '5': 9, '10': 'tripId'},
    {'1': 'start_date', '3': 2, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'start_time', '3': 3, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'shape_id', '3': 4, '4': 1, '5': 9, '10': 'shapeId'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `TripUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripUpdateDescriptor = $convert.base64Decode(
    'CgpUcmlwVXBkYXRlEjQKBHRyaXAYASACKAsyIC50cmFuc2l0X3JlYWx0aW1lLlRyaXBEZXNjcm'
    'lwdG9yUgR0cmlwEj0KB3ZlaGljbGUYAyABKAsyIy50cmFuc2l0X3JlYWx0aW1lLlZlaGljbGVE'
    'ZXNjcmlwdG9yUgd2ZWhpY2xlElUKEHN0b3BfdGltZV91cGRhdGUYAiADKAsyKy50cmFuc2l0X3'
    'JlYWx0aW1lLlRyaXBVcGRhdGUuU3RvcFRpbWVVcGRhdGVSDnN0b3BUaW1lVXBkYXRlEhwKCXRp'
    'bWVzdGFtcBgEIAEoBFIJdGltZXN0YW1wEhQKBWRlbGF5GAUgASgFUgVkZWxheRJUCg90cmlwX3'
    'Byb3BlcnRpZXMYBiABKAsyKy50cmFuc2l0X3JlYWx0aW1lLlRyaXBVcGRhdGUuVHJpcFByb3Bl'
    'cnRpZXNSDnRyaXBQcm9wZXJ0aWVzGmsKDVN0b3BUaW1lRXZlbnQSFAoFZGVsYXkYASABKAVSBW'
    'RlbGF5EhIKBHRpbWUYAiABKANSBHRpbWUSIAoLdW5jZXJ0YWludHkYAyABKAVSC3VuY2VydGFp'
    'bnR5KgYI6AcQ0A8qBgioRhCQThr2BQoOU3RvcFRpbWVVcGRhdGUSIwoNc3RvcF9zZXF1ZW5jZR'
    'gBIAEoDVIMc3RvcFNlcXVlbmNlEhcKB3N0b3BfaWQYBCABKAlSBnN0b3BJZBJECgdhcnJpdmFs'
    'GAIgASgLMioudHJhbnNpdF9yZWFsdGltZS5UcmlwVXBkYXRlLlN0b3BUaW1lRXZlbnRSB2Fycm'
    'l2YWwSSAoJZGVwYXJ0dXJlGAMgASgLMioudHJhbnNpdF9yZWFsdGltZS5UcmlwVXBkYXRlLlN0'
    'b3BUaW1lRXZlbnRSCWRlcGFydHVyZRJvChpkZXBhcnR1cmVfb2NjdXBhbmN5X3N0YXR1cxgHIA'
    'EoDjIxLnRyYW5zaXRfcmVhbHRpbWUuVmVoaWNsZVBvc2l0aW9uLk9jY3VwYW5jeVN0YXR1c1IY'
    'ZGVwYXJ0dXJlT2NjdXBhbmN5U3RhdHVzEoABChVzY2hlZHVsZV9yZWxhdGlvbnNoaXAYBSABKA'
    '4yQC50cmFuc2l0X3JlYWx0aW1lLlRyaXBVcGRhdGUuU3RvcFRpbWVVcGRhdGUuU2NoZWR1bGVS'
    'ZWxhdGlvbnNoaXA6CVNDSEVEVUxFRFIUc2NoZWR1bGVSZWxhdGlvbnNoaXAScAoUc3RvcF90aW'
    '1lX3Byb3BlcnRpZXMYBiABKAsyPi50cmFuc2l0X3JlYWx0aW1lLlRyaXBVcGRhdGUuU3RvcFRp'
    'bWVVcGRhdGUuU3RvcFRpbWVQcm9wZXJ0aWVzUhJzdG9wVGltZVByb3BlcnRpZXMaTgoSU3RvcF'
    'RpbWVQcm9wZXJ0aWVzEigKEGFzc2lnbmVkX3N0b3BfaWQYASABKAlSDmFzc2lnbmVkU3RvcElk'
    'KgYI6AcQ0A8qBgioRhCQTiJQChRTY2hlZHVsZVJlbGF0aW9uc2hpcBINCglTQ0hFRFVMRUQQAB'
    'ILCgdTS0lQUEVEEAESCwoHTk9fREFUQRACEg8KC1VOU0NIRURVTEVEEAMqBgjoBxDQDyoGCKhG'
    'EJBOGpIBCg5UcmlwUHJvcGVydGllcxIXCgd0cmlwX2lkGAEgASgJUgZ0cmlwSWQSHQoKc3Rhcn'
    'RfZGF0ZRgCIAEoCVIJc3RhcnREYXRlEh0KCnN0YXJ0X3RpbWUYAyABKAlSCXN0YXJ0VGltZRIZ'
    'CghzaGFwZV9pZBgEIAEoCVIHc2hhcGVJZCoGCOgHENAPKgYIqEYQkE4qBgjoBxDQDyoGCKhGEJ'
    'BO');

@$core.Deprecated('Use vehiclePositionDescriptor instead')
const VehiclePosition$json = {
  '1': 'VehiclePosition',
  '2': [
    {'1': 'trip', '3': 1, '4': 1, '5': 11, '6': '.transit_realtime.TripDescriptor', '10': 'trip'},
    {'1': 'vehicle', '3': 8, '4': 1, '5': 11, '6': '.transit_realtime.VehicleDescriptor', '10': 'vehicle'},
    {'1': 'position', '3': 2, '4': 1, '5': 11, '6': '.transit_realtime.Position', '10': 'position'},
    {'1': 'current_stop_sequence', '3': 3, '4': 1, '5': 13, '10': 'currentStopSequence'},
    {'1': 'stop_id', '3': 7, '4': 1, '5': 9, '10': 'stopId'},
    {'1': 'current_status', '3': 4, '4': 1, '5': 14, '6': '.transit_realtime.VehiclePosition.VehicleStopStatus', '7': 'IN_TRANSIT_TO', '10': 'currentStatus'},
    {'1': 'timestamp', '3': 5, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'congestion_level', '3': 6, '4': 1, '5': 14, '6': '.transit_realtime.VehiclePosition.CongestionLevel', '10': 'congestionLevel'},
    {'1': 'occupancy_status', '3': 9, '4': 1, '5': 14, '6': '.transit_realtime.VehiclePosition.OccupancyStatus', '10': 'occupancyStatus'},
    {'1': 'occupancy_percentage', '3': 10, '4': 1, '5': 13, '10': 'occupancyPercentage'},
    {'1': 'multi_carriage_details', '3': 11, '4': 3, '5': 11, '6': '.transit_realtime.VehiclePosition.CarriageDetails', '10': 'multiCarriageDetails'},
  ],
  '3': [VehiclePosition_CarriageDetails$json],
  '4': [VehiclePosition_VehicleStopStatus$json, VehiclePosition_CongestionLevel$json, VehiclePosition_OccupancyStatus$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use vehiclePositionDescriptor instead')
const VehiclePosition_CarriageDetails$json = {
  '1': 'CarriageDetails',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'occupancy_status', '3': 3, '4': 1, '5': 14, '6': '.transit_realtime.VehiclePosition.OccupancyStatus', '7': 'NO_DATA_AVAILABLE', '10': 'occupancyStatus'},
    {'1': 'occupancy_percentage', '3': 4, '4': 1, '5': 5, '7': '-1', '10': 'occupancyPercentage'},
    {'1': 'carriage_sequence', '3': 5, '4': 1, '5': 13, '10': 'carriageSequence'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use vehiclePositionDescriptor instead')
const VehiclePosition_VehicleStopStatus$json = {
  '1': 'VehicleStopStatus',
  '2': [
    {'1': 'INCOMING_AT', '2': 0},
    {'1': 'STOPPED_AT', '2': 1},
    {'1': 'IN_TRANSIT_TO', '2': 2},
  ],
};

@$core.Deprecated('Use vehiclePositionDescriptor instead')
const VehiclePosition_CongestionLevel$json = {
  '1': 'CongestionLevel',
  '2': [
    {'1': 'UNKNOWN_CONGESTION_LEVEL', '2': 0},
    {'1': 'RUNNING_SMOOTHLY', '2': 1},
    {'1': 'STOP_AND_GO', '2': 2},
    {'1': 'CONGESTION', '2': 3},
    {'1': 'SEVERE_CONGESTION', '2': 4},
  ],
};

@$core.Deprecated('Use vehiclePositionDescriptor instead')
const VehiclePosition_OccupancyStatus$json = {
  '1': 'OccupancyStatus',
  '2': [
    {'1': 'EMPTY', '2': 0},
    {'1': 'MANY_SEATS_AVAILABLE', '2': 1},
    {'1': 'FEW_SEATS_AVAILABLE', '2': 2},
    {'1': 'STANDING_ROOM_ONLY', '2': 3},
    {'1': 'CRUSHED_STANDING_ROOM_ONLY', '2': 4},
    {'1': 'FULL', '2': 5},
    {'1': 'NOT_ACCEPTING_PASSENGERS', '2': 6},
    {'1': 'NO_DATA_AVAILABLE', '2': 7},
    {'1': 'NOT_BOARDABLE', '2': 8},
  ],
};

/// Descriptor for `VehiclePosition`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vehiclePositionDescriptor = $convert.base64Decode(
    'Cg9WZWhpY2xlUG9zaXRpb24SNAoEdHJpcBgBIAEoCzIgLnRyYW5zaXRfcmVhbHRpbWUuVHJpcE'
    'Rlc2NyaXB0b3JSBHRyaXASPQoHdmVoaWNsZRgIIAEoCzIjLnRyYW5zaXRfcmVhbHRpbWUuVmVo'
    'aWNsZURlc2NyaXB0b3JSB3ZlaGljbGUSNgoIcG9zaXRpb24YAiABKAsyGi50cmFuc2l0X3JlYW'
    'x0aW1lLlBvc2l0aW9uUghwb3NpdGlvbhIyChVjdXJyZW50X3N0b3Bfc2VxdWVuY2UYAyABKA1S'
    'E2N1cnJlbnRTdG9wU2VxdWVuY2USFwoHc3RvcF9pZBgHIAEoCVIGc3RvcElkEmkKDmN1cnJlbn'
    'Rfc3RhdHVzGAQgASgOMjMudHJhbnNpdF9yZWFsdGltZS5WZWhpY2xlUG9zaXRpb24uVmVoaWNs'
    'ZVN0b3BTdGF0dXM6DUlOX1RSQU5TSVRfVE9SDWN1cnJlbnRTdGF0dXMSHAoJdGltZXN0YW1wGA'
    'UgASgEUgl0aW1lc3RhbXASXAoQY29uZ2VzdGlvbl9sZXZlbBgGIAEoDjIxLnRyYW5zaXRfcmVh'
    'bHRpbWUuVmVoaWNsZVBvc2l0aW9uLkNvbmdlc3Rpb25MZXZlbFIPY29uZ2VzdGlvbkxldmVsEl'
    'wKEG9jY3VwYW5jeV9zdGF0dXMYCSABKA4yMS50cmFuc2l0X3JlYWx0aW1lLlZlaGljbGVQb3Np'
    'dGlvbi5PY2N1cGFuY3lTdGF0dXNSD29jY3VwYW5jeVN0YXR1cxIxChRvY2N1cGFuY3lfcGVyY2'
    'VudGFnZRgKIAEoDVITb2NjdXBhbmN5UGVyY2VudGFnZRJnChZtdWx0aV9jYXJyaWFnZV9kZXRh'
    'aWxzGAsgAygLMjEudHJhbnNpdF9yZWFsdGltZS5WZWhpY2xlUG9zaXRpb24uQ2FycmlhZ2VEZX'
    'RhaWxzUhRtdWx0aUNhcnJpYWdlRGV0YWlscxqcAgoPQ2FycmlhZ2VEZXRhaWxzEg4KAmlkGAEg'
    'ASgJUgJpZBIUCgVsYWJlbBgCIAEoCVIFbGFiZWwSbwoQb2NjdXBhbmN5X3N0YXR1cxgDIAEoDj'
    'IxLnRyYW5zaXRfcmVhbHRpbWUuVmVoaWNsZVBvc2l0aW9uLk9jY3VwYW5jeVN0YXR1czoRTk9f'
    'REFUQV9BVkFJTEFCTEVSD29jY3VwYW5jeVN0YXR1cxI1ChRvY2N1cGFuY3lfcGVyY2VudGFnZR'
    'gEIAEoBToCLTFSE29jY3VwYW5jeVBlcmNlbnRhZ2USKwoRY2FycmlhZ2Vfc2VxdWVuY2UYBSAB'
    'KA1SEGNhcnJpYWdlU2VxdWVuY2UqBgjoBxDQDyoGCKhGEJBOIkcKEVZlaGljbGVTdG9wU3RhdH'
    'VzEg8KC0lOQ09NSU5HX0FUEAASDgoKU1RPUFBFRF9BVBABEhEKDUlOX1RSQU5TSVRfVE8QAiJ9'
    'Cg9Db25nZXN0aW9uTGV2ZWwSHAoYVU5LTk9XTl9DT05HRVNUSU9OX0xFVkVMEAASFAoQUlVOTk'
    'lOR19TTU9PVEhMWRABEg8KC1NUT1BfQU5EX0dPEAISDgoKQ09OR0VTVElPThADEhUKEVNFVkVS'
    'RV9DT05HRVNUSU9OEAQi2QEKD09jY3VwYW5jeVN0YXR1cxIJCgVFTVBUWRAAEhgKFE1BTllfU0'
    'VBVFNfQVZBSUxBQkxFEAESFwoTRkVXX1NFQVRTX0FWQUlMQUJMRRACEhYKElNUQU5ESU5HX1JP'
    'T01fT05MWRADEh4KGkNSVVNIRURfU1RBTkRJTkdfUk9PTV9PTkxZEAQSCAoERlVMTBAFEhwKGE'
    '5PVF9BQ0NFUFRJTkdfUEFTU0VOR0VSUxAGEhUKEU5PX0RBVEFfQVZBSUxBQkxFEAcSEQoNTk9U'
    'X0JPQVJEQUJMRRAIKgYI6AcQ0A8qBgioRhCQTg==');

@$core.Deprecated('Use alertDescriptor instead')
const Alert$json = {
  '1': 'Alert',
  '2': [
    {'1': 'active_period', '3': 1, '4': 3, '5': 11, '6': '.transit_realtime.TimeRange', '10': 'activePeriod'},
    {'1': 'informed_entity', '3': 5, '4': 3, '5': 11, '6': '.transit_realtime.EntitySelector', '10': 'informedEntity'},
    {'1': 'cause', '3': 6, '4': 1, '5': 14, '6': '.transit_realtime.Alert.Cause', '7': 'UNKNOWN_CAUSE', '10': 'cause'},
    {'1': 'effect', '3': 7, '4': 1, '5': 14, '6': '.transit_realtime.Alert.Effect', '7': 'UNKNOWN_EFFECT', '10': 'effect'},
    {'1': 'url', '3': 8, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'url'},
    {'1': 'header_text', '3': 10, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'headerText'},
    {'1': 'description_text', '3': 11, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'descriptionText'},
    {'1': 'tts_header_text', '3': 12, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'ttsHeaderText'},
    {'1': 'tts_description_text', '3': 13, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'ttsDescriptionText'},
    {'1': 'severity_level', '3': 14, '4': 1, '5': 14, '6': '.transit_realtime.Alert.SeverityLevel', '7': 'UNKNOWN_SEVERITY', '10': 'severityLevel'},
    {'1': 'image', '3': 15, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedImage', '10': 'image'},
    {'1': 'image_alternative_text', '3': 16, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'imageAlternativeText'},
    {'1': 'cause_detail', '3': 17, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'causeDetail'},
    {'1': 'effect_detail', '3': 18, '4': 1, '5': 11, '6': '.transit_realtime.TranslatedString', '10': 'effectDetail'},
  ],
  '4': [Alert_Cause$json, Alert_Effect$json, Alert_SeverityLevel$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use alertDescriptor instead')
const Alert_Cause$json = {
  '1': 'Cause',
  '2': [
    {'1': 'UNKNOWN_CAUSE', '2': 1},
    {'1': 'OTHER_CAUSE', '2': 2},
    {'1': 'TECHNICAL_PROBLEM', '2': 3},
    {'1': 'STRIKE', '2': 4},
    {'1': 'DEMONSTRATION', '2': 5},
    {'1': 'ACCIDENT', '2': 6},
    {'1': 'HOLIDAY', '2': 7},
    {'1': 'WEATHER', '2': 8},
    {'1': 'MAINTENANCE', '2': 9},
    {'1': 'CONSTRUCTION', '2': 10},
    {'1': 'POLICE_ACTIVITY', '2': 11},
    {'1': 'MEDICAL_EMERGENCY', '2': 12},
  ],
};

@$core.Deprecated('Use alertDescriptor instead')
const Alert_Effect$json = {
  '1': 'Effect',
  '2': [
    {'1': 'NO_SERVICE', '2': 1},
    {'1': 'REDUCED_SERVICE', '2': 2},
    {'1': 'SIGNIFICANT_DELAYS', '2': 3},
    {'1': 'DETOUR', '2': 4},
    {'1': 'ADDITIONAL_SERVICE', '2': 5},
    {'1': 'MODIFIED_SERVICE', '2': 6},
    {'1': 'OTHER_EFFECT', '2': 7},
    {'1': 'UNKNOWN_EFFECT', '2': 8},
    {'1': 'STOP_MOVED', '2': 9},
    {'1': 'NO_EFFECT', '2': 10},
    {'1': 'ACCESSIBILITY_ISSUE', '2': 11},
  ],
};

@$core.Deprecated('Use alertDescriptor instead')
const Alert_SeverityLevel$json = {
  '1': 'SeverityLevel',
  '2': [
    {'1': 'UNKNOWN_SEVERITY', '2': 1},
    {'1': 'INFO', '2': 2},
    {'1': 'WARNING', '2': 3},
    {'1': 'SEVERE', '2': 4},
  ],
};

/// Descriptor for `Alert`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List alertDescriptor = $convert.base64Decode(
    'CgVBbGVydBJACg1hY3RpdmVfcGVyaW9kGAEgAygLMhsudHJhbnNpdF9yZWFsdGltZS5UaW1lUm'
    'FuZ2VSDGFjdGl2ZVBlcmlvZBJJCg9pbmZvcm1lZF9lbnRpdHkYBSADKAsyIC50cmFuc2l0X3Jl'
    'YWx0aW1lLkVudGl0eVNlbGVjdG9yUg5pbmZvcm1lZEVudGl0eRJCCgVjYXVzZRgGIAEoDjIdLn'
    'RyYW5zaXRfcmVhbHRpbWUuQWxlcnQuQ2F1c2U6DVVOS05PV05fQ0FVU0VSBWNhdXNlEkYKBmVm'
    'ZmVjdBgHIAEoDjIeLnRyYW5zaXRfcmVhbHRpbWUuQWxlcnQuRWZmZWN0Og5VTktOT1dOX0VGRk'
    'VDVFIGZWZmZWN0EjQKA3VybBgIIAEoCzIiLnRyYW5zaXRfcmVhbHRpbWUuVHJhbnNsYXRlZFN0'
    'cmluZ1IDdXJsEkMKC2hlYWRlcl90ZXh0GAogASgLMiIudHJhbnNpdF9yZWFsdGltZS5UcmFuc2'
    'xhdGVkU3RyaW5nUgpoZWFkZXJUZXh0Ek0KEGRlc2NyaXB0aW9uX3RleHQYCyABKAsyIi50cmFu'
    'c2l0X3JlYWx0aW1lLlRyYW5zbGF0ZWRTdHJpbmdSD2Rlc2NyaXB0aW9uVGV4dBJKCg90dHNfaG'
    'VhZGVyX3RleHQYDCABKAsyIi50cmFuc2l0X3JlYWx0aW1lLlRyYW5zbGF0ZWRTdHJpbmdSDXR0'
    'c0hlYWRlclRleHQSVAoUdHRzX2Rlc2NyaXB0aW9uX3RleHQYDSABKAsyIi50cmFuc2l0X3JlYW'
    'x0aW1lLlRyYW5zbGF0ZWRTdHJpbmdSEnR0c0Rlc2NyaXB0aW9uVGV4dBJeCg5zZXZlcml0eV9s'
    'ZXZlbBgOIAEoDjIlLnRyYW5zaXRfcmVhbHRpbWUuQWxlcnQuU2V2ZXJpdHlMZXZlbDoQVU5LTk'
    '9XTl9TRVZFUklUWVINc2V2ZXJpdHlMZXZlbBI3CgVpbWFnZRgPIAEoCzIhLnRyYW5zaXRfcmVh'
    'bHRpbWUuVHJhbnNsYXRlZEltYWdlUgVpbWFnZRJYChZpbWFnZV9hbHRlcm5hdGl2ZV90ZXh0GB'
    'AgASgLMiIudHJhbnNpdF9yZWFsdGltZS5UcmFuc2xhdGVkU3RyaW5nUhRpbWFnZUFsdGVybmF0'
    'aXZlVGV4dBJFCgxjYXVzZV9kZXRhaWwYESABKAsyIi50cmFuc2l0X3JlYWx0aW1lLlRyYW5zbG'
    'F0ZWRTdHJpbmdSC2NhdXNlRGV0YWlsEkcKDWVmZmVjdF9kZXRhaWwYEiABKAsyIi50cmFuc2l0'
    'X3JlYWx0aW1lLlRyYW5zbGF0ZWRTdHJpbmdSDGVmZmVjdERldGFpbCLYAQoFQ2F1c2USEQoNVU'
    '5LTk9XTl9DQVVTRRABEg8KC09USEVSX0NBVVNFEAISFQoRVEVDSE5JQ0FMX1BST0JMRU0QAxIK'
    'CgZTVFJJS0UQBBIRCg1ERU1PTlNUUkFUSU9OEAUSDAoIQUNDSURFTlQQBhILCgdIT0xJREFZEA'
    'cSCwoHV0VBVEhFUhAIEg8KC01BSU5URU5BTkNFEAkSEAoMQ09OU1RSVUNUSU9OEAoSEwoPUE9M'
    'SUNFX0FDVElWSVRZEAsSFQoRTUVESUNBTF9FTUVSR0VOQ1kQDCLdAQoGRWZmZWN0Eg4KCk5PX1'
    'NFUlZJQ0UQARITCg9SRURVQ0VEX1NFUlZJQ0UQAhIWChJTSUdOSUZJQ0FOVF9ERUxBWVMQAxIK'
    'CgZERVRPVVIQBBIWChJBRERJVElPTkFMX1NFUlZJQ0UQBRIUChBNT0RJRklFRF9TRVJWSUNFEA'
    'YSEAoMT1RIRVJfRUZGRUNUEAcSEgoOVU5LTk9XTl9FRkZFQ1QQCBIOCgpTVE9QX01PVkVEEAkS'
    'DQoJTk9fRUZGRUNUEAoSFwoTQUNDRVNTSUJJTElUWV9JU1NVRRALIkgKDVNldmVyaXR5TGV2ZW'
    'wSFAoQVU5LTk9XTl9TRVZFUklUWRABEggKBElORk8QAhILCgdXQVJOSU5HEAMSCgoGU0VWRVJF'
    'EAQqBgjoBxDQDyoGCKhGEJBO');

@$core.Deprecated('Use timeRangeDescriptor instead')
const TimeRange$json = {
  '1': 'TimeRange',
  '2': [
    {'1': 'start', '3': 1, '4': 1, '5': 4, '10': 'start'},
    {'1': 'end', '3': 2, '4': 1, '5': 4, '10': 'end'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `TimeRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeRangeDescriptor = $convert.base64Decode(
    'CglUaW1lUmFuZ2USFAoFc3RhcnQYASABKARSBXN0YXJ0EhAKA2VuZBgCIAEoBFIDZW5kKgYI6A'
    'cQ0A8qBgioRhCQTg==');

@$core.Deprecated('Use positionDescriptor instead')
const Position$json = {
  '1': 'Position',
  '2': [
    {'1': 'latitude', '3': 1, '4': 2, '5': 2, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 2, '5': 2, '10': 'longitude'},
    {'1': 'bearing', '3': 3, '4': 1, '5': 2, '10': 'bearing'},
    {'1': 'odometer', '3': 4, '4': 1, '5': 1, '10': 'odometer'},
    {'1': 'speed', '3': 5, '4': 1, '5': 2, '10': 'speed'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode(
    'CghQb3NpdGlvbhIaCghsYXRpdHVkZRgBIAIoAlIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAi'
    'gCUglsb25naXR1ZGUSGAoHYmVhcmluZxgDIAEoAlIHYmVhcmluZxIaCghvZG9tZXRlchgEIAEo'
    'AVIIb2RvbWV0ZXISFAoFc3BlZWQYBSABKAJSBXNwZWVkKgYI6AcQ0A8qBgioRhCQTg==');

@$core.Deprecated('Use tripDescriptorDescriptor instead')
const TripDescriptor$json = {
  '1': 'TripDescriptor',
  '2': [
    {'1': 'trip_id', '3': 1, '4': 1, '5': 9, '10': 'tripId'},
    {'1': 'route_id', '3': 5, '4': 1, '5': 9, '10': 'routeId'},
    {'1': 'direction_id', '3': 6, '4': 1, '5': 13, '10': 'directionId'},
    {'1': 'start_time', '3': 2, '4': 1, '5': 9, '10': 'startTime'},
    {'1': 'start_date', '3': 3, '4': 1, '5': 9, '10': 'startDate'},
    {'1': 'schedule_relationship', '3': 4, '4': 1, '5': 14, '6': '.transit_realtime.TripDescriptor.ScheduleRelationship', '10': 'scheduleRelationship'},
  ],
  '4': [TripDescriptor_ScheduleRelationship$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use tripDescriptorDescriptor instead')
const TripDescriptor_ScheduleRelationship$json = {
  '1': 'ScheduleRelationship',
  '2': [
    {'1': 'SCHEDULED', '2': 0},
    {'1': 'ADDED', '2': 1},
    {'1': 'UNSCHEDULED', '2': 2},
    {'1': 'CANCELED', '2': 3},
    {
      '1': 'REPLACEMENT',
      '2': 5,
      '3': {'1': true},
    },
    {'1': 'DUPLICATED', '2': 6},
    {'1': 'DELETED', '2': 7},
  ],
};

/// Descriptor for `TripDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripDescriptorDescriptor = $convert.base64Decode(
    'Cg5UcmlwRGVzY3JpcHRvchIXCgd0cmlwX2lkGAEgASgJUgZ0cmlwSWQSGQoIcm91dGVfaWQYBS'
    'ABKAlSB3JvdXRlSWQSIQoMZGlyZWN0aW9uX2lkGAYgASgNUgtkaXJlY3Rpb25JZBIdCgpzdGFy'
    'dF90aW1lGAIgASgJUglzdGFydFRpbWUSHQoKc3RhcnRfZGF0ZRgDIAEoCVIJc3RhcnREYXRlEm'
    'oKFXNjaGVkdWxlX3JlbGF0aW9uc2hpcBgEIAEoDjI1LnRyYW5zaXRfcmVhbHRpbWUuVHJpcERl'
    'c2NyaXB0b3IuU2NoZWR1bGVSZWxhdGlvbnNoaXBSFHNjaGVkdWxlUmVsYXRpb25zaGlwIoEBCh'
    'RTY2hlZHVsZVJlbGF0aW9uc2hpcBINCglTQ0hFRFVMRUQQABIJCgVBRERFRBABEg8KC1VOU0NI'
    'RURVTEVEEAISDAoIQ0FOQ0VMRUQQAxITCgtSRVBMQUNFTUVOVBAFGgIIARIOCgpEVVBMSUNBVE'
    'VEEAYSCwoHREVMRVRFRBAHKgYI6AcQ0A8qBgioRhCQTg==');

@$core.Deprecated('Use vehicleDescriptorDescriptor instead')
const VehicleDescriptor$json = {
  '1': 'VehicleDescriptor',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'license_plate', '3': 3, '4': 1, '5': 9, '10': 'licensePlate'},
    {'1': 'wheelchair_accessible', '3': 4, '4': 1, '5': 14, '6': '.transit_realtime.VehicleDescriptor.WheelchairAccessible', '7': 'NO_VALUE', '10': 'wheelchairAccessible'},
  ],
  '4': [VehicleDescriptor_WheelchairAccessible$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use vehicleDescriptorDescriptor instead')
const VehicleDescriptor_WheelchairAccessible$json = {
  '1': 'WheelchairAccessible',
  '2': [
    {'1': 'NO_VALUE', '2': 0},
    {'1': 'UNKNOWN', '2': 1},
    {'1': 'WHEELCHAIR_ACCESSIBLE', '2': 2},
    {'1': 'WHEELCHAIR_INACCESSIBLE', '2': 3},
  ],
};

/// Descriptor for `VehicleDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vehicleDescriptorDescriptor = $convert.base64Decode(
    'ChFWZWhpY2xlRGVzY3JpcHRvchIOCgJpZBgBIAEoCVICaWQSFAoFbGFiZWwYAiABKAlSBWxhYm'
    'VsEiMKDWxpY2Vuc2VfcGxhdGUYAyABKAlSDGxpY2Vuc2VQbGF0ZRJ3ChV3aGVlbGNoYWlyX2Fj'
    'Y2Vzc2libGUYBCABKA4yOC50cmFuc2l0X3JlYWx0aW1lLlZlaGljbGVEZXNjcmlwdG9yLldoZW'
    'VsY2hhaXJBY2Nlc3NpYmxlOghOT19WQUxVRVIUd2hlZWxjaGFpckFjY2Vzc2libGUiaQoUV2hl'
    'ZWxjaGFpckFjY2Vzc2libGUSDAoITk9fVkFMVUUQABILCgdVTktOT1dOEAESGQoVV0hFRUxDSE'
    'FJUl9BQ0NFU1NJQkxFEAISGwoXV0hFRUxDSEFJUl9JTkFDQ0VTU0lCTEUQAyoGCOgHENAPKgYI'
    'qEYQkE4=');

@$core.Deprecated('Use entitySelectorDescriptor instead')
const EntitySelector$json = {
  '1': 'EntitySelector',
  '2': [
    {'1': 'agency_id', '3': 1, '4': 1, '5': 9, '10': 'agencyId'},
    {'1': 'route_id', '3': 2, '4': 1, '5': 9, '10': 'routeId'},
    {'1': 'route_type', '3': 3, '4': 1, '5': 5, '10': 'routeType'},
    {'1': 'trip', '3': 4, '4': 1, '5': 11, '6': '.transit_realtime.TripDescriptor', '10': 'trip'},
    {'1': 'stop_id', '3': 5, '4': 1, '5': 9, '10': 'stopId'},
    {'1': 'direction_id', '3': 6, '4': 1, '5': 13, '10': 'directionId'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `EntitySelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entitySelectorDescriptor = $convert.base64Decode(
    'Cg5FbnRpdHlTZWxlY3RvchIbCglhZ2VuY3lfaWQYASABKAlSCGFnZW5jeUlkEhkKCHJvdXRlX2'
    'lkGAIgASgJUgdyb3V0ZUlkEh0KCnJvdXRlX3R5cGUYAyABKAVSCXJvdXRlVHlwZRI0CgR0cmlw'
    'GAQgASgLMiAudHJhbnNpdF9yZWFsdGltZS5UcmlwRGVzY3JpcHRvclIEdHJpcBIXCgdzdG9wX2'
    'lkGAUgASgJUgZzdG9wSWQSIQoMZGlyZWN0aW9uX2lkGAYgASgNUgtkaXJlY3Rpb25JZCoGCOgH'
    'ENAPKgYIqEYQkE4=');

@$core.Deprecated('Use translatedStringDescriptor instead')
const TranslatedString$json = {
  '1': 'TranslatedString',
  '2': [
    {'1': 'translation', '3': 1, '4': 3, '5': 11, '6': '.transit_realtime.TranslatedString.Translation', '10': 'translation'},
  ],
  '3': [TranslatedString_Translation$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use translatedStringDescriptor instead')
const TranslatedString_Translation$json = {
  '1': 'Translation',
  '2': [
    {'1': 'text', '3': 1, '4': 2, '5': 9, '10': 'text'},
    {'1': 'language', '3': 2, '4': 1, '5': 9, '10': 'language'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `TranslatedString`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translatedStringDescriptor = $convert.base64Decode(
    'ChBUcmFuc2xhdGVkU3RyaW5nElAKC3RyYW5zbGF0aW9uGAEgAygLMi4udHJhbnNpdF9yZWFsdG'
    'ltZS5UcmFuc2xhdGVkU3RyaW5nLlRyYW5zbGF0aW9uUgt0cmFuc2xhdGlvbhpNCgtUcmFuc2xh'
    'dGlvbhISCgR0ZXh0GAEgAigJUgR0ZXh0EhoKCGxhbmd1YWdlGAIgASgJUghsYW5ndWFnZSoGCO'
    'gHENAPKgYIqEYQkE4qBgjoBxDQDyoGCKhGEJBO');

@$core.Deprecated('Use translatedImageDescriptor instead')
const TranslatedImage$json = {
  '1': 'TranslatedImage',
  '2': [
    {'1': 'localized_image', '3': 1, '4': 3, '5': 11, '6': '.transit_realtime.TranslatedImage.LocalizedImage', '10': 'localizedImage'},
  ],
  '3': [TranslatedImage_LocalizedImage$json],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

@$core.Deprecated('Use translatedImageDescriptor instead')
const TranslatedImage_LocalizedImage$json = {
  '1': 'LocalizedImage',
  '2': [
    {'1': 'url', '3': 1, '4': 2, '5': 9, '10': 'url'},
    {'1': 'media_type', '3': 2, '4': 2, '5': 9, '10': 'mediaType'},
    {'1': 'language', '3': 3, '4': 1, '5': 9, '10': 'language'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `TranslatedImage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translatedImageDescriptor = $convert.base64Decode(
    'Cg9UcmFuc2xhdGVkSW1hZ2USWQoPbG9jYWxpemVkX2ltYWdlGAEgAygLMjAudHJhbnNpdF9yZW'
    'FsdGltZS5UcmFuc2xhdGVkSW1hZ2UuTG9jYWxpemVkSW1hZ2VSDmxvY2FsaXplZEltYWdlGm0K'
    'DkxvY2FsaXplZEltYWdlEhAKA3VybBgBIAIoCVIDdXJsEh0KCm1lZGlhX3R5cGUYAiACKAlSCW'
    '1lZGlhVHlwZRIaCghsYW5ndWFnZRgDIAEoCVIIbGFuZ3VhZ2UqBgjoBxDQDyoGCKhGEJBOKgYI'
    '6AcQ0A8qBgioRhCQTg==');

@$core.Deprecated('Use shapeDescriptor instead')
const Shape$json = {
  '1': 'Shape',
  '2': [
    {'1': 'shape_id', '3': 1, '4': 1, '5': 9, '10': 'shapeId'},
    {'1': 'encoded_polyline', '3': 2, '4': 1, '5': 9, '10': 'encodedPolyline'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
    {'1': 9000, '2': 10000},
  ],
};

/// Descriptor for `Shape`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List shapeDescriptor = $convert.base64Decode(
    'CgVTaGFwZRIZCghzaGFwZV9pZBgBIAEoCVIHc2hhcGVJZBIpChBlbmNvZGVkX3BvbHlsaW5lGA'
    'IgASgJUg9lbmNvZGVkUG9seWxpbmUqBgjoBxDQDyoGCKhGEJBO');

