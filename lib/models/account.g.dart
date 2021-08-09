// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) {
  return Account(
    organization: json['organization'] as String?,
    type: json['type'] as String?,
    role: json['role'] as String?,
    accountName: json['accountName'] as String?,
  );
}

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'organization': instance.organization,
      'type': instance.type,
      'role': instance.role,
      'accountName': instance.accountName,
    };
