import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/modules/authentication/login/login.dart';
import 'package:test_flutter_web/modules/support_management/binding.dart';
import 'package:test_flutter_web/modules/support_management/support_management_page.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

import '../modules/main_screen/main_screen.dart';
import 'middlewares.dart';
part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: Routes.LOGIN_PAGE,
        page: () => LoginPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.USER_ACCESS_MANAGEMENT,
        page: () => UserAccessManagementPage(),
        binding: UserAccessManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SUPPORT_MANAGEMENT,
        page: () => SupportManagementPage(),
        binding: SupportManagementBinding(),
        middlewares: [AuthMiddleware()]),
  ];
}

class RouteView {
  const RouteView(this.index, this.label, this.dataColumn, this.dataRow);
  final int index;
  // final Widget page;
  final String label;
  final List<String> dataColumn;
  final Object dataRow;
}

// List<RouteView> allRoutes = <RouteView>[
//   RouteView(0, Container(), "Account Management"),
// ];

abstract class AllRoutes {
  static final RouteView accountManagement =
      RouteView(0, "Account Management", [], Container());
  static final RouteView accountManagement2 =
      RouteView(0, "QWEQWEQWEQWEWQWE", [], Container());
}

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  if (settings.name == '/') {
    print('qweqweqqwe');
    return GetPageRoute(
      page: () => Center(
        child: TextButton(
          onPressed: () {
            Get.toNamed('/second',
                id: 1); // navigate by your nested route by index
          },
          child: Text("Go to second"),
        ),
      ),
    );
  } else if (settings.name == '/second') {
    return GetPageRoute(
      page: () => Center(child: Text("second")),
    );
  }

  return MaterialPageRoute(builder: (context) => Container());
}