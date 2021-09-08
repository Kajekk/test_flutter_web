import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/provider/test.dart';
import 'package:test_flutter_web/data/repository/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:http/http.dart' as http;
import 'barrel.dart';

class UserAccessManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EntityTypeController>(() => EntityTypeController(CategoryListData.entityType));
    Get.lazyPut<EntityTypeController2>(() => EntityTypeController2(CategoryListData.userRoles));
    Get.lazyPut<EntityTypeController3>(() => EntityTypeController3(CategoryListData.userPermissions));
    // Get.put<UserAccessManagementController>(UserAccessManagementController(
    //     myRepository:
    //         MyRepository(apiClient: MyApiClient(httpClient: http.Client()))));
    // Get.put<CategoryController>(
    //     CategoryController(mapCategoryCard: categoryMap),
    //     tag: 'user-access-management');
    Get.put<ListItemController>(ListItemController());
  }
}
