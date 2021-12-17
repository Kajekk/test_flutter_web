import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/barrel.dart';
part 'pro_work_schedule.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProWorkSchedule implements BaseModel {
  final String? id, email, employmentEmail, employmentName;
  final List<WorkingDay>? workingDays;
  @JsonKey(ignore: true)
  bool selected = false;

  ProWorkSchedule(
      {this.id,
      this.email,
      this.employmentEmail,
      this.employmentName,
      this.workingDays});

  factory ProWorkSchedule.fromJson(Map<String, dynamic> json) => _$ProWorkScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ProWorkScheduleToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class WorkingDay{
  final int? weekday, workingTimeFrom, workingTimeTo;
  @JsonKey(ignore: true)

  WorkingDay(
      {this.weekday, this.workingTimeFrom, this.workingTimeTo});

  factory WorkingDay.fromJson(Map<String, dynamic> json) => _$WorkingDayFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingDayToJson(this);
}