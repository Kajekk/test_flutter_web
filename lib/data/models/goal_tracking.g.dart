// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_tracking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalTracking _$GoalTrackingFromJson(Map<String, dynamic> json) {
  return GoalTracking(
    id: json['id'] as String?,
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    status: json['status'] as String?,
    type: json['type'] as String?,
    createdBy: json['created_by'] as String?,
    goal: json['goal'] == null
        ? null
        : Goal.fromJson(json['goal'] as Map<String, dynamic>),
    goalId: json['goal_id'] as String?,
    startDate: json['start_date'] == null
        ? null
        : DateTime.parse(json['start_date'] as String),
    endDate: json['end_date'] == null
        ? null
        : DateTime.parse(json['end_date'] as String),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$GoalTrackingToJson(GoalTracking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'type': instance.type,
      'created_by': instance.createdBy,
      'goal_id': instance.goalId,
      'status': instance.status,
      'goal': instance.goal?.toJson(),
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
