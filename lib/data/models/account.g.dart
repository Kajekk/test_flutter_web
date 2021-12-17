// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    id: json['id'] as String?,
    uid: json['uid'] as String?,
    organisation: json['organisation'] as String?,
    organisationName: json['organisation_name'] as String?,
    password: json['password'] as String?,
    type: json['type'] as String?,
    role: json['role'] as String?,
    roleName: json['role_name'] as String?,
    phoneNumber: json['phone_number'] as String?,
    name: json['name'] as String?,
    email: json['email'] as String?,
    gender: json['gender'] as String?,
    homeAddress: json['home_address'] as String?,
    dateOfBirth: json['date_of_birth'] == null
        ? null
        : DateTime.parse(json['date_of_birth'] as String),
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'organisation': instance.organisation,
      'organisation_name': instance.organisationName,
      'type': instance.type,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'home_address': instance.homeAddress,
      'role': instance.role,
      'role_name': instance.roleName,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
    };
