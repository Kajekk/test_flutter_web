import 'package:get/get.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';

import 'common.dart';

class SupportManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CategoryController>(
        CategoryController(mapCategoryCard: categoryMap),
        tag: 'support-management');
  }
}
