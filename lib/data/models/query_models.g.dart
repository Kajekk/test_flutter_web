// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryModel _$QueryModelFromJson(Map<String, dynamic> json) {
  return QueryModel(
    offset: json['offset'] as int?,
    limit: json['limit'] as int?,
    total: json['total'] as bool?,
    reverse: json['reverse'] as bool?,
  );
}

Map<String, dynamic> _$QueryModelToJson(QueryModel instance) =>
    <String, dynamic>{
      'offset': instance.offset,
      'limit': instance.limit,
      'total': instance.total,
      'reverse': instance.reverse,
    };
