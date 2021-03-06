import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/provider/support_provider.dart';
import 'barrel.dart';

class SupportManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ISupportProvider>(() => SupportProvider());
    Get.lazyPut<ISupportRepository>(
            () => SupportRepository(provider: Get.find()));
    Get.lazyPut(
          () => AttendanceController(supportRepository: Get.find<ISupportRepository>(), info: SubTabInfo.checkInOut),
    );
    Get.lazyPut(() => AddNewAttendanceController(supportRepository: Get.find<ISupportRepository>()));
    Get.lazyPut(() => EditAttendanceController(supportRepository: Get.find<ISupportRepository>()));


    Get.lazyPut(
          () => SupportMetricController(supportRepository: Get.find<ISupportRepository>(), info: SubTabInfo.supportMetric),
    );
    Get.lazyPut(() => AddNewSupportMetricController(repository: Get.find<ISupportRepository>()));
    Get.lazyPut(() => EditSupportMetricController(repository: Get.find<ISupportRepository>()));

    Get.lazyPut(
          () => SupportLogController(supportRepository: Get.find<ISupportRepository>(), info: SubTabInfo.supportLog),
    );
    Get.lazyPut(() => AddNewSupportLogController(repository: Get.find<ISupportRepository>()));
    Get.lazyPut(() => EditSupportLogController(repository: Get.find<ISupportRepository>()));

    Get.lazyPut(
          () => LocationTrackingController(supportRepository: Get.find<ISupportRepository>(), info: SubTabInfo.locationTracking),
    );
  }
}
