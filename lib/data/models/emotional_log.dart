import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'emotional_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmotionalLog implements BaseModel {
  final String? id, uid, email, type, description;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;

  EmotionalLog(
      {this.id,
      this.uid,
      this.email,
      this.type,
      this.description,
      this.createdTime,
      this.lastUpdatedTime});

  factory EmotionalLog.fromJson(Map<String, dynamic> json) =>
      _$EmotionalLogFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionalLogToJson(this);
}

