// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organisation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Organisation _$OrganisationFromJson(Map<String, dynamic> json) {
  return Organisation(
    id: json['id'] as String?,
    name: json['name'] as String?,
    code: json['code'] as String?,
    permissions: (json['permissions'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    permissionList: (json['permission_list'] as List<dynamic>?)
        ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrganisationToJson(Organisation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'permissions': instance.permissions,
      'permission_list':
          instance.permissionList?.map((e) => e.toJson()).toList(),
    };
