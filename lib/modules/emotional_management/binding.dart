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
      () => EmotionalLogController(
          emotionalLogRepository: Get.find<IEmotionalRepository>(),
          info: SubTabInfo.emotionalLog),
    );
    Get.lazyPut(
        () => AddNewEmotionalLogController(emotionalLogRepository: Get.find<IEmotionalRepository>()));
    Get.lazyPut(
            () => EditEmotionalLogController(emotionalLogRepository: Get.find<IEmotionalRepository>()));


    Get.lazyPut(
            () => EmotionTypeController(
            emotionTypeRepository: Get.find<IEmotionalRepository>(),
            info: SubTabInfo.emotionalLog));
  }
}
