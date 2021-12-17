import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'account.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Account implements BaseModel {
  final String? id, uid, organisation, organisationName, type, name, email, gender, homeAddress, role, roleName, phoneNumber, password;
  final DateTime? dateOfBirth;
  @JsonKey(ignore: true)
  bool selected = false;

  Account(
      {this.id,
        this.uid,
        this.organisation,
        this.organisationName,
        this.password,
      this.type,
      this.role,
        this.roleName,
        this.phoneNumber,
      this.name,
      this.email,
      this.gender,
      this.homeAddress,
      this.dateOfBirth});

  factory Account.fromJson(Map<String, dynamic> json) => _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}

