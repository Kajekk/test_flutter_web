import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';
import 'controllers.dart';

class EmotionalManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EmotionalLogController controller1 = Get.find();

  @override
  Widget build(BuildContext context) {
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
                          Header(
                            scaffoldKey: _scaffoldKey,
                            title: 'Emotional Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [controller1],
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          Obx(() {
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                      children: [
                                        buildListItem([
                                          controller1,
                                          // controller2,
                                          // controller3
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([controller1])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([controller1])
                                  )
                              ],
                            );
                          }),
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  Widget buildListItem(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.emotionalLog.title) {
        var state = controller1.emotionalLogState;
        if (state is EmotionalLogLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: EmotionalLogData(controller: controller1),
            customDialog: CustomDialog(),
          );
        }
        if (state is EmotionalLogLoading) {
          return ListItem(
            controller: controller,
            dataTableSource: EmotionalLogData(controller: controller1),
            customDialog: CustomDialog(),
            isLoading: true,
          );
        }
        // return ListItem(
        //   controller: controller,
        //   dataTableSource: MyData(),
        //   isLoading: ((controller as EntityTypeController).emotionalLogState
        //           is EmotionalLoading)
        //       ? true
        //       : false,
        // );
      }
      // if (controller.isCurrent &&
      //     controller.subTabInfoModel.title ==
      //         SubTabInfo.userPermissions.title) {
      //   return ListItem(controller: controller, dataTableSource: MyData());
      // }
      // if (controller.isCurrent &&
      //     controller.subTabInfoModel.title == SubTabInfo.userRoles.title) {
      //   return ListItem(controller: controller, dataTableSource: MyData());
      // }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.emotionalLog.title) {
        // var state = controller1.emotionalLogState;
        return ItemDetail(
          controller: controller,
          itemDetailInfo: EmotionalLogItemDetailInfo(),
        );
      }
    }
    return Container();
  }
}
