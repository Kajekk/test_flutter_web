import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable(
    genericArgumentFactories: true, fieldRename: FieldRename.snake)
class BaseResponse<T> {
  int? total;
  List<T>? data;
  String? status;
  String? message;
  String? errorCode;

  BaseResponse(
      {this.total, this.data, this.status, this.message, this.errorCode});

  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$BaseResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
