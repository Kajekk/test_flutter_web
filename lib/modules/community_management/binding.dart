import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'barrel.dart';

class CommunityManagementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IUserAccessApiProvider>(() => UserAccessApiProvider());
    Get.lazyPut<IUserAccessRepository>(
            () => UserAccessRepository(provider: Get.find()));
    Get.lazyPut(
          () => OrganisationController(
          userAccessRepository: Get.find<IUserAccessRepository>(),
          info: SubTabInfo.organisation),
    );

    Get.lazyPut<ICommunityApiProvider>(() => CommunityApiProvider());
    Get.lazyPut<ICommunityRepository>(
        () => CommunityRepository(provider: Get.find()));
    Get.lazyPut(
      () => TopicController(
          communityRepository: Get.find<ICommunityRepository>(),
          info: SubTabInfo.communityTopic),
    );
    Get.lazyPut(
        () => AddNewCommunityController(communityRepository: Get.find<ICommunityRepository>()));
    Get.lazyPut(
            () => EditCommunityTopicController(communityRepository: Get.find<ICommunityRepository>()));

  }
}
