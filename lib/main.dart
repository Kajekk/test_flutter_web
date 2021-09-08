import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/modules/authentication/authentication.dart';
import 'package:test_flutter_web/modules/authentication/authentication_provider.dart';
import 'package:test_flutter_web/modules/authentication/login/login.dart';
import 'package:test_flutter_web/routes/app_pages.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:get/get.dart';

import 'global_widgets/controllers/category_controller.dart';
import 'modules/dashboard/barrel.dart';
import 'modules/splash/splash.dart';

void main() {
  initialize();
  runApp(MyApp());
}

void initialize() {
  Get.lazyPut<IAuthenticationProvider>(() => AuthenticationProvider());
  Get.lazyPut<IAuthenticationService>(
      () => AuthenticationService(provider: Get.find()));
  Get.lazyPut(
    () => AuthenticationController(authenticationService: Get.find()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            // primarySwatch: Colors.blue,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            canvasColor: bgColor,
            cardColor: secondaryColor,
            // dividerColor: Colors.green,
            disabledColor: bodyTextColor,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white)
                .copyWith(
                  bodyText1: TextStyle(color: bodyTextColor),
                  bodyText2: TextStyle(color: bodyTextColor),
                  caption: TextStyle(color: bodyTextColor),
                )),
        // initialRoute: Routes.LOGIN_PAGE,
        // initialBinding: MainScreenBinding(),
        getPages: AppPages.pages,
        onGenerateRoute: (settings) {
          print('123123');
        },
        home: AppView());
    // home: Obx(() {
    //   if (controller.state is UnAuthenticated) {
    //     return LoginPage();
    //   }
    //   if (controller.state is Authenticated) {
    //     return Dashboard();
    //     // return GetBuilder(
    //     //     tag: 'user-access-management',
    //     //     init: CategoryController(
    //     //         listCategoryCard: categoryData.obs,
    //     //         mapCategoryCard: categoryMap.obs),
    //     //     builder: (_) => UserAccessManagementPage());
    //   }
    //   return SplashScreen();
    // }));
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => MenuController())
    //   ],
    //   child: GetMaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: 'Flutter Demo',
    //     theme: ThemeData(
    //       // primarySwatch: Colors.blue,
    //       primaryColor: primaryColor,
    //       scaffoldBackgroundColor: bgColor,
    //       canvasColor: bgColor,
    //       textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
    //         bodyColor: Colors.white
    //       ).copyWith(
    //         bodyText1: TextStyle(color: bodyTextColor),
    //         bodyText2: TextStyle(color: bodyTextColor),
    //       )
    //     ),
    //     initialRoute: Routes.INITIAL,
    //     // initialBinding: MainScreenBinding(),
    //     getPages: AppPages.pages,
    //     // home: MainScreen(contentPage: AllRoutes.accountManagement,),
    //   ),
    // );
  }
}

class AppView extends GetWidget<AuthenticationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
