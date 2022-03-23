import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'barrel.dart';

class InclusFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IInclusFormProvider>(() => InclusFormProvider());
    Get.lazyPut<IInclusFormRepository>(
            () => InclusFormRepository(provider: Get.find()));
    Get.lazyPut(
          () => InclusiveEmploymentController(repository: Get.find<IInclusFormRepository>(), info: SubTabInfo.inclusiveEmployment),
    );
    Get.lazyPut(() => AddNewInclusiveEmploymentController(repository: Get.find<IInclusFormRepository>()));
    Get.lazyPut(() => EditInclusiveEmploymentController(repository: Get.find<IInclusFormRepository>()));

    Get.lazyPut(
          () => ContactUsController(repository: Get.find<IInclusFormRepository>(), info: SubTabInfo.contactUs),
    );
    Get.lazyPut(() => AddNewContactUsController(repository: Get.find<IInclusFormRepository>()));
    Get.lazyPut(() => EditContactUsController(repository: Get.find<IInclusFormRepository>()));
  }
}
