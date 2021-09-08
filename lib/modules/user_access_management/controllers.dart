import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/models/test.dart';
import 'package:test_flutter_web/data/repository/emotional_repository.dart';
import 'package:test_flutter_web/data/repository/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states.dart';

class EntityTypeController extends SubTabController {
  final EmotionalRepository emotionalRepository = EmotionalRepository();
  final CategoryModel info;
  final _emotionalLogStateStream = EmotionalLogState().obs;
  EntityTypeController(this.info);

  get emotionalLogState => _emotionalLogStateStream.value;

  void fetchListItems(offset, limit) async {
    print('111111111111111111');
    _emotionalLogStateStream.value = EmotionalLoading();
    var res = await emotionalRepository.getEmotionalLogs(offset, limit);
    _emotionalLogStateStream.value = EmotionalLoaded();
  }
  void countItems() {

  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<EntityTypeController2>().isCurrent = false;
    Get.find<EntityTypeController3>().isCurrent = false;
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    categoryModel = info;

    fetchListItems(0, itemPerPage);
  }
}

class EntityTypeController2 extends SubTabController {
  final CategoryModel info;
  EntityTypeController2(this.info);

  List<EmotionalLog>? fetchListItems(offset, limit) {
    print('22222222222222222');
  }
  void countItems() {

  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<EntityTypeController>().isCurrent = false;
    Get.find<EntityTypeController3>().isCurrent = false;
  }

  @override
  void onInit() async {
    super.onInit();
    categoryModel = info;
  }
}

class EntityTypeController3 extends SubTabController {
  final CategoryModel info;
  EntityTypeController3(this.info);


  List<EmotionalLog>? fetchListItems(offset, limit) {
    print('333333333333333333');
  }
  void countItems() {

  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<EntityTypeController>().isCurrent = false;
    Get.find<EntityTypeController2>().isCurrent = false;
  }

  @override
  void onInit() async {
    super.onInit();
    categoryModel = info;
  }
}

class UserAccessManagementController extends GetxController {
  final MyRepository myRepository;
  UserAccessManagementController({required this.myRepository});

  final _myEntityTypeList = <MyModel>[].obs;
  final _myUserPermissionsList = <MyModel>[].obs;
  final _myUserRolesList = <MyModel>[].obs;
  final _currentCategory = ''.obs;
  // final List<CategoryCardModel> _categoryList;

  // List<CategoryCardModel> get categoryList => _categoryList;
  String get currentCategory => _currentCategory.value;

  List<MyModel> get myEntityTypeList => _myEntityTypeList;
  List<MyModel> get myUserRolesList => _myUserRolesList;
  List<MyModel> get myUserPermissionsList => _myUserPermissionsList;

  @override
  void onInit() async {
    await fetchEntityType();
    super.onInit();
  }

  Future<void> fetchEntityType() async {
    myRepository.getAll().then((data) {
      _myEntityTypeList.value = data;
      print('fetchEntityType done');
    });
  }

  Future<void> fetchUserPermissions() async {
    myRepository.getAll().then((data) {
      _myUserPermissionsList.value = data;
      print('fetchUserPermissions done');
      print((data as List).length);
    });
  }

  Future<void> fetchUserRoles() async {
    myRepository.getAll().then((data) {
      _myUserRolesList.value = data;
      print('fetchUserRoles done');
    });
  }

  void changeCurrentCategory(val) {
    _currentCategory.value = val;
  }
}