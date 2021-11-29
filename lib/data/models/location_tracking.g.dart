// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationTracking _$LocationTrackingFromJson(Map<String, dynamic> json) {
  return LocationTracking(
    id: json['id'] as String?,
    email: json['email'] as String?,
    uid: json['uid'] as String?,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$LocationTrackingToJson(LocationTracking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'uid': instance.uid,
      'time': instance.time?.toIso8601String(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
