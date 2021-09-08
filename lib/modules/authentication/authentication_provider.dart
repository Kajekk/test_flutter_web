import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:test_flutter_web/data/models/base_response.dart';
import 'package:test_flutter_web/data/models/user.dart';
import 'package:test_flutter_web/data/provider/base_provider.dart';
import 'package:http/http.dart' as http;

abstract class IAuthenticationProvider {
  // Future<User?> getCurrentUser();
  Future<BaseResponse<UserLoginResponse>?> signInWithEmailAndPassword(String email, String password);
  // Future<void> signOut();
}

class AuthenticationProvider extends BaseProvider implements IAuthenticationProvider {

  @override
  Future<BaseResponse<UserLoginResponse>?> signInWithEmailAndPassword(String email, String password) async {
    var body = {
      "email": email,
      "password": password,
    };
    Response<Map<String, dynamic>> response = await post("/pro/v1/login", jsonEncode(body));
    print(response.body);
    // BaseResponse<UserLoginResponse> baseResponse = BaseResponse.fromJson(
    //   response.body,
    //       (json) => UserLoginResponse.fromJson(json as Map<String, dynamic>));
    // return baseResponse;
    return null;
  }
}