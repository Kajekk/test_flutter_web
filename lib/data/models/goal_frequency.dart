import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'goal_frequency.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GoalFrequency implements BaseModel {
  final String? id, frequency;
  final int? dayEquivalent;
  final bool? isEnabled;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  GoalFrequency(
      {this.id,
      this.frequency,
      this.dayEquivalent,
      this.isEnabled,
      this.createdTime,
      this.lastUpdatedTime});

  factory GoalFrequency.fromJson(Map<String, dynamic> json) => _$GoalFrequencyFromJson(json);

  Map<String, dynamic> toJson() => _$GoalFrequencyToJson(this);
}
