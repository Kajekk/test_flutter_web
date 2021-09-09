// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    email: json['email'] as String?,
    name: json['name'] as String?,
    photoUrl: json['photo_url'] as String?,
    role: json['role'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'photo_url': instance.photoUrl,
      'role': instance.role,
    };

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) {
  return UserLoginResponse(
    token: json['token'] == null
        ? null
        : Token.fromJson(json['token'] as Map<String, dynamic>),
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'token': instance.token?.toJson(),
    };

Token _$TokenFromJson(Map<String, dynamic> json) {
  return Token(
    accessToken: json['access_token'] as String?,
    refreshToken: json['refresh_token'] as String?,
    csrfToken: json['csrf_token'] as String?,
    accessUuid: json['access_uuid'] as String?,
    refreshUuid: json['refresh_uuid'] as String?,
    csrfUuid: json['csrf_uuid'] as String?,
    atExpires: json['at_expires'] as int?,
    rtExpires: json['rt_expires'] as int?,
    ctExpires: json['ct_expires'] as int?,
  );
}

Map<String, dynamic> _$TokenToJson(Token instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'csrf_token': instance.csrfToken,
      'access_uuid': instance.accessUuid,
      'refresh_uuid': instance.refreshUuid,
      'csrf_uuid': instance.csrfUuid,
      'at_expires': instance.atExpires,
      'rt_expires': instance.rtExpires,
      'ct_expires': instance.ctExpires,
    };
