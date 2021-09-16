// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceModel _$AttendanceModelFromJson(Map<String, dynamic> json) {
  return AttendanceModel(
    id: json['id'] as String?,
    isCheckInFar: json['is_check_in_far'] as bool?,
    isCheckOutFar: json['is_check_out_far'] as bool?,
    isCheckedIn: json['is_checked_in'] as bool?,
    isCheckedOut: json['is_checked_out'] as bool?,
    uid: json['uid'] as String?,
    email: json['email'] as String?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$AttendanceModelToJson(AttendanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'is_check_in_far': instance.isCheckInFar,
      'is_check_out_far': instance.isCheckOutFar,
      'is_checked_in': instance.isCheckedIn,
      'is_checked_out': instance.isCheckedOut,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
