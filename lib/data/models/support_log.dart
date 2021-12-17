import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'support_log.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SupportLog implements BaseModel {
  final String? id, email, type, forUid, forEmail;
  final DateTime? startAt, endAt, createdTime, lastUpdatedTime;
  final List<Observation>? observations;
  final List<Metric>? metrics;

  @JsonKey(ignore: true)
  bool selected = false;

  SupportLog(
      {this.id,
      this.email,
      this.type,
      this.forUid,
      this.forEmail,
      this.startAt,
      this.endAt,
      this.observations,
      this.metrics,
      this.createdTime,
      this.lastUpdatedTime});

  factory SupportLog.fromJson(Map<String, dynamic> json) =>
      _$SupportLogFromJson(json);

  Map<String, dynamic> toJson() => _$SupportLogToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Observation {
  final String? description;
  final DateTime? time;

  Observation({this.description, this.time});

  factory Observation.fromJson(Map<String, dynamic> json) =>
      _$ObservationFromJson(json);

  Map<String, dynamic> toJson() => _$ObservationToJson(this);

  Observation copyWith({
    String? description,
    DateTime? time,
  }) {
    return Observation(description: description ?? this.description, time: time ?? this.time);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Metric {
  final String? name, metricId;
  final int? value;

  Metric({this.name, this.metricId, this.value});

  factory Metric.fromJson(Map<String, dynamic> json) => _$MetricFromJson(json);

  Map<String, dynamic> toJson() => _$MetricToJson(this);

  Metric copyWith({
    String? name, metricId,
    int? value,
  }) {
    return Metric(name: name ?? this.name, metricId: metricId ?? this.metricId, value: value ?? this.value);
  }
}
