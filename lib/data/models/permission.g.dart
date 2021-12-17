// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) {
  return Permission(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    action:
        (json['action'] as List<dynamic>?)?.map((e) => e as String).toList(),
    resource: json['resource'] as String?,
    moduleId: json['module_id'] as String?,
  );
}

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'resource': instance.resource,
      'module_id': instance.moduleId,
      'action': instance.action,
    };

PermissionModule _$PermissionModuleFromJson(Map<String, dynamic> json) {
  return PermissionModule(
    id: json['id'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$PermissionModuleToJson(PermissionModule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
