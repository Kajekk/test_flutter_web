import 'package:get/get.dart';
import '../authentication.dart';
import 'login_state.dart';

class LoginController  extends GetxController {
  final AuthenticationController _authenticationController = Get.find();
  final _loginStateStream = LoginState().obs;
  final _autoValidate = false.obs;
  final _obscureText = true.obs;

  LoginState get state => _loginStateStream.value;
  bool get autoValidate => _autoValidate.value;
  bool get obscureText => _obscureText.value;

  void login(String email, String password) async {
    _loginStateStream.value = LoginLoading();

    try{
      await _authenticationController.signIn(email, password);
      _loginStateStream.value = LoginState();
    } on AuthenticationException catch(e){
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }

  void changeAutoValidate() {
    _autoValidate.value = true;
  }
  void toggleObscureText() {
    _obscureText.value = !_obscureText.value;
  }
}