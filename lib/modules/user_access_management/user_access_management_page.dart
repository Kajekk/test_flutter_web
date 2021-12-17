import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/data_table_source/permission_data_source.dart';
import 'package:test_flutter_web/data/data_table_source/role_data_source.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/components/barrel.dart';

class UserAccessManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PermissionController permissionController = Get.find();
  final PermissionModuleController permissionModuleController = Get.find();
  final RoleController roleController = Get.find();
  final OrganisationController organisationController = Get.find();

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
                        title: 'User Access Management',
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      SubTabs(
                        listController: [
                          organisationController,
                          roleController,
                          permissionController,
                          permissionModuleController
                        ],
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
                                      organisationController,
                                      roleController,
                                      permissionController,
                                      permissionModuleController
                                    ]),
                                    if (Responsive.isMobile(context))
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                    if (Responsive.isMobile(context))
                                      buildItemDetail([
                                        organisationController,
                                        roleController,
                                        permissionController,
                                        permissionModuleController
                                      ])
                                  ],
                                )),
                            if (!Responsive.isMobile(context))
                              SizedBox(
                                width: defaultPadding,
                              ),
                            if (!Responsive.isMobile(context))
                              Expanded(
                                  flex: 2,
                                  child: buildItemDetail([
                                    organisationController,
                                    roleController,
                                    permissionController,
                                    permissionModuleController
                                  ]))
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
          controller.subTabInfoModel.title == SubTabInfo.permission.title) {
        var state = permissionController.state;
        if (state is PermissionLoading || state is PermissionFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(
                numCol: permissionController.info.dataColumn!.length),
            isLoading: (state is PermissionLoading) ? true : false,
            customDialog: AddPermissionDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource:
              PermissionDataSource(controller: permissionController),
          customDialog: AddPermissionDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.role.title) {
        var state = roleController.state;
        if (state is RoleLoading || state is RoleFailure) {
          return ListItem(
            controller: controller,
            dataTableSource:
                EmptyDataSource(numCol: roleController.info.dataColumn!.length),
            isLoading: (state is RoleLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: RoleDataSource(
              controller: roleController,
              context: _scaffoldKey.currentContext!),
          customDialog: AddRoleDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.organisation.title) {
        var state = organisationController.state;
        if (state is OrganisationLoading || state is OrganisationFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(
                numCol: organisationController.info.dataColumn!.length),
            isLoading: (state is OrganisationLoading) ? true : false,
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource:
              OrganisationDataSource(controller: organisationController),
          customDialog: AddOrganisationDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title ==
              SubTabInfo.permissionModule.title) {
        var state = permissionModuleController.state;
        if (state is PermissionModuleLoading ||
            state is PermissionModuleFailure) {
          return ListItem(
            controller: controller,
            dataTableSource: EmptyDataSource(
                numCol: permissionModuleController.info.dataColumn!.length),
            isLoading: (state is PermissionModuleLoading) ? true : false,
            customDialog: AddPermissionModuleDialog(),
          );
        }
        return ListItem(
          controller: controller,
          dataTableSource: PermissionModuleDataSource(
              controller: permissionModuleController),
          customDialog: AddPermissionModuleDialog(),
        );
      }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.organisation.title) {
        var editController = Get.find<EditOrganisationController>();
        return ItemDetail(
          itemDetailInfo: OrganisationItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditOrganisationDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.role.title) {
        var editController = Get.find<EditRoleController>();
        return ItemDetail(
          itemDetailInfo: RoleItemDetailInfo(),
          customDialog: editController.itemDetail == null ? null : EditRoleDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.permission.title) {
        var editController = Get.find<EditPermissionController>();
        return ItemDetail(
          itemDetailInfo: PermissionItemDetailInfo(),
          customDialog:
              editController.itemDetail == null ? null : EditPermissionDialog(),
        );
      }

      if (controller.isCurrent &&
          controller.subTabInfoModel.title ==
              SubTabInfo.permissionModule.title) {
        var editController = Get.find<EditPermissionModuleController>();
        return ItemDetail(
          itemDetailInfo: PermissionModuleItemDetailInfo(),
          customDialog: editController.itemDetail == null
              ? null
              : EditPermissionModuleDialog(),
        );
      }
    }
    return Container();
  }
}
