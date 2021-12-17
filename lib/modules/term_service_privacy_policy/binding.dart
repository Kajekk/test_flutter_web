import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/term_service_privacy_policy/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

import 'controllers/agreement_controller.dart';

class AgreementAndPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IAgreementAndPolicyProvider>(() => AgreementAndPolicyApiProvider());
    Get.lazyPut<IAgreementAndPolicyRepository>(
            () => AgreementAndPolicyRepository(provider: Get.find()));
    Get.lazyPut(
          () => AgreementController(
              repository: Get.find<IAgreementAndPolicyRepository>(),
          info: SubTabInfo.agreement),
    );
    Get.lazyPut(
            () => AddNewAgreementController(repository: Get.find<IAgreementAndPolicyRepository>()));
    Get.lazyPut(
            () => EditAgreementController(repository: Get.find<IAgreementAndPolicyRepository>()));

    Get.lazyPut(
          () => PolicyController(
              repository: Get.find<IAgreementAndPolicyRepository>(),
          info: SubTabInfo.policy),
    );


  }
}
