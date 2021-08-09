import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_web/modules/main_screen/controllers.dart';
import 'package:test_flutter_web/modules/main_screen/menu_controller.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key, required this.scaffoldKey, required this.title,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.menu),
              // onPressed: context.read<MenuController>().openControlMenu,
              onPressed: () {
                scaffoldKey.currentState!.openDrawer();
                // Get.find<MainScreenController>().openDrawer();
              },
            ),
          ),
        if (!Responsive.isMobile(context))
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
        if (!Responsive.isMobile(context))
          Spacer(
            flex: Responsive.isDesktop(context) ? 2 : 1,
          ),
        Expanded(child: SearchField()),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/search.svg"),
          ),
        ),
      ),
    );
  }
}
