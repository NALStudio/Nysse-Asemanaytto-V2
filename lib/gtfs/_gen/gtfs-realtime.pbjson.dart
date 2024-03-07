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
  ],
};

/// Descriptor for `FeedMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feedMessageDescriptor = $convert.base64Decode(
    'CgtGZWVkTWVzc2FnZRI0CgZoZWFkZXIYASACKAsyHC50cmFuc2l0X3JlYWx0aW1lLkZlZWRIZW'
    'FkZXJSBmhlYWRlchI0CgZlbnRpdHkYAiADKAsyHC50cmFuc2l0X3JlYWx0aW1lLkZlZWRFbnRp'
    'dHlSBmVudGl0eSoGCOgHENAP');

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
    'VEFTRVQQABIQCgxESUZGRVJFTlRJQUwQASoGCOgHENAP');

@$core.Deprecated('Use feedEntityDescriptor instead')
const FeedEntity$json = {
  '1': 'FeedEntity',
  '2': [
    {'1': 'id', '3': 1, '4': 2, '5': 9, '10': 'id'},
    {'1': 'is_deleted', '3': 2, '4': 1, '5': 8, '7': 'false', '10': 'isDeleted'},
    {'1': 'trip_update', '3': 3, '4': 1, '5': 11, '6': '.transit_realtime.TripUpdate', '10': 'tripUpdate'},
    {'1': 'vehicle', '3': 4, '4': 1, '5': 11, '6': '.transit_realtime.VehiclePosition', '10': 'vehicle'},
    {'1': 'alert', '3': 5, '4': 1, '5': 11, '6': '.transit_realtime.Alert', '10': 'alert'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
  ],
};

/// Descriptor for `FeedEntity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List feedEntityDescriptor = $convert.base64Decode(
    'CgpGZWVkRW50aXR5Eg4KAmlkGAEgAigJUgJpZBIkCgppc19kZWxldGVkGAIgASgIOgVmYWxzZV'
    'IJaXNEZWxldGVkEj0KC3RyaXBfdXBkYXRlGAMgASgLMhwudHJhbnNpdF9yZWFsdGltZS5Ucmlw'
    'VXBkYXRlUgp0cmlwVXBkYXRlEjsKB3ZlaGljbGUYBCABKAsyIS50cmFuc2l0X3JlYWx0aW1lLl'
    'ZlaGljbGVQb3NpdGlvblIHdmVoaWNsZRItCgVhbGVydBgFIAEoCzIXLnRyYW5zaXRfcmVhbHRp'
    'bWUuQWxlcnRSBWFsZXJ0KgYI6AcQ0A8=');

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate$json = {
  '1': 'TripUpdate',
  '2': [
    {'1': 'trip', '3': 1, '4': 2, '5': 11, '6': '.transit_realtime.TripDescriptor', '10': 'trip'},
    {'1': 'vehicle', '3': 3, '4': 1, '5': 11, '6': '.transit_realtime.VehicleDescriptor', '10': 'vehicle'},
    {'1': 'stop_time_update', '3': 2, '4': 3, '5': 11, '6': '.transit_realtime.TripUpdate.StopTimeUpdate', '10': 'stopTimeUpdate'},
    {'1': 'timestamp', '3': 4, '4': 1, '5': 4, '10': 'timestamp'},
    {'1': 'delay', '3': 5, '4': 1, '5': 5, '10': 'delay'},
  ],
  '3': [TripUpdate_StopTimeEvent$json, TripUpdate_StopTimeUpdate$json],
  '5': [
    {'1': 1000, '2': 2000},
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
    {'1': 'schedule_relationship', '3': 5, '4': 1, '5': 14, '6': '.transit_realtime.TripUpdate.StopTimeUpdate.ScheduleRelationship', '7': 'SCHEDULED', '10': 'scheduleRelationship'},
  ],
  '4': [TripUpdate_StopTimeUpdate_ScheduleRelationship$json],
  '5': [
    {'1': 1000, '2': 2000},
  ],
};

@$core.Deprecated('Use tripUpdateDescriptor instead')
const TripUpdate_StopTimeUpdate_ScheduleRelationship$json = {
  '1': 'ScheduleRelationship',
  '2': [
    {'1': 'SCHEDULED', '2': 0},
    {'1': 'SKIPPED', '2': 1},
    {'1': 'NO_DATA', '2': 2},
  ],
};

