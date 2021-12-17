import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/data_table_source/support_log_data_source.dart';
import 'package:test_flutter_web/data/data_table_source/support_metric_data_source.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';

class SupportManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AttendanceController atController = Get.find();
  final SupportMetricController spMetricController = Get.find();
  final SupportLogController spLogController = Get.find();
  final LocationTrackingController locationController = Get.find();

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
                            title: 'Support Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [atController, spMetricController, spLogController, locationController],
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
                                      CrossAxisAlignment.start,
                                      children: [
                                        buildListItem([
                                          atController,
                                          spMetricController,
                                          spLogController,
                                          locationController
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([atController, spMetricController, spLogController, locationController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                    flex: 2,
                                    child: buildItemDetail([atController, spMetricController, spLogController, locationController])
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
          controller.subTabInfoModel.title == SubTabInfo.checkInOut.title) {
        var state = atController.attendanceState;
        if (state is AttendanceLoading || state is AttendanceFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: atController.info.dataColumn!.length),
            isLoading: (state is AttendanceLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: AttendanceDataSource(context: _scaffoldKey.currentContext!, controller: atController),
          customDialog: AttendanceDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.supportMetric.title) {
        var state = spMetricController.state;
        if (state is SupportMetricLoading || state is SupportMetricFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: spMetricController.info.dataColumn!.length),
            isLoading: (state is SupportMetricLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: SupportMetricDataSource(context: _scaffoldKey.currentContext!, controller: spMetricController),
          customDialog: AddSupportMetricDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.supportLog.title) {
        var state = spLogController.state;
        if (state is SupportLogLoading || state is SupportLogFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: spLogController.info.dataColumn!.length),
            isLoading: (state is SupportLogLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: SupportLogDataSource(context: _scaffoldKey.currentContext!, controller: spLogController),
          customDialog: AddSupportLogDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.locationTracking.title) {
        var state = locationController.state;
        if (state is LocationTrackingLoading || state is LocationTrackingFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: locationController.info.dataColumn!.length),
            isLoading: (state is LocationTrackingLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: LocationTrackingDataSource(context: _scaffoldKey.currentContext!, controller: locationController),
          // customDialog: AttendanceDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.checkInOut.title) {
        var editController = Get.find<EditAttendanceController>();
        return ItemDetail(
          itemDetailInfo: AttendanceItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditAttendanceDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.supportMetric.title) {
        var editController = Get.find<EditSupportMetricController>();
        return ItemDetail(
          itemDetailInfo: SupportMetricItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditSupportMetricDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.supportLog.title) {
        var editController = Get.find<EditSupportLogController>();
        return ItemDetail(
          itemDetailInfo: SupportLogItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditSupportLogDialog(),
        );
      }
    }
    return Container();
  }
}
