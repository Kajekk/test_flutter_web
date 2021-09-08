import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/modules/authentication/authentication_provider.dart';
import '../../data/models/user.dart';

abstract class IAuthenticationService extends GetxService {
  Future<User?> getCurrentUser();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class AuthenticationService extends IAuthenticationService {
  AuthenticationService({required this.provider});
  final IAuthenticationProvider provider;

  @override
  Future<User?> getCurrentUser() async {
    // simulated delay
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    final res = await provider.signInWithEmailAndPassword(email, password);
    // if (res.status != ApiStatus.Ok) {
    //   print(res.status);
    //   throw AuthenticationException(message: res.message ?? 'Unknown error occurred. ');
    // }
    // return res.data!.first.user;
    return null;

    // await Future.delayed(Duration(seconds: 2));
    //
    // if (email.toLowerCase() != '123' || password != '123') {
    //   throw AuthenticationException(message: 'Wrong username or password, use test:test for testing purpose');
    // }
    //
    // return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
