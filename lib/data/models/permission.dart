import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'permission.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Permission implements BaseModel {
  final String? id, name, description, resource, moduleId;
  final List<String>? action;
  @JsonKey(ignore: true)
  bool selected = false;

  Permission(
      {this.id, this.name, this.description, this.action, this.resource, this.moduleId});

  factory Permission.fromJson(Map<String, dynamic> json) => _$PermissionFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class PermissionModule implements BaseModel {
  final String? id, name;
  @JsonKey(ignore: true)
  bool selected = false;

  PermissionModule(
      {this.id, this.name});

  factory PermissionModule.fromJson(Map<String, dynamic> json) => _$PermissionModuleFromJson(json);

  Map<String, dynamic> toJson() => _$PermissionModuleToJson(this);
}