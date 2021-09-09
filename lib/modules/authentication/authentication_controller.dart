import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';
import 'package:test_flutter_web/data/models/user.dart';
import 'package:test_flutter_web/routes/barrel.dart';
import 'authentication.dart';
import 'dart:html';
import 'authentication_service.dart';

class AuthenticationController extends GetxController {
  final IAuthenticationService authenticationService;
  final _authenticationStateStream = AuthenticationState().obs;

  AuthenticationState get state => _authenticationStateStream.value;
  AuthenticationController({required this.authenticationService});

  @override
  void onInit() {
    super.onInit();

    ever(_authenticationStateStream, (state) {
      if (state is Authenticated) {
        Get.offAllNamed(Routes.DASHBOARD);
      }
      if (state is UnAuthenticated) {
        Get.offAllNamed(Routes.LOGIN_PAGE);
      }
    });
    _getAuthenticatedUser();
  }

  Future<void> signIn(String email, String password) async {
      final res = await authenticationService.signInWithEmailAndPassword(email, password);
      if (res != null) {
        if (res.token != null) {
          window.localStorage["access_token"] = res.token!.accessToken ?? "";
        }
        if (res.user != null) {
          _authenticationStateStream.value = Authenticated(user: res.user!);
        }
      } else {
        _authenticationStateStream.value = AuthenticationFailure(message: "Something went wrong, please try again later");
      }
  }

  void signOut() async {
    await authenticationService.signOut();
    _authenticationStateStream.value = UnAuthenticated();
  }

  void _getAuthenticatedUser() async {
   try {
     _authenticationStateStream.value = AuthenticationLoading();

     final user = await authenticationService.getCurrentUser();

     if (user == null) {
       _authenticationStateStream.value = UnAuthenticated();
     } else {
       _authenticationStateStream.value = Authenticated(user: user);
     }
   } on AuthenticationException catch(e){
     _authenticationStateStream.value = UnAuthenticated();
   }
  }
}