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
                                RouteButton(title: "User Access Management", route: Routes.USER_ACCESS_MANAGEMENT,
                                  icon: Icon(
                                    Icons.admin_panel_settings,
                                  ),
                                ),
                                RouteButton(title: "Account Management", route: Routes.ACCOUNT_MANAGEMENT,
                                  icon: Icon(
                                    Icons.people,
                                  ),
                                ),
                                RouteButton(title: "Home Management", route: Routes.HOME_MANAGEMENT,
                                  icon: Icon(
                                    Icons.home_outlined,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            Wrap(
                              spacing: defaultPadding,
                              // runAlignment: WrapAlignment.center,
                              children: [
                                RouteButton(title: "Goal Management", route: Routes.GOAL_MANAGEMENT, icon: Icon(
                                  Icons.track_changes_outlined,
                                ),),
                                RouteButton(title: "Employment Management", route: Routes.EMPLOYMENT_MANAGEMENT, icon: Icon(
                                  Icons.work_outlined,
                                ),),
                                RouteButton(title: "Support Management", route: Routes.SUPPORT_MANAGEMENT, icon: Icon(
                                  Icons.support_outlined,
                                ),),
                              ],
                            ),
                            SizedBox(
                              height: defaultPadding,
                            ),
                            Wrap(
                              spacing: defaultPadding,
                              // runAlignment: WrapAlignment.center,
                              children: [
                                RouteButton(title: "Emotional Management", route: Routes.EMOTIONAL_MANAGEMENT, icon: Icon(
                                  Icons.mood_outlined,
                                ),),
                                RouteButton(title: "Term of Service & Privacy Policy", route: Routes.TERM_SERVICE_PRIVACY_POLICY, icon: Icon(
                                  Icons.privacy_tip_outlined,
                                ),),
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
  RouteButton({required this.route, required this.title, required this.icon});
  final String route;
  final String title;
  final Icon icon;

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
            icon,
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