/// Descriptor for `TripUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripUpdateDescriptor = $convert.base64Decode(
    'CgpUcmlwVXBkYXRlEjQKBHRyaXAYASACKAsyIC50cmFuc2l0X3JlYWx0aW1lLlRyaXBEZXNjcm'
    'lwdG9yUgR0cmlwEj0KB3ZlaGljbGUYAyABKAsyIy50cmFuc2l0X3JlYWx0aW1lLlZlaGljbGVE'
    'ZXNjcmlwdG9yUgd2ZWhpY2xlElUKEHN0b3BfdGltZV91cGRhdGUYAiADKAsyKy50cmFuc2l0X3'
    'JlYWx0aW1lLlRyaXBVcGRhdGUuU3RvcFRpbWVVcGRhdGVSDnN0b3BUaW1lVXBkYXRlEhwKCXRp'
    'bWVzdGFtcBgEIAEoBFIJdGltZXN0YW1wEhQKBWRlbGF5GAUgASgFUgVkZWxheRpjCg1TdG9wVG'
    'ltZUV2ZW50EhQKBWRlbGF5GAEgASgFUgVkZWxheRISCgR0aW1lGAIgASgDUgR0aW1lEiAKC3Vu'
    'Y2VydGFpbnR5GAMgASgFUgt1bmNlcnRhaW50eSoGCOgHENAPGqoDCg5TdG9wVGltZVVwZGF0ZR'
    'IjCg1zdG9wX3NlcXVlbmNlGAEgASgNUgxzdG9wU2VxdWVuY2USFwoHc3RvcF9pZBgEIAEoCVIG'
    'c3RvcElkEkQKB2Fycml2YWwYAiABKAsyKi50cmFuc2l0X3JlYWx0aW1lLlRyaXBVcGRhdGUuU3'
    'RvcFRpbWVFdmVudFIHYXJyaXZhbBJICglkZXBhcnR1cmUYAyABKAsyKi50cmFuc2l0X3JlYWx0'
    'aW1lLlRyaXBVcGRhdGUuU3RvcFRpbWVFdmVudFIJZGVwYXJ0dXJlEoABChVzY2hlZHVsZV9yZW'
    'xhdGlvbnNoaXAYBSABKA4yQC50cmFuc2l0X3JlYWx0aW1lLlRyaXBVcGRhdGUuU3RvcFRpbWVV'
    'cGRhdGUuU2NoZWR1bGVSZWxhdGlvbnNoaXA6CVNDSEVEVUxFRFIUc2NoZWR1bGVSZWxhdGlvbn'
    'NoaXAiPwoUU2NoZWR1bGVSZWxhdGlvbnNoaXASDQoJU0NIRURVTEVEEAASCwoHU0tJUFBFRBAB'
    'EgsKB05PX0RBVEEQAioGCOgHENAPKgYI6AcQ0A8=');

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
  ],
  '4': [VehiclePosition_VehicleStopStatus$json, VehiclePosition_CongestionLevel$json, VehiclePosition_OccupancyStatus$json],
  '5': [
    {'1': 1000, '2': 2000},
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
    'dGlvbi5PY2N1cGFuY3lTdGF0dXNSD29jY3VwYW5jeVN0YXR1cyJHChFWZWhpY2xlU3RvcFN0YX'
    'R1cxIPCgtJTkNPTUlOR19BVBAAEg4KClNUT1BQRURfQVQQARIRCg1JTl9UUkFOU0lUX1RPEAIi'
    'fQoPQ29uZ2VzdGlvbkxldmVsEhwKGFVOS05PV05fQ09OR0VTVElPTl9MRVZFTBAAEhQKEFJVTk'
    '5JTkdfU01PT1RITFkQARIPCgtTVE9QX0FORF9HTxACEg4KCkNPTkdFU1RJT04QAxIVChFTRVZF'
    'UkVfQ09OR0VTVElPThAEIq8BCg9PY2N1cGFuY3lTdGF0dXMSCQoFRU1QVFkQABIYChRNQU5ZX1'
    'NFQVRTX0FWQUlMQUJMRRABEhcKE0ZFV19TRUFUU19BVkFJTEFCTEUQAhIWChJTVEFORElOR19S'
    'T09NX09OTFkQAxIeChpDUlVTSEVEX1NUQU5ESU5HX1JPT01fT05MWRAEEggKBEZVTEwQBRIcCh'
    'hOT1RfQUNDRVBUSU5HX1BBU1NFTkdFUlMQBioGCOgHENAP');

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
  ],
  '4': [Alert_Cause$json, Alert_Effect$json],
  '5': [
    {'1': 1000, '2': 2000},
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
    'c2l0X3JlYWx0aW1lLlRyYW5zbGF0ZWRTdHJpbmdSD2Rlc2NyaXB0aW9uVGV4dCLYAQoFQ2F1c2'
    'USEQoNVU5LTk9XTl9DQVVTRRABEg8KC09USEVSX0NBVVNFEAISFQoRVEVDSE5JQ0FMX1BST0JM'
    'RU0QAxIKCgZTVFJJS0UQBBIRCg1ERU1PTlNUUkFUSU9OEAUSDAoIQUNDSURFTlQQBhILCgdIT0'
    'xJREFZEAcSCwoHV0VBVEhFUhAIEg8KC01BSU5URU5BTkNFEAkSEAoMQ09OU1RSVUNUSU9OEAoS'
    'EwoPUE9MSUNFX0FDVElWSVRZEAsSFQoRTUVESUNBTF9FTUVSR0VOQ1kQDCK1AQoGRWZmZWN0Eg'
    '4KCk5PX1NFUlZJQ0UQARITCg9SRURVQ0VEX1NFUlZJQ0UQAhIWChJTSUdOSUZJQ0FOVF9ERUxB'
    'WVMQAxIKCgZERVRPVVIQBBIWChJBRERJVElPTkFMX1NFUlZJQ0UQBRIUChBNT0RJRklFRF9TRV'
    'JWSUNFEAYSEAoMT1RIRVJfRUZGRUNUEAcSEgoOVU5LTk9XTl9FRkZFQ1QQCBIOCgpTVE9QX01P'
    'VkVEEAkqBgjoBxDQDw==');

