import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'goal.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Goal implements BaseModel {
  final String? id,
      name,
      icon,
      description,
      type,
      frequency,
      frequencyId,
      nature,
      organization,
      createdBy;
  final List<String>? tips;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;

  Goal(
      {this.icon,
      this.name,
      this.frequencyId,
        this.frequency,
      this.nature,
      this.organization,
      this.createdBy,
      this.tips,
      this.id,
      this.type,
      this.description,
      this.createdTime,
      this.lastUpdatedTime});

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);

  bool isEqual(Goal? model) {
    return this.id == model?.id;
  }
}
