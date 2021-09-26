import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'barrel.dart';

class GoalManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IGoalProvider>(() => GoalProvider());
    Get.lazyPut<IGoalRepository>(
            () => GoalRepository(provider: Get.find()));
    Get.lazyPut(
          () => GoalController(goalRepository: Get.find<IGoalRepository>(), info: SubTabInfo.goal),
    );
    Get.lazyPut(() => AddNewGoalController(goalRepository: Get.find<IGoalRepository>()));
    Get.lazyPut(() => EditGoalController(goalRepository: Get.find<IGoalRepository>()));

    Get.lazyPut(
          () => GoalFrequencyController(goalRepository: Get.find<IGoalRepository>(), info: SubTabInfo.goalFrequency),
    );
    Get.lazyPut(() => AddNewGoalFrequencyController(goalRepository: Get.find<IGoalRepository>()));
    Get.lazyPut(() => EditGoalFrequencyController(goalRepository: Get.find<IGoalRepository>()));

    Get.lazyPut(
          () => GoalRelationshipController(goalRepository: Get.find<IGoalRepository>(), info: SubTabInfo.goalRelationship),
    );
    Get.lazyPut(() => AddNewGoalRelationshipController(goalRepository: Get.find<IGoalRepository>()));
    Get.lazyPut(() => EditGoalRelationshipController(goalRepository: Get.find<IGoalRepository>()));
  }
}
