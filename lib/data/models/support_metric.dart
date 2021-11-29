import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'support_metric.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SupportMetric implements BaseModel {
  final String? id, name, description;
  final List<String>? tips;
  final int? target;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  SupportMetric(
      {this.id,
      this.name,
      this.description,
      this.tips,
      this.target,
      this.createdTime,
      this.lastUpdatedTime});

  factory SupportMetric.fromJson(Map<String, dynamic> json) => _$SupportMetricFromJson(json);

  Map<String, dynamic> toJson() => _$SupportMetricToJson(this);
}
