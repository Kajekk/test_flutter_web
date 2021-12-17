// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) {
  return Role(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    permissions: (json['permissions'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    organisation: json['organisation'] as String?,
    permissionList: (json['permission_list'] as List<dynamic>?)
        ?.map((e) => Permission.fromJson(e as Map<String, dynamic>))
        .toList(),
    organisationName: json['organisation_name'] as String?,
  );
}

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'organisation': instance.organisation,
      'organisation_name': instance.organisationName,
      'permissions': instance.permissions,
      'permission_list': instance.permissionList,
    };
