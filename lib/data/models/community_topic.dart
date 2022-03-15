import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
part 'community_topic.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CommunityTopic implements BaseModel {
  final String? id, topic, organisation;
  final DateTime? startTime, endTime, createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  CommunityTopic(
      {this.id,
      this.topic,
      this.organisation,
      this.startTime,
      this.endTime,
      this.createdTime,
      this.lastUpdatedTime});

  factory CommunityTopic.fromJson(Map<String, dynamic> json) =>
      _$CommunityTopicFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityTopicToJson(this);
}

