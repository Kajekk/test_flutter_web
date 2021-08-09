import 'package:get/get.dart';
import 'package:test_flutter_web/models/user.dart';

abstract class AuthenticationService extends GetxService {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService {
  @override
  Future<User?> getCurrentUser() async {
    // simulated delay
    await Future.delayed(Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 2));

    if (email.toLowerCase() != '123' || password != '123') {
      throw AuthenticationException(message: 'Wrong username or password, use test:test for testing purpose');
    }

    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}
