import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/provider/barrel.dart';
import 'package:test_flutter_web/data/provider/test.dart';
import 'package:test_flutter_web/data/repository/emotional_repository.dart';
import 'package:test_flutter_web/data/repository/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:http/http.dart' as http;
import 'barrel.dart';

// class UserAccessManagementBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<IEmotionalApiProvider>(() => EmotionalApiProvider());
//     Get.lazyPut<IEmotionalRepository>(
//             () => EmotionalRepository(provider: Get.find()));
//     Get.lazyPut(
//           () => EntityTypeController(emotionalRepository: Get.find(), info: SubTabInfo.entityType),
//     );
//     Get.lazyPut(() => AddNewEntityTypeController());
//
//     // Get.lazyPut<EntityTypeController>(() => EntityTypeController(CategoryListData.entityType));
//     // Get.lazyPut<EntityTypeController2>(() => EntityTypeController2(SubTabInfo.userRoles));
//     // Get.lazyPut<EntityTypeController3>(() => EntityTypeController3(SubTabInfo.userPermissions));
//     // Get.put<ListItemController>(ListItemController());
//   }
// }
