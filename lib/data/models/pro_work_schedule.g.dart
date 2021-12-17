// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pro_work_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProWorkSchedule _$ProWorkScheduleFromJson(Map<String, dynamic> json) {
  return ProWorkSchedule(
    id: json['id'] as String?,
    email: json['email'] as String?,
    employmentEmail: json['employment_email'] as String?,
    employmentName: json['employment_name'] as String?,
    workingDays: (json['working_days'] as List<dynamic>?)
        ?.map((e) => WorkingDay.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProWorkScheduleToJson(ProWorkSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'employment_email': instance.employmentEmail,
      'employment_name': instance.employmentName,
      'working_days': instance.workingDays?.map((e) => e.toJson()).toList(),
    };

WorkingDay _$WorkingDayFromJson(Map<String, dynamic> json) {
  return WorkingDay(
    weekday: json['weekday'] as int?,
    workingTimeFrom: json['working_time_from'] as int?,
    workingTimeTo: json['working_time_to'] as int?,
  );
}

Map<String, dynamic> _$WorkingDayToJson(WorkingDay instance) =>
    <String, dynamic>{
      'weekday': instance.weekday,
      'working_time_from': instance.workingTimeFrom,
      'working_time_to': instance.workingTimeTo,
    };
