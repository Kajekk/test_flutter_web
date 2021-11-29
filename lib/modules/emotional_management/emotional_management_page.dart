import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';
import 'components/barrel.dart';

class EmotionalManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EmotionalLogController emoController = Get.find();
  final EmotionTypeController emoTypeController = Get.find();

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
                            listController: [emoController, emoTypeController],
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
                                          emoController,
                                          emoTypeController,
                                          // controller3
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([emoController, emoTypeController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([emoController, emoTypeController])
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
        var state = emoController.emotionalLogState;
        if (state is EmotionalLogLoading || state is EmotionalLogFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: emoController.info.dataColumn!.length),
            isLoading: true,
          );
        }
        if (state is EmotionalLogLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: EmotionalLogData(controller: emoController),
            customDialog: EmotionalLogDialog(),
          );
        }
      }
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.emotionType.title) {
        var state = emoTypeController.emotionTypeState;
        if (state is EmotionTypeLoading || state is EmotionTypeFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: emoTypeController.info.dataColumn!.length),
            isLoading: true,
          );
        }
        if (state is EmotionTypeLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: EmotionTypeData(controller: emoTypeController),
            // customDialog: EmotionTypeDialog(),
          );
        }
      }
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
        var editController = Get.find<EditEmotionalLogController>();
          return ItemDetail(
            itemDetailInfo: EmotionalLogItemDetailInfo(),
            customDialog: editController.itemDetail == null ? null : EditEmotionalLogDialog(),
          );
      }
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.emotionType.title) {
        var editController = Get.find<EditEmotionTypeController>();
        return ItemDetail(
          itemDetailInfo: EmotionTypeItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditEmotionTypeDialog(),
        );
      }
    }
    return Container();
  }
}
