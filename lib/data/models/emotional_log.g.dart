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
  );
}

Map<String, dynamic> _$EmotionalLogToJson(EmotionalLog instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'type': instance.type,
      'description': instance.description,
    };
