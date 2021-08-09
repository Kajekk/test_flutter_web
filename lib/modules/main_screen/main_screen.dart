import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/category.dart';
import 'package:test_flutter_web/global_widgets/header.dart';
import 'package:test_flutter_web/global_widgets/item_detail.dart';
import 'package:test_flutter_web/global_widgets/list_item.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import 'package:test_flutter_web/modules/main_screen/controllers.dart';
import 'package:test_flutter_web/modules/main_screen/menu_controller.dart';
import 'package:test_flutter_web/routes/app_pages.dart';
import 'package:provider/provider.dart';

import '../../global_widgets/side_menu.dart';

class MainScreen extends GetView<MainScreenController> {
  MainScreen({Key? key, required this.contentPage}) : super(key: key);

  final RouteView contentPage;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(Get.find<MainScreenController>().rng.nextInt(100));

    return Scaffold(
      // key: context.read<MenuController>().scaffoldKey,
      // key: _scaffoldKey,
      key: Get.find<MainScreenController>().scaffoldKey,
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
                          // Header(scaffoldKey: _scaffoldKey),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          // Category(),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      // ListItem(dataColumn: dataColumn),
                                      if (Responsive.isMobile(context))
                                        SizedBox(
                                          height: defaultPadding,
                                        ),
                                      if (Responsive.isMobile(context))
                                        ItemDetail(),
                                    ],
                                  )),
                              if (!Responsive.isMobile(context))
                                SizedBox(
                                  width: defaultPadding,
                                ),
                              if (!Responsive.isMobile(context))
                                Expanded(
                                  flex: 2,
                                  child: ItemDetail(),
                                )
                            ],
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

List<String> dataColumn = [
  "Organization",
  "Type",
  "Role",
  "Account Name",
];
