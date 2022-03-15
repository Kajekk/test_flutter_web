import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/main.dart';
import 'package:test_flutter_web/modules/account_management/barrel.dart';
import 'package:test_flutter_web/modules/authentication/login/login.dart';
import 'package:test_flutter_web/modules/community_management/barrel.dart';
import 'package:test_flutter_web/modules/dashboard/barrel.dart';
import 'package:test_flutter_web/modules/emotional_management/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';
import 'package:test_flutter_web/modules/home_management/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';
import 'package:test_flutter_web/modules/term_service_privacy_policy/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

import '../modules/main_screen/main_screen.dart';
import 'middlewares.dart';
part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => Dashboard(),
      // binding: InitialBindings(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: Routes.LOGIN_PAGE,
        page: () => LoginPage(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.EMOTIONAL_MANAGEMENT,
        page: () => EmotionalManagementPage(),
        binding: EmotionalManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.EMPLOYMENT_MANAGEMENT,
        page: () => EmploymentManagementPage(),
        binding: EmploymentManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SUPPORT_MANAGEMENT,
        page: () => SupportManagementPage(),
        binding: SupportManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.GOAL_MANAGEMENT,
        page: () => GoalManagementPage(),
        binding: GoalManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.HOME_MANAGEMENT,
        page: () => HomeManagementPage(),
        binding: HomeManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.ACCOUNT_MANAGEMENT,
        page: () => AccountManagementPage(),
        binding: AccountManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.USER_ACCESS_MANAGEMENT,
        page: () => UserAccessManagementPage(),
        binding: UserAccessManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.COMMUNITY_MANAGEMENT,
        page: () => CommunityManagementPage(),
        binding: CommunityManagementBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.TERM_SERVICE_PRIVACY_POLICY,
        page: () => AgreementAndPolicyPage(),
        binding: AgreementAndPolicyBinding(),
        middlewares: [AuthMiddleware()]),
  ];
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUserAccessApiProvider>(() => UserAccessApiProvider());
    Get.lazyPut<IUserAccessRepository>(
            () => UserAccessRepository(provider: Get.find()));
    Get.lazyPut(
          () => OrganisationController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.organisation),
    );
  }
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
