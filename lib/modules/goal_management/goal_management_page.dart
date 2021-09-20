import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/goal_states.dart';
import 'barrel.dart';

class GoalManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GoalController goalController = Get.find();
  final GoalFrequencyController goalFrequencyController = Get.find();

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
                            title: 'Goal Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [goalController, goalFrequencyController],
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
                                          goalController, goalFrequencyController
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([goalController, goalFrequencyController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                      flex: 2,
                                      child: buildItemDetail([goalController, goalFrequencyController])
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
          controller.subTabInfoModel.title == SubTabInfo.goal.title) {
        var state = goalController.goalState;
        if (state is GoalLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: GoalData(controller: goalController),
            customDialog: GoalDetailDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: EmptyDataSource(numCol: goalController.info.dataColumn!.length),
          isLoading: (state is GoalLoading) ? true : false,
          customDialog: GoalDetailDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.goalFrequency.title) {
        var state = goalFrequencyController.goalState;
        if (state is GoalFrequencyLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: GoalFrequencyData(controller: goalFrequencyController),
            customDialog: GoalFrequencyDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: EmptyDataSource(numCol: goalFrequencyController.info.dataColumn!.length),
          isLoading: (state is GoalFrequencyLoading) ? true : false,
          customDialog: GoalFrequencyDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.goal.title) {
        var editController = Get.find<EditGoalController>();
        return ItemDetail(
          itemDetailInfo: GoalItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditGoalDetailDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.goalFrequency.title) {
        var editController = Get.find<EditGoalFrequencyController>();
        return ItemDetail(
          itemDetailInfo: GoalFrequencyItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditGoalFrequencyDialog(),
        );
      }
    }
    return Container();
  }
}
