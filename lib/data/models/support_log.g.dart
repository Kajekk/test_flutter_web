// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'support_log.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupportLog _$SupportLogFromJson(Map<String, dynamic> json) {
  return SupportLog(
    id: json['id'] as String?,
    email: json['email'] as String?,
    type: json['type'] as String?,
    forUid: json['for_uid'] as String?,
    forEmail: json['for_email'] as String?,
    startAt: json['start_at'] == null
        ? null
        : DateTime.parse(json['start_at'] as String),
    endAt: json['end_at'] == null
        ? null
        : DateTime.parse(json['end_at'] as String),
    observations: (json['observations'] as List<dynamic>?)
        ?.map((e) => Observation.fromJson(e as Map<String, dynamic>))
        .toList(),
    metrics: (json['metrics'] as List<dynamic>?)
        ?.map((e) => Metric.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdTime: json['created_time'] == null
        ? null
        : DateTime.parse(json['created_time'] as String),
    lastUpdatedTime: json['last_updated_time'] == null
        ? null
        : DateTime.parse(json['last_updated_time'] as String),
  );
}

Map<String, dynamic> _$SupportLogToJson(SupportLog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'type': instance.type,
      'for_uid': instance.forUid,
      'for_email': instance.forEmail,
      'start_at': instance.startAt?.toIso8601String(),
      'end_at': instance.endAt?.toIso8601String(),
      'created_time': instance.createdTime?.toIso8601String(),
      'last_updated_time': instance.lastUpdatedTime?.toIso8601String(),
      'observations': instance.observations?.map((e) => e.toJson()).toList(),
      'metrics': instance.metrics?.map((e) => e.toJson()).toList(),
    };

Observation _$ObservationFromJson(Map<String, dynamic> json) {
  return Observation(
    description: json['description'] as String?,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
  );
}

Map<String, dynamic> _$ObservationToJson(Observation instance) =>
    <String, dynamic>{
      'description': instance.description,
      'time': instance.time?.toIso8601String(),
    };

Metric _$MetricFromJson(Map<String, dynamic> json) {
  return Metric(
    name: json['name'] as String?,
    metricId: json['metric_id'] as String?,
    value: json['value'] as int?,
  );
}

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'name': instance.name,
      'metric_id': instance.metricId,
      'value': instance.value,
    };
