import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

class UserAccessManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUserAccessApiProvider>(() => UserAccessApiProvider());
    Get.lazyPut<IUserAccessRepository>(
            () => UserAccessRepository(provider: Get.find()));
    Get.lazyPut(
          () => PermissionController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.permission),
    );
    Get.lazyPut(
            () => AddNewPermissionController(repository: Get.find<IUserAccessRepository>()));
    Get.lazyPut(
            () => EditPermissionController(repository: Get.find<IUserAccessRepository>()));

    Get.lazyPut(
          () => PermissionModuleController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.permissionModule),
    );
    Get.lazyPut(
            () => AddNewPermissionModuleController(repository: Get.find<IUserAccessRepository>()));
    Get.lazyPut(
            () => EditPermissionModuleController(repository: Get.find<IUserAccessRepository>()));

    Get.lazyPut(
          () => RoleController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.role),
    );
    Get.lazyPut(
            () => AddNewRoleController(repository: Get.find<IUserAccessRepository>()));
    Get.lazyPut(
            () => EditRoleController(repository: Get.find<IUserAccessRepository>()));

    Get.lazyPut(
          () => OrganisationController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.organisation),
    );
    Get.lazyPut(
            () => AddNewOrganisationController(repository: Get.find<IUserAccessRepository>()));
    Get.lazyPut(
            () => EditOrganisationController(repository: Get.find<IUserAccessRepository>()));

  }
}
