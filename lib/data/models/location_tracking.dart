import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'location_tracking.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationTracking implements BaseModel {
  final String? id, email, uid;
  final DateTime? time, createdTime, lastUpdatedTime;
  final double? latitude, longitude;
  @JsonKey(ignore: true)
  bool selected = false;

  LocationTracking(
      {this.id,
      this.email,
      this.uid,
      this.time,
      this.createdTime,
      this.lastUpdatedTime,
      this.latitude,
      this.longitude});

  factory LocationTracking.fromJson(Map<String, dynamic> json) => _$LocationTrackingFromJson(json);

  Map<String, dynamic> toJson() => _$LocationTrackingToJson(this);
}