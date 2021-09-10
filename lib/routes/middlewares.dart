import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/modules/authentication/authentication.dart';
import 'app_pages.dart';

class AuthMiddleware extends GetMiddleware {
  final AuthenticationController authenticationController = Get.find();

  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (authenticationController.state is Authenticated) {
      if (route == Routes.LOGIN_PAGE) {
        return RouteSettings(name: Get.currentRoute);
      } else {
        return null;
      }
    } else if (authenticationController.state is UnAuthenticated) {
        // return RouteSettings(name: Routes.SPLASH);
      if (route == Routes.LOGIN_PAGE) {
        return null;
      }
      return RouteSettings(name: Routes.LOGIN_PAGE);
    }
  }
}
