// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map<String, dynamic> json) {
  return Goal(
    icon: json['icon'] as String?,
    name: json['name'] as String?,
    frequencyId: json['frequency_id'] as String?,
    frequency: json['frequency'] as String?,
    nature: json['nature'] as String?,
    organization: json['organization'] as String?,
    createdBy: json['created_by'] as String?,
    tips: (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList(),
    id: json['id'] as String?,
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

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'description': instance.description,
      'type': instance.type,
      'frequency': instance.frequency,
      'frequency_id': instance.frequencyId,
      'nature': instance.nature,
      'organization': instance.organization,
      'created_by': instance.createdBy,
      'tips': instance.tips,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
