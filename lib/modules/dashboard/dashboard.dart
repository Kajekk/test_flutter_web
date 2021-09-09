import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/routes/barrel.dart';

class Dashboard extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        // constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (!Responsive.isDesktop(context))
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: defaultPadding),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.menu),
                                // onPressed: context.read<MenuController>().openControlMenu,
                                onPressed: () {
                                  _scaffoldKey.currentState!.openDrawer();
                                  // Get.find<MainScreenController>().openDrawer();
                                },
                              ),
                            ),
                          if (!Responsive.isMobile(context))
                            Text(
                              'Dashboard',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          if (!Responsive.isMobile(context))
                            Spacer(
                              flex: Responsive.isDesktop(context) ? 2 : 1,
                            ),
                        ],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Container(
                        // margin: EdgeInsets.all(defaultPadding),
                        padding: EdgeInsets.all(defaultPadding),
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Wrap(
                              spacing: defaultPadding,
                              // runAlignment: WrapAlignment.center,
                              children: [
                                // RouteButton(title: "User Access Management", route: Routes.USER_ACCESS_MANAGEMENT),
                                // RouteButton(title: "Account Management", route: Routes.USER_ACCESS_MANAGEMENT),
                                // RouteButton(title: "Home Management", route: Routes.USER_ACCESS_MANAGEMENT),
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            Wrap(
                              spacing: defaultPadding,
                              // runAlignment: WrapAlignment.center,
                              children: [
                                // RouteButton(title: "Goal Management", route: Routes.USER_ACCESS_MANAGEMENT),
                                RouteButton(title: "Employment Management", route: Routes.EMPLOYMENT_MANAGEMENT),
                                RouteButton(title: "Support Management", route: Routes.SUPPORT_MANAGEMENT),
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            Wrap(
                              spacing: defaultPadding,
                              // runAlignment: WrapAlignment.center,
                              children: [
                                RouteButton(title: "Emotional Management", route: Routes.EMOTIONAL_MANAGEMENT),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  RouteButton({required this.route, required this.title});
  final String route;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset(
              "assets/icons/menu_dashboard.svg",
              color: Colors.white54,
              height: 24,
            ),
            SizedBox(height: defaultPadding,),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}

