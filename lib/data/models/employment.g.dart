// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Employment _$EmploymentFromJson(Map<String, dynamic> json) {
  return Employment(
    id: json['id'] as String?,
    workingDays:
        (json['working_days'] as List<dynamic>?)?.map((e) => e as int).toList(),
    workplaceId: json['workplace_id'] as String?,
    workplaceName: json['workplace_name'] as String?,
    workingTimeFrom: json['working_time_from'] as int?,
    workingTimeTo: json['working_time_to'] as int?,
    lunchTimeFrom: json['lunch_time_from'] as int?,
    lunchTimeTo: json['lunch_time_to'] as int?,
    timeToWork: json['time_to_work'] as int?,
    scopeList: (json['scope_list'] as List<dynamic>?)
        ?.map((e) => Scope.fromJson(e as Map<String, dynamic>))
        .toList(),
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$EmploymentToJson(Employment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'workplace_id': instance.workplaceId,
      'workplace_name': instance.workplaceName,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
      'working_time_from': instance.workingTimeFrom,
      'working_time_to': instance.workingTimeTo,
      'lunch_time_from': instance.lunchTimeFrom,
      'lunch_time_to': instance.lunchTimeTo,
      'time_to_work': instance.timeToWork,
      'scope_list': instance.scopeList?.map((e) => e.toJson()).toList(),
      'working_days': instance.workingDays,
    };

Scope _$ScopeFromJson(Map<String, dynamic> json) {
  return Scope(
    name: json['name'] as String?,
    task: (json['task'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$ScopeToJson(Scope instance) => <String, dynamic>{
      'name': instance.name,
      'task': instance.task,
    };

Coach _$CoachFromJson(Map<String, dynamic> json) {
  return Coach(
    email: json['email'] as String?,
    name: json['name'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$CoachToJson(Coach instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'type': instance.type,
    };
