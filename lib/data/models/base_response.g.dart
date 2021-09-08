// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return BaseResponse<T>(
    total: json['total'] as int?,
    data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    status: json['status'] as String?,
    message: json['message'] as String?,
    errorCode: json['error_code'] as String?,
  );
}

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total': instance.total,
      'data': instance.data?.map(toJsonT).toList(),
      'status': instance.status,
      'message': instance.message,
      'error_code': instance.errorCode,
    };
