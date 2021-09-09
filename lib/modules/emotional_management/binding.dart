import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'barrel.dart';

class EmotionalManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IEmotionalApiProvider>(() => EmotionalApiProvider());
    Get.lazyPut<IEmotionalRepository>(
            () => EmotionalRepository(provider: Get.find()));
    Get.lazyPut(
          () => EmotionalLogController(emotionalLogRepository: Get.find(), info: SubTabInfo.emotionalLog),
    );
    Get.lazyPut(() => AddNewEmotionalLogController());
  }
}
