import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';

class EmploymentManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EmploymentDetailController empController = Get.find();
  final WorkplaceDetailController wpdController = Get.find();
  final ProWorkScheduleController proScheduleController = Get.find();
  final ContactFormController contactFormController = Get.find();

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
                            listController: [empController, proScheduleController, wpdController, contactFormController],
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
                                          proScheduleController,
                                          wpdController,
                                          contactFormController
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([empController, proScheduleController, wpdController, contactFormController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([empController, proScheduleController, wpdController, contactFormController])
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
        if (state is EmploymentDetailLoading || state is EmploymentDetailFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: empController.info.dataColumn!.length),
            isLoading: (state is EmploymentDetailLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: EmploymentDetailData(context: _scaffoldKey.currentContext!, controller: empController),
          customDialog: EmploymentDetailDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.workplaceDetail.title) {
        var state = wpdController.state;
        if (state is WorkplaceDetailLoading || state is WorkplaceDetailFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: wpdController.info.dataColumn!.length),
            isLoading: (state is WorkplaceDetailLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: WorkplaceDetailData(context: _scaffoldKey.currentContext!, controller: wpdController),
          customDialog: WorkplaceDetailDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.proWorkSchedule.title) {
        var state = proScheduleController.state;
        if (state is ProWorkScheduleLoading || state is ProWorkScheduleFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: proScheduleController.info.dataColumn!.length),
            isLoading: (state is ProWorkScheduleLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: ProScheduleDetailData(context: _scaffoldKey.currentContext!, controller: proScheduleController),
          customDialog: AddProWorkDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.contactForm.title) {
        var state = contactFormController.state;
        if (state is ContactFormLoading || state is ContactFormFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: contactFormController.info.dataColumn!.length),
            isLoading: (state is ContactFormLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: ContactFormDataSource(context: _scaffoldKey.currentContext!, controller: contactFormController),
          // customDialog: EmploymentDetailDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.employmentDetail.title) {
        var editController = Get.find<EditEmploymentController>();
        return ItemDetail(
          itemDetailInfo: EmploymentItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditEmploymentDetailDialog(),
        );
      }
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.workplaceDetail.title) {
        var editController = Get.find<EditWorkplaceController>();
        return ItemDetail(
          itemDetailInfo: WorkplaceItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditWorkplaceDetailDialog(),
        );
      }
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.proWorkSchedule.title) {
        var editController = Get.find<EditProScheduleController>();
        return ItemDetail(
          itemDetailInfo: ProWorkItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditProWorkDialog(),
        );
      }
    }
    return Container();
  }
}



