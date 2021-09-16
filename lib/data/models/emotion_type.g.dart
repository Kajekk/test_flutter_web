// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotion_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmotionType _$EmotionTypeFromJson(Map<String, dynamic> json) {
  return EmotionType(
    id: json['id'] as String?,
    image: json['image'] as String?,
    group: json['group'] as String?,
    type: json['type'] as String?,
    isEnabled: json['is_enabled'] as bool?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$EmotionTypeToJson(EmotionType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'image': instance.image,
      'group': instance.group,
      'is_enabled': instance.isEnabled,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
