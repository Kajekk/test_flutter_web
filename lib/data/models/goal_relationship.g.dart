// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_relationship.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalRelationship _$GoalRelationshipFromJson(Map<String, dynamic> json) {
  return GoalRelationship(
    id: json['id'] as String?,
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    type: json['type'] as String?,
    createdBy: json['created_by'] as String?,
    goal: json['goal'] == null
        ? null
        : Goal.fromJson(json['goal'] as Map<String, dynamic>),
    goalId: json['goal_id'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$GoalRelationshipToJson(GoalRelationship instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'type': instance.type,
      'created_by': instance.createdBy,
      'goal_id': instance.goalId,
      'goal': instance.goal?.toJson(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
