import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/routes/app_pages.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 250,
              minWidth: double.infinity
            ),
            color: Color(0xFF242430),
            margin: EdgeInsets.only(bottom: defaultPadding / 2),
            child: DrawerHeader(child: Column(
              children: [
                Spacer(flex: 2),
                CircleAvatar(
                  radius: 50,
                  // backgroundImage: AssetImage("assets/images/logo.jpg"),
                ),
                Spacer(),
                Text(
                  "User name",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                Text(
                  "Admin Coach Role",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    height: 1.5,
                  ),
                ),
                Spacer(flex: 2),
              ],
            )),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icon(
              Icons.dashboard,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.DASHBOARD);
            },
          ),
          // DrawerListTile(
          //   title: "User Access Management",
          //   svgSrc: "assets/icons/menu_dashboard.svg",
          //   press: () {
          //     // Get.toNamed(Routes.USER_ACCESS_MANAGEMENT);
          //   },
          // ),
          // DrawerListTile(
          //   title: "Account Management",
          //   svgSrc: "assets/icons/menu_dashboard.svg",
          //   press: () {
          //     // Get.toNamed(Routes.SUPPORT_MANAGEMENT);
          //   },
          // ),
          DrawerListTile(
            title: "Home Management",
            icon: Icon(
              Icons.home_outlined,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.HOME_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Goal Management",
            icon: Icon(
              Icons.track_changes_outlined,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.GOAL_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Employment Management",
            icon: Icon(
              Icons.work_outlined,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.EMPLOYMENT_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Support Management",
            icon: Icon(
              Icons.support_outlined,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.SUPPORT_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Emotional Management",
            icon: Icon(
              Icons.mood_outlined,
              color: bodyTextColor,
            ),
            press: () {
              Get.toNamed(Routes.EMOTIONAL_MANAGEMENT);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}