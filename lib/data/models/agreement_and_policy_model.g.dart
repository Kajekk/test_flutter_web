// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agreement_and_policy_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Agreement _$AgreementFromJson(Map<String, dynamic> json) {
  return Agreement(
    id: json['id'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$AgreementToJson(Agreement instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };

Policy _$PolicyFromJson(Map<String, dynamic> json) {
  return Policy(
    id: json['id'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$PolicyToJson(Policy instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
    };
