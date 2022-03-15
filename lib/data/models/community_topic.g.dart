// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommunityTopic _$CommunityTopicFromJson(Map<String, dynamic> json) {
  return CommunityTopic(
    id: json['id'] as String?,
    topic: json['topic'] as String?,
    organisation: json['organisation'] as String?,
    startTime: json['start_time'] == null
        ? null
        : DateTime.parse(json['start_time'] as String),
    endTime: json['end_time'] == null
        ? null
        : DateTime.parse(json['end_time'] as String),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$CommunityTopicToJson(CommunityTopic instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'organisation': instance.organisation,
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
