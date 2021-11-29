import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
import 'barrel.dart';
part 'goal_relationship.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GoalRelationship implements BaseModel {
  final String? id, uid, email, type, createdBy, goalId;
  final Goal? goal;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  GoalRelationship(
      {
    this.id,
    this.uid,
    this.email,
    this.type,
    this.createdBy,
    this.goal,
    this.goalId,
    this.createdTime,
    this.lastUpdatedTime,
  });

  factory GoalRelationship.fromJson(Map<String, dynamic> json) => _$GoalRelationshipFromJson(json);
  Map<String, dynamic> toJson() => _$GoalRelationshipToJson(this);
}
