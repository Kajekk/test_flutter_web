import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/account_management/components/barrel.dart';
import 'package:test_flutter_web/modules/account_management/controllers/barrel.dart';
import 'package:test_flutter_web/modules/account_management/states/barrel.dart';

class AccountManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PwdController pwdController = Get.find();
  final ProController proController = Get.find();

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
                            title: 'Account Management',
                          ),
                          SizedBox(
                            height: defaultPadding,
                          ),
                          SubTabs(
                            listController: [proController, pwdController, ],
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
                                          proController,
                                          pwdController,
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([proController, pwdController])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                      flex: 2,
                                      child: buildItemDetail([proController, pwdController])
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
          controller.subTabInfoModel.title == SubTabInfo.pwdAccount.title) {
        var state = pwdController.state;
        if (state is PwdAccountLoading || state is PwdAccountFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: pwdController.info.dataColumn!.length),
            isLoading: (state is PwdAccountLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: PwdAccountDataSource(controller: pwdController),
          customDialog: AddPwdDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.proAccount.title) {
        var state = proController.state;
        if (state is ProAccountLoading || state is ProAccountFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: proController.info.dataColumn!.length),
            isLoading: (state is ProAccountLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: ProAccountDataSource(controller: proController),
          customDialog: AddProDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.pwdAccount.title) {
        var editController = Get.find<EditPwdAccountController>();
        return ItemDetail(
          itemDetailInfo: PwdAccountItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditPwdDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.proAccount.title) {
        var editController = Get.find<EditProAccountController>();
        return ItemDetail(
          itemDetailInfo: ProAccountItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditProDialog(),
        );
      }
    }
    return Container();
  }
}
