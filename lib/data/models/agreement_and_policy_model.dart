import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'agreement_and_policy_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Agreement implements BaseModel {
  final String? id, description;
  @JsonKey(ignore: true)
  bool selected = false;

  Agreement(
      {this.id,
        this.description,
});

  factory Agreement.fromJson(Map<String, dynamic> json) => _$AgreementFromJson(json);

  Map<String, dynamic> toJson() => _$AgreementToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Policy implements BaseModel {
  final String? id, description;
  @JsonKey(ignore: true)
  bool selected = false;

  Policy(
      {this.id,
        this.description,
});

  factory Policy.fromJson(Map<String, dynamic> json) => _$PolicyFromJson(json);

  Map<String, dynamic> toJson() => _$PolicyToJson(this);
}