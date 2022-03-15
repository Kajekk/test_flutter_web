import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/account_management/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/controllers/organisation_controller.dart';

class AccountManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUserAccessApiProvider>(() => UserAccessApiProvider());
    Get.lazyPut<IUserAccessRepository>(
            () => UserAccessRepository(provider: Get.find()));
    Get.lazyPut(
          () => OrganisationController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.organisation),
    );
    Get.lazyPut(
          () => RoleController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.role),
    );

    Get.lazyPut<IAccountApiProvider>(() => AccountApiProvider());
    Get.lazyPut<IAccountRepository>(
            () => AccountRepository(provider: Get.find()));
    Get.lazyPut(
          () => AccountController(
          accountRepository: Get.find<IAccountRepository>(),
          info: SubTabInfo.account),
    );
    Get.lazyPut(
              () => AddNewAccountController(repository: Get.find<IAccountRepository>()));
    Get.lazyPut(
            () => EditAccountController(repository: Get.find<IAccountRepository>()));
  }
}
