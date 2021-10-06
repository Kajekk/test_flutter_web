import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'employment.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Employment implements BaseModel {
  final String? id, uid, email, workplaceId, workplaceName;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  final int? workingTimeFrom,
      workingTimeTo,
      lunchTimeFrom,
      lunchTimeTo,
      timeToWork;
  final List<Scope>? scopeList;
  final List<Coach>? coachList;
  final List<int>? workingDays;
  @JsonKey(ignore: true)
  bool selected = false;

  Employment(
      {
        this.id,
        this.workingDays,
      this.workplaceId,
      this.workplaceName,
      this.workingTimeFrom,
      this.workingTimeTo,
      this.lunchTimeFrom,
      this.lunchTimeTo,
      this.timeToWork,
      this.scopeList,
      this.coachList,
      this.uid,
      this.email,
      this.createdTime,
      this.lastUpdatedTime});

  factory Employment.fromJson(Map<String, dynamic> json) =>
      _$EmploymentFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Scope {
  final String? name;
  final List<String>? task;

  Scope({this.name, this.task});

  factory Scope.fromJson(Map<String, dynamic> json) => _$ScopeFromJson(json);

  Map<String, dynamic> toJson() => _$ScopeToJson(this);

  Scope copyWith({
    String? name,
    List<String>? task,
  }) {
    return Scope(name: name ?? this.name, task: task ?? this.task);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Coach {
  final String? email, name, type;

  Coach({this.email, this.name, this.type});

  factory Coach.fromJson(Map<String, dynamic> json) => _$CoachFromJson(json);

  Map<String, dynamic> toJson() => _$CoachToJson(this);

  Coach copyWith({
    String? email,
    type,
  }) {
    return Coach(email: email ?? this.email, type: type ?? this.type);
  }
}
