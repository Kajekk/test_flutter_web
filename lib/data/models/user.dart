import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  const User({
    this.email,
    this.name,
    this.photoUrl,
    this.role,
  });

  final String? email;
  final String? name;
  final String? photoUrl;
  final String? role;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User { name: $name, photoUrl: $photoUrl, '
        'email: $email, role: $role }';
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class UserLoginResponse extends Equatable {
  const UserLoginResponse({
    this.token,
    this.user,
  });

  final User? user;
  final Token? token;

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Token extends Equatable {
  const Token(
      {this.accessToken,
      this.refreshToken,
      this.accessUuid,
      this.refreshUuid,
      this.atExpires,
      this.rtExpires});

  final String? accessToken;
  final String? refreshToken;
  final String? accessUuid;
  final String? refreshUuid;
  final int? atExpires;
  final int? rtExpires;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);
  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @override
  List<Object?> get props => [];
}
