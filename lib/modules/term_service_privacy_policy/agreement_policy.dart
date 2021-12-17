import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/term_service_privacy_policy/barrel.dart';
import 'package:test_flutter_web/modules/term_service_privacy_policy/components/agreement_components.dart';

class AgreementAndPolicyPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AgreementController agreementController = Get.find();
  final PolicyController policyController = Get.find();

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
                            title: 'Term of Services & Privacy Policy',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [agreementController, policyController],
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
                                          agreementController, policyController
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([agreementController, policyController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                      flex: 2,
                                      child: buildItemDetail([agreementController, policyController])
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
          controller.subTabInfoModel.title == SubTabInfo.agreement.title) {
        var state = agreementController.state;
        if (state is AgreementLoading || state is AgreementFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: agreementController.info.dataColumn!.length),
            isLoading: (state is AgreementLoading) ? true : false,
            customDialog: AddAgreementDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: AgreementDataSource(controller: agreementController),
          customDialog: AddAgreementDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.policy.title) {
        var state = policyController.state;
        if (state is PolicyLoading || state is PolicyFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: policyController.info.dataColumn!.length),
            isLoading: (state is PolicyLoading) ? true : false,
            // customDialog: AddQuotesDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: PolicyDataSource(controller: policyController),
          // customDialog: AddQuotesDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.agreement.title) {
        var editController = Get.find<EditAgreementController>();
        return ItemDetail(
          itemDetailInfo: AgreementItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditAgreementDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.policy.title) {
        // var editController = Get.find<EditQuoteController>();
        // return ItemDetail(
        //   itemDetailInfo: QuoteItemDetailInfo(),
        //   customDialog: editController.itemDetail == null ? null : EditQuotesDialog(),
        // );
      }
    }
    return Container();
  }
}
