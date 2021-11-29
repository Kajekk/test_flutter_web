// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportLog _$SupportLogFromJson(Map<String, dynamic> json) {
  return SupportLog(
    id: json['id'] as String?,
    email: json['email'] as String?,
    type: json['type'] as String?,
    forUid: json['for_uid'] as String?,
    forEmail: json['for_email'] as String?,
    startAt: json['start_at'] == null
        ? null
        : DateTime.parse(json['start_at'] as String),
    endAt: json['end_at'] == null
        ? null
        : DateTime.parse(json['end_at'] as String),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$SupportLogToJson(SupportLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'type': instance.type,
      'for_uid': instance.forUid,
      'for_email': instance.forEmail,
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
