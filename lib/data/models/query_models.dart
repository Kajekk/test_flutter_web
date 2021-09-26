import 'package:json_annotation/json_annotation.dart';
part 'query_models.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QueryModel {
  final int? offset, limit;
  final bool? total, reverse;
  final String? q;

  QueryModel({this.offset, this.limit, this.total, this.reverse, this.q});

  factory QueryModel.fromJson(Map<String, dynamic> json) => _$QueryModelFromJson(json);

  Map<String, dynamic> toJson() => _$QueryModelToJson(this);
}
