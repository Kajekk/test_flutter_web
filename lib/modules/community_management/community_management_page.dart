import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';
import 'components/barrel.dart';

class CommunityManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TopicController topicController = Get.find();

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
                            title: 'Community Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [topicController,],
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
                                          topicController,
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([topicController,])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([topicController,])
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
          controller.subTabInfoModel.title == SubTabInfo.communityTopic.title) {
        var state = topicController.topicStateStream;
        if (state is CommunityTopicLoading || state is CommunityTopicFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: topicController.info.dataColumn!.length),
            customDialog: CommunityTopicDialog(),
          );
        }
        if (state is CommunityTopicLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: CommunityTopicData(controller: topicController),
            customDialog: CommunityTopicDialog(),
          );
        }
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.communityTopic.title) {
        var editController = Get.find<EditCommunityTopicController>();
          return ItemDetail(
            itemDetailInfo: CommunityTopicItemDetailInfo(),
            customDialog: editController.itemDetail == null ? null : EditCommunityTopicDialog(),
          );
      }
    }
    return Container();
  }
}
