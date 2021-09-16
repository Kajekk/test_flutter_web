import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'barrel.dart';

class EmploymentManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IEmploymentProvider>(() => EmploymentProvider());
    Get.lazyPut<IEmploymentRepository>(
            () => EmploymentRepository(provider: Get.find()));
    Get.lazyPut(
          () => EmploymentDetailController(employmentRepository: Get.find<IEmploymentRepository>(), info: SubTabInfo.employmentDetail),
    );
    Get.lazyPut(() => AddNewEmploymentController(employmentRepository: Get.find<IEmploymentRepository>()));
    Get.lazyPut(() => EditEmploymentController(employmentRepository: Get.find<IEmploymentRepository>()));

    Get.lazyPut(
          () => WorkplaceDetailController(employmentRepository: Get.find<IEmploymentRepository>(), info: SubTabInfo.workplaceDetail),
    );
    Get.lazyPut(() => AddNewWorkplaceController(employmentRepository: Get.find<IEmploymentRepository>()));
    Get.lazyPut(() => EditWorkplaceController(employmentRepository: Get.find<IEmploymentRepository>()));
  }
}
