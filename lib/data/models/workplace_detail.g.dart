// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workplace_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkplaceDetail _$WorkplaceDetailFromJson(Map<String, dynamic> json) {
  return WorkplaceDetail(
    id: json['id'] as String?,
    address: json['address'] as String?,
    name: json['name'] as String?,
    latitude: (json['latitude'] as num?)?.toDouble(),
    longitude: (json['longitude'] as num?)?.toDouble(),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$WorkplaceDetailToJson(WorkplaceDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
