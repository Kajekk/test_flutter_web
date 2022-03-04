// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactForm _$ContactFormFromJson(Map<String, dynamic> json) {
  return ContactForm(
    email: json['email'] as String?,
    name: json['name'] as String?,
    phone: json['phone'] as String?,
    employedPlace: json['employed_place'] as String?,
    currentJob: json['current_job'] as String?,
    timeWorking: json['time_working'] as String?,
    reason: json['reason'] as String?,
    isEmployed: json['is_employed'] as bool?,
    isFullTime: json['is_full_time'] as bool?,
    isApproved: json['is_approved'] as bool?,
    industriesInterested: (json['industries_interested'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    rolesInterested: (json['roles_interested'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    id: json['id'] as String?,
  );
}

Map<String, dynamic> _$ContactFormToJson(ContactForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'phone': instance.phone,
      'employed_place': instance.employedPlace,
      'current_job': instance.currentJob,
      'time_working': instance.timeWorking,
      'reason': instance.reason,
      'is_employed': instance.isEmployed,
      'is_full_time': instance.isFullTime,
      'is_approved': instance.isApproved,
      'industries_interested': instance.industriesInterested,
      'roles_interested': instance.rolesInterested,
    };
