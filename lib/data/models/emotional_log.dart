import 'package:json_annotation/json_annotation.dart';
part 'emotional_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmotionalLog {
  final String? uid, email, type, description;

  EmotionalLog({this.uid, this.email, this.type, this.description});

  factory EmotionalLog.fromJson(Map<String, dynamic> json) => _$EmotionalLogFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionalLogToJson(this);
}

