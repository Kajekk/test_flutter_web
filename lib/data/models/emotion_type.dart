import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
part 'emotion_type.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EmotionType implements BaseModel {
  final String? id, type, image, group;
  final bool? isEnabled;
  final DateTime? createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  EmotionType(
      {this.id,
        this.image,
        this.group,
        this.type,
        this.isEnabled,
        this.createdTime,
        this.lastUpdatedTime});

  factory EmotionType.fromJson(Map<String, dynamic> json) =>
      _$EmotionTypeFromJson(json);

  Map<String, dynamic> toJson() => _$EmotionTypeToJson(this);
}

