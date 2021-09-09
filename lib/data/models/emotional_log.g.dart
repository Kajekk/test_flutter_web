// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emotional_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmotionalLog _$EmotionalLogFromJson(Map<String, dynamic> json) {
  return EmotionalLog(
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    type: json['type'] as String?,
    description: json['description'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$EmotionalLogToJson(EmotionalLog instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'type': instance.type,
      'description': instance.description,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
