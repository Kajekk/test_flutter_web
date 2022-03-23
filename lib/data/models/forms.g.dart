// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InclusiveEmploymentForm _$InclusiveEmploymentFormFromJson(
    Map<String, dynamic> json) {
  return InclusiveEmploymentForm(
    name: json['name'] as String?,
    email: json['email'] as String?,
    number: json['number'] as String?,
    id: json['id'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$InclusiveEmploymentFormToJson(
        InclusiveEmploymentForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'number': instance.number,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };

ContactUsForm _$ContactUsFormFromJson(Map<String, dynamic> json) {
  return ContactUsForm(
    name: json['name'] as String?,
    email: json['email'] as String?,
    number: json['number'] as String?,
    message: json['message'] as String?,
    id: json['id'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$ContactUsFormToJson(ContactUsForm instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'number': instance.number,
      'message': instance.message,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
