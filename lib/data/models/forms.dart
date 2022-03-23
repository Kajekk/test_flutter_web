import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'forms.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class InclusiveEmploymentForm implements BaseModel {
  final String? id, name, email, number;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  InclusiveEmploymentForm({this.name, this.email, this.number,
      this.id,
        this.createdTime,
        this.lastUpdatedTime});

  factory InclusiveEmploymentForm.fromJson(Map<String, dynamic> json) => _$InclusiveEmploymentFormFromJson(json);

  Map<String, dynamic> toJson() => _$InclusiveEmploymentFormToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactUsForm implements BaseModel {
  final String? id, name, email, number, message;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  ContactUsForm({this.name, this.email, this.number, this.message,
    this.id,
    this.createdTime,
    this.lastUpdatedTime});

  factory ContactUsForm.fromJson(Map<String, dynamic> json) => _$ContactUsFormFromJson(json);

  Map<String, dynamic> toJson() => _$ContactUsFormToJson(this);
}