@$core.Deprecated('Use timeRangeDescriptor instead')
const TimeRange$json = {
  '1': 'TimeRange',
  '2': [
    {'1': 'start', '3': 1, '4': 1, '5': 4, '10': 'start'},
    {'1': 'end', '3': 2, '4': 1, '5': 4, '10': 'end'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
  ],
};

/// Descriptor for `TimeRange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timeRangeDescriptor = $convert.base64Decode(
    'CglUaW1lUmFuZ2USFAoFc3RhcnQYASABKARSBXN0YXJ0EhAKA2VuZBgCIAEoBFIDZW5kKgYI6A'
    'cQ0A8=');

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
  ],
};

/// Descriptor for `Position`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List positionDescriptor = $convert.base64Decode(
    'CghQb3NpdGlvbhIaCghsYXRpdHVkZRgBIAIoAlIIbGF0aXR1ZGUSHAoJbG9uZ2l0dWRlGAIgAi'
    'gCUglsb25naXR1ZGUSGAoHYmVhcmluZxgDIAEoAlIHYmVhcmluZxIaCghvZG9tZXRlchgEIAEo'
    'AVIIb2RvbWV0ZXISFAoFc3BlZWQYBSABKAJSBXNwZWVkKgYI6AcQ0A8=');

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
  ],
};

/// Descriptor for `TripDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tripDescriptorDescriptor = $convert.base64Decode(
    'Cg5UcmlwRGVzY3JpcHRvchIXCgd0cmlwX2lkGAEgASgJUgZ0cmlwSWQSGQoIcm91dGVfaWQYBS'
    'ABKAlSB3JvdXRlSWQSIQoMZGlyZWN0aW9uX2lkGAYgASgNUgtkaXJlY3Rpb25JZBIdCgpzdGFy'
    'dF90aW1lGAIgASgJUglzdGFydFRpbWUSHQoKc3RhcnRfZGF0ZRgDIAEoCVIJc3RhcnREYXRlEm'
    'oKFXNjaGVkdWxlX3JlbGF0aW9uc2hpcBgEIAEoDjI1LnRyYW5zaXRfcmVhbHRpbWUuVHJpcERl'
    'c2NyaXB0b3IuU2NoZWR1bGVSZWxhdGlvbnNoaXBSFHNjaGVkdWxlUmVsYXRpb25zaGlwIk8KFF'
    'NjaGVkdWxlUmVsYXRpb25zaGlwEg0KCVNDSEVEVUxFRBAAEgkKBUFEREVEEAESDwoLVU5TQ0hF'
    'RFVMRUQQAhIMCghDQU5DRUxFRBADKgYI6AcQ0A8=');

@$core.Deprecated('Use vehicleDescriptorDescriptor instead')
const VehicleDescriptor$json = {
  '1': 'VehicleDescriptor',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'label', '3': 2, '4': 1, '5': 9, '10': 'label'},
    {'1': 'license_plate', '3': 3, '4': 1, '5': 9, '10': 'licensePlate'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
  ],
};

/// Descriptor for `VehicleDescriptor`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List vehicleDescriptorDescriptor = $convert.base64Decode(
    'ChFWZWhpY2xlRGVzY3JpcHRvchIOCgJpZBgBIAEoCVICaWQSFAoFbGFiZWwYAiABKAlSBWxhYm'
    'VsEiMKDWxpY2Vuc2VfcGxhdGUYAyABKAlSDGxpY2Vuc2VQbGF0ZSoGCOgHENAP');

@$core.Deprecated('Use entitySelectorDescriptor instead')
const EntitySelector$json = {
  '1': 'EntitySelector',
  '2': [
    {'1': 'agency_id', '3': 1, '4': 1, '5': 9, '10': 'agencyId'},
    {'1': 'route_id', '3': 2, '4': 1, '5': 9, '10': 'routeId'},
    {'1': 'route_type', '3': 3, '4': 1, '5': 5, '10': 'routeType'},
    {'1': 'trip', '3': 4, '4': 1, '5': 11, '6': '.transit_realtime.TripDescriptor', '10': 'trip'},
    {'1': 'stop_id', '3': 5, '4': 1, '5': 9, '10': 'stopId'},
  ],
  '5': [
    {'1': 1000, '2': 2000},
  ],
};

/// Descriptor for `EntitySelector`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List entitySelectorDescriptor = $convert.base64Decode(
    'Cg5FbnRpdHlTZWxlY3RvchIbCglhZ2VuY3lfaWQYASABKAlSCGFnZW5jeUlkEhkKCHJvdXRlX2'
    'lkGAIgASgJUgdyb3V0ZUlkEh0KCnJvdXRlX3R5cGUYAyABKAVSCXJvdXRlVHlwZRI0CgR0cmlw'
    'GAQgASgLMiAudHJhbnNpdF9yZWFsdGltZS5UcmlwRGVzY3JpcHRvclIEdHJpcBIXCgdzdG9wX2'
    'lkGAUgASgJUgZzdG9wSWQqBgjoBxDQDw==');

@$core.Deprecated('Use translatedStringDescriptor instead')
const TranslatedString$json = {
  '1': 'TranslatedString',
  '2': [
    {'1': 'translation', '3': 1, '4': 3, '5': 11, '6': '.transit_realtime.TranslatedString.Translation', '10': 'translation'},
  ],
  '3': [TranslatedString_Translation$json],
  '5': [
    {'1': 1000, '2': 2000},
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
  ],
};

/// Descriptor for `TranslatedString`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List translatedStringDescriptor = $convert.base64Decode(
    'ChBUcmFuc2xhdGVkU3RyaW5nElAKC3RyYW5zbGF0aW9uGAEgAygLMi4udHJhbnNpdF9yZWFsdG'
    'ltZS5UcmFuc2xhdGVkU3RyaW5nLlRyYW5zbGF0aW9uUgt0cmFuc2xhdGlvbhpFCgtUcmFuc2xh'
    'dGlvbhISCgR0ZXh0GAEgAigJUgR0ZXh0EhoKCGxhbmd1YWdlGAIgASgJUghsYW5ndWFnZSoGCO'
    'gHENAPKgYI6AcQ0A8=');

