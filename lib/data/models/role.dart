import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'role.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Role implements BaseModel {
  final String? id, name, description, organisation, organisationName;
  final List<String>? permissions;
  final List<Permission>? permissionList;
  @JsonKey(ignore: true)
  bool selected = false;

  Role(
      {this.id, this.name, this.description, this.permissions, this.organisation, this.permissionList, this.organisationName});

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}