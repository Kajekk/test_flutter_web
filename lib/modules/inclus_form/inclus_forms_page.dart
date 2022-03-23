import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/inclus_form/barrel.dart';

class InclusFormPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final InclusiveEmploymentController inclusiveEmploymentController = Get.find();
  final ContactUsController contactUsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
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
                            title: 'Inclus Forms',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [inclusiveEmploymentController, contactUsController],
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
                                          inclusiveEmploymentController, contactUsController
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([inclusiveEmploymentController, contactUsController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                      flex: 2,
                                      child: buildItemDetail([inclusiveEmploymentController, contactUsController])
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
          controller.subTabInfoModel.title == SubTabInfo.inclusiveEmployment.title) {
        var state = inclusiveEmploymentController.state;
        if (state is InclusiveEmploymentLoading || state is InclusiveEmploymentFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: inclusiveEmploymentController.info.dataColumn!.length),
            isLoading: (state is InclusiveEmploymentLoading) ? true : false,
            // customDialog: AddQuotesDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: InclusiveEmploymentDataSource(controller: inclusiveEmploymentController),
          // customDialog: AddQuotesDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.contactUs.title) {
        var state = contactUsController.state;
        if (state is ContactUsLoading || state is ContactUsFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: contactUsController.info.dataColumn!.length),
            isLoading: (state is ContactUsLoading) ? true : false,
            // customDialog: AddQuotesDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: ContactUsDataSource(controller: contactUsController),
          // customDialog: AddQuotesDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.inclusiveEmployment.title) {
        var editController = Get.find<EditInclusiveEmploymentController>();
        return ItemDetail(
          itemDetailInfo: InclusiveEmploymentDetailInfo(),
          // customDialog: editController.itemDetail == null ? null : EditQuotesDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.contactUs.title) {
        var editController = Get.find<EditContactUsController>();
        return ItemDetail(
          itemDetailInfo: ContactUsDetailInfo(),
          // customDialog: editController.itemDetail == null ? null : EditQuotesDialog(),
        );
      }
    }
    return Container();
  }
}