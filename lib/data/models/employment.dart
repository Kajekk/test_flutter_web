import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'employment.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Employment implements BaseModel {
  final String? uid, email, workplaceId;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  final int? workingTimeFrom, workingTimeTo, lunchTimeFrom, lunchTimeTo, timeToWork;
  final List<Scope>? scope;
  final List<Coach>? coachList;
  final List<int>? workingDay;

  Employment({this.workingDay, this.workplaceId, this.workingTimeFrom, this.workingTimeTo, this.lunchTimeFrom, this.lunchTimeTo, this.timeToWork, this.scope, this.coachList, this.uid, this.email, this.createdTime, this.lastUpdatedTime});

  factory Employment.fromJson(Map<String, dynamic> json) => _$EmploymentFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Scope implements BaseModel {
  final String? name;
  final List<String>? task;

  Scope({this.name, this.task});

  factory Scope.fromJson(Map<String, dynamic> json) => _$ScopeFromJson(json);

  Map<String, dynamic> toJson() => _$ScopeToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Coach implements BaseModel {
  final String? email, name, type;

  Coach({this.email, this.name, this.type});

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);

  Map<String, dynamic> toJson() => _$CoachToJson(this);
}

