import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';
import 'controllers.dart';

class EmploymentManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EmploymentDetailController empController = Get.find();

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
                            title: 'Employment Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [empController],
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
                                          empController,

                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([empController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([empController])
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
          controller.subTabInfoModel.title == SubTabInfo.employmentDetail.title) {
        var state = empController.employmentState;
        if (state is EmploymentDetailLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: EmploymentDetailData(context: _scaffoldKey.currentContext!, controller: empController),
            customDialog: null,
          );
        }
        if (state is EmploymentDetailLoading) {
          return ListItem(
            controller: controller,
            dataTableSource: LoadingDataSource(numCol: empController.info.dataColumn!.length),
            customDialog: null,
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
          controller.subTabInfoModel.title == SubTabInfo.employmentDetail.title) {
        // var state = empController.emotionalLogState;
        return ItemDetail(
          controller: controller,
          itemDetailInfo: EmploymentItemDetailInfo(),
        );
      }
    }
    return Container();
  }
}



