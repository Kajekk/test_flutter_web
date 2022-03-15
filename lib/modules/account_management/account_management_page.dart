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
  final AccountController accountController = Get.find();

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
                            listController: [accountController,],
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
                                          accountController,
                                        ]),
                                        if (Responsive.isMobile(context))
                                          SizedBox(
                                            height: defaultPadding,
                                          ),
                                        if (Responsive.isMobile(context))
                                          buildItemDetail([accountController,])
                                      ],
                                    )),
                                if (!Responsive.isMobile(context))
                                  SizedBox(
                                    width: defaultPadding,
                                  ),
                                if (!Responsive.isMobile(context))
                                  Expanded(
                                      flex: 2,
                                      child: buildItemDetail([accountController,])
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
          controller.subTabInfoModel.title == SubTabInfo.account.title) {
        var state = accountController.state;
        if (state is AccountLoading || state is AccountFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(numCol: accountController.info.dataColumn!.length),
            isLoading: (state is AccountLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: AccountDataSource(controller: accountController),
          customDialog: AddAccountDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.account.title) {
        var editController = Get.find<EditAccountController>();
        return ItemDetail(
          itemDetailInfo: AccountItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditAccountDialog(),
        );
      }
    }
    return Container();
  }
}
