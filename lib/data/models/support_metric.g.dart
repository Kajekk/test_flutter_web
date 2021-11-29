// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportMetric _$SupportMetricFromJson(Map<String, dynamic> json) {
  return SupportMetric(
    id: json['id'] as String?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    tips: (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList(),
    target: json['target'] as int?,
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$SupportMetricToJson(SupportMetric instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'tips': instance.tips,
      'target': instance.target,
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
    };
