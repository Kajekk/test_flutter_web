import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
part 'workplace_detail.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class WorkplaceDetail implements BaseModel {
  final String? id, address, name;
  final double? latitude, longitude;
  final DateTime? createdTime, lastUpdatedTime;
  @JsonKey(ignore: true)
  bool selected = false;

  WorkplaceDetail(
      {this.id,
        this.address,
        this.name,
        this.latitude,
        this.longitude,
        this.createdTime,
        this.lastUpdatedTime});

  factory WorkplaceDetail.fromJson(Map<String, dynamic> json) =>
      _$WorkplaceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$WorkplaceDetailToJson(this);
}