import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'organisation.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Organisation implements BaseModel {
  final String? id, name, code;
  final List<String>? permissions;
  final List<Permission>? permissionList;
  @JsonKey(ignore: true)
  bool selected = false;

  Organisation(
      {this.id, this.name, this.code, this.permissions, this.permissionList});

  factory Organisation.fromJson(Map<String, dynamic> json) => _$OrganisationFromJson(json);

  Map<String, dynamic> toJson() => _$OrganisationToJson(this);
}