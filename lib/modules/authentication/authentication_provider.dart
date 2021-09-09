import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/api_path.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/user.dart';
import 'package:test_flutter_web/data/provider/base_provider.dart';
import 'package:http/http.dart' as http;

abstract class IAuthenticationProvider {
  Future<BaseResponse<User>> getCurrentUser();
  Future<BaseResponse<UserLoginResponse>> signInWithEmailAndPassword(String email, String password);
  // Future<void> signOut();
}

class AuthenticationProvider extends BaseProvider implements IAuthenticationProvider {

  @override
  Future<BaseResponse<User>> getCurrentUser() async {
    final response = await get(ApiPath.GetMe);
    BaseResponse<User> baseResponse = BaseResponse.fromJson(
        response.body,
            (json) => User.fromJson(json as Map<String, dynamic>));
    return baseResponse;
  }

  @override
  Future<BaseResponse<UserLoginResponse>> signInWithEmailAndPassword(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    final response = await post(ApiPath.Login, jsonEncode(body));
    BaseResponse<UserLoginResponse> baseResponse = BaseResponse.fromJson(
      response.body,
          (json) => UserLoginResponse.fromJson(json as Map<String, dynamic>));
    return baseResponse;
    // return null;
  }
}