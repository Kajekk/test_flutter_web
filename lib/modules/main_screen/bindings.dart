import 'package:get/get.dart';
import 'package:test_flutter_web/modules/main_screen/controllers.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MainScreenController>(MainScreenController());
  }
}