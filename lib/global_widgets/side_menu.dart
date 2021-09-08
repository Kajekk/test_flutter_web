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
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.toNamed(Routes.DASHBOARD);
            },
          ),
          DrawerListTile(
            title: "User Access Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.toNamed(Routes.USER_ACCESS_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Account Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.toNamed(Routes.SUPPORT_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Home Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Goal Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Employment Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.toNamed(Routes.SUPPORT_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Support Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Get.toNamed(Routes.SUPPORT_MANAGEMENT);
            },
          ),
          DrawerListTile(
            title: "Emotional Management",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {},
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
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}