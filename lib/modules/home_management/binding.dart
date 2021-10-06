import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'barrel.dart';

class HomeManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IHomeProvider>(() => HomeProvider());
    Get.lazyPut<IHomeRepository>(
            () => HomeRepository(provider: Get.find()));
    Get.lazyPut(
          () => QuoteController(homeRepository: Get.find<IHomeRepository>(), info: SubTabInfo.quotes),
    );
    Get.lazyPut(() => AddNewQuoteController(homeRepository: Get.find<IHomeRepository>()));
    Get.lazyPut(() => EditQuoteController(homeRepository: Get.find<IHomeRepository>()));
  }
}
