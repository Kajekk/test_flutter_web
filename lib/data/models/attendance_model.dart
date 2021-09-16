import 'package:json_annotation/json_annotation.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
part 'attendance_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AttendanceModel implements BaseModel {
  final String? id, uid, email;
  final bool? isCheckInFar, isCheckOutFar, isCheckedIn, isCheckedOut;
  final DateTime? createdTime;
  final DateTime? lastUpdatedTime;

  AttendanceModel({this.id, this.isCheckInFar, this.isCheckOutFar, this.isCheckedIn, this.isCheckedOut, this.uid, this.email, this.createdTime, this.lastUpdatedTime});

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => _$AttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}

