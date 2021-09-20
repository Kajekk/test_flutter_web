// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_frequency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalFrequency _$GoalFrequencyFromJson(Map<String, dynamic> json) {
  return GoalFrequency(
    id: json['id'] as String?,
    frequency: json['frequency'] as String?,
    dayEquivalent: json['day_equivalent'] as int?,
    isEnabled: json['is_enabled'] as bool?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$GoalFrequencyToJson(GoalFrequency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frequency': instance.frequency,
      'day_equivalent': instance.dayEquivalent,
      'is_enabled': instance.isEnabled,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
