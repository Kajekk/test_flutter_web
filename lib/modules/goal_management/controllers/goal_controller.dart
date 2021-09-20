import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/barrel.dart';

class GoalController extends SubTabController {
  GoalController({required goalRepository, required this.info})
      : _goalRepository = goalRepository;

  final IGoalRepository _goalRepository;
  final SubTabInfoModel info;
  final _goalStateStream = GoalState().obs;

  get goalState => _goalStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _goalStateStream.value = GoalLoading();
    var res = await _goalRepository.getGoalList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _goalStateStream.value = GoalFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _goalStateStream.value = GoalLoaded(listData: res.data!);
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<GoalFrequencyController>().isCurrent = false;
    // Get.find<EntityTypeController3>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Goal) {
      var editController = Get.find<EditGoalController>();
      editController.changeEditItem(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;
    // itemDetail = null;

    fetchListItems(
        QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));
  }
}

class AddNewGoalController extends GetxController {
  AddNewGoalController({required goalRepository})
      : _goalRepository = goalRepository;
  final IGoalRepository _goalRepository;
  final _stateStream = AddGoalState().obs;

  AddGoalState get state => _stateStream.value;
  final tips = <String>[].obs;
  final nature = 'system'.obs;
  final frequencyId = ''.obs;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddGoalSuccess) {
        Get.back();

        var gController = Get.find<GoalController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
    var data = Goal(
        name: nameController.text,
        description: descriptionController.text,
        frequencyId: frequencyId.value,
        nature: nature.value,
        tips: tips);

    _stateStream.value = AddGoalLoading();
    var res = await _goalRepository.createGoal(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddGoalFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddGoalSuccess();
  }
}

class EditGoalController extends GetxController {
  EditGoalController({required goalRepository})
      : _goalRepository = goalRepository;
  final IGoalRepository _goalRepository;
  final _stateStream = EditGoalState().obs;
  final _itemDetail = Goal().obs;

  Goal? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditGoalState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final tips = <String>[].obs;
  final nature = 'system'.obs;
  final frequencyId = ''.obs;
  void changeEditItem(Goal? data) {
    if (data != null) {
      frequencyId.value = data.frequencyId!;
      nature.value = data.nature!;
      nameController.text = data.name!;
      descriptionController.text = data.description!;
      if (data.tips != null && data.tips!.length > 0) {
        tips.value = data.tips!;
      }

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditGoalSuccess) {
        Get.back();

        var gController = Get.find<GoalController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void editItem() async {
    var data = Goal(
      id: itemDetail!.id,
      name: nameController.text,
      description: descriptionController.text,
      frequencyId: frequencyId.value,
      nature: nature.value,
      tips: tips,
    );

    _stateStream.value = EditGoalLoading();
    var res = await _goalRepository.updateGoal(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditGoalFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditGoalSuccess();
  }
}
