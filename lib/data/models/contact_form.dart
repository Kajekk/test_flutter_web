import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'contact_form.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ContactForm implements BaseModel {
  final String? id, email, name, phone, employedPlace, currentJob, timeWorking, reason;
  final bool? isEmployed, isFullTime, isApproved;
  final List<String>? industriesInterested, rolesInterested;
  @JsonKey(ignore: true)
  bool selected = false;

  ContactForm(
      {this.email, this.name, this.phone, this.employedPlace, this.currentJob, this.timeWorking, this.reason, this.isEmployed, this.isFullTime, this.isApproved, this.industriesInterested, this.rolesInterested, this.id,});

  factory ContactForm.fromJson(Map<String, dynamic> json) => _$ContactFormFromJson(json);

  Map<String, dynamic> toJson() => _$ContactFormToJson(this);
}