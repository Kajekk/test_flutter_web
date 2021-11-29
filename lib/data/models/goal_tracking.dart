import 'package:json_annotation/json_annotation.dart';
import 'barrel.dart';
part 'goal_tracking.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GoalTracking implements BaseModel {
  final String? id, uid, email, type, createdBy, goalId, status;
  final Goal? goal;
  final DateTime? startDate, endDate, createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  GoalTracking(
      {
        this.id,
        this.uid,
        this.email,
        this.status,
        this.type,
        this.createdBy,
        this.goal,
        this.goalId,
        this.startDate,
        this.endDate,
        this.createdTime,
        this.lastUpdatedTime,
      });

  factory GoalTracking.fromJson(Map<String, dynamic> json) => _$GoalTrackingFromJson(json);
  Map<String, dynamic> toJson() => _$GoalTrackingToJson(this);
}