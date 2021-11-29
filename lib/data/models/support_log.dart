import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'support_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SupportLog implements BaseModel {
  final String? id, email, type, forUid, forEmail;
  final DateTime? startAt, endAt, createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  SupportLog(
      {this.id,
      this.email,
      this.type,
      this.forUid,
      this.forEmail,
      this.startAt,
      this.endAt,
      this.createdTime,
      this.lastUpdatedTime});

  factory SupportLog.fromJson(Map<String, dynamic> json) => _$SupportLogFromJson(json);

  Map<String, dynamic> toJson() => _$SupportLogToJson(this);
}
