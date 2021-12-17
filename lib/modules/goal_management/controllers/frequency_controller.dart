import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';

class GoalFrequencyController extends SubTabController {
  GoalFrequencyController({required goalRepository, required this.info})
      : _goalRepository = goalRepository;

  final IGoalRepository _goalRepository;
  final SubTabInfoModel info;
  final _goalStateStream = GoalFrequencyState().obs;

  get goalState => _goalStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _goalStateStream.value = GoalFrequencyLoading();
    var res = await _goalRepository.getGoalFrequencyList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _goalStateStream.value = GoalFrequencyFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _goalStateStream.value = GoalFrequencyLoaded(listData: res.data!);
    dataList = res.data;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<GoalController>().isCurrent = false;
    Get.find<GoalRelationshipController>().isCurrent = false;
    Get.find<GoalTrackingController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is GoalFrequency) {
      var editController = Get.find<EditGoalFrequencyController>();
      editController.changeEditItem(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;

    fetchListItems(
        QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));

    ever(_goalStateStream, (state) {
      if (state is DeleteGoalFrequenciesSuccess) {
        Get.back();

        fetchListItems(QueryModel(
            offset: 0,
            limit: rowsPerPage,
            total: true,
            reverse: true));
      }
      if (state is DeleteGoalFrequenciesFailure) {
        Get.snackbar("Error", state.message,
            backgroundColor: Colors.redAccent,
            margin: EdgeInsets.only(bottom: 15),
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  @override
  void deleteItems() async {
    var selectedItemIds = <String>[];
    for (var item in dataList.cast<GoalFrequency>()) {
      if (item.selected) selectedItemIds.add(item.id!);
    }

    if (dataList.isNotEmpty) {
      _goalStateStream.value = DeleteGoalFrequenciesProcessing();
      var res = await _goalRepository.deleteGoalFrequencies(QueryModel(
        ids: selectedItemIds,
      ));
      if (res.status != ApiStatus.Ok) {
        _goalStateStream.value = DeleteGoalFrequenciesFailure(
            message: res.message ?? "Something went wrong, please try again",
            status: res.status);
        return;
      }
      dataList.removeWhere((element) => element.selected);
      totalRows = dataList.length;
      _goalStateStream.value = DeleteGoalFrequenciesSuccess();
    }
  }
}

class AddNewGoalFrequencyController extends GetxController {
  AddNewGoalFrequencyController({required goalRepository})
      : _goalRepository = goalRepository;
  final IGoalRepository _goalRepository;
  final _stateStream = AddGoalFrequencyState().obs;

  AddGoalFrequencyState get state => _stateStream.value;
  final frequencyController = TextEditingController();
  final dayEquivalentController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddGoalFrequencySuccess) {
        Get.back();

        var gController = Get.find<GoalFrequencyController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
    var data = GoalFrequency(
        frequency: frequencyController.text,
        dayEquivalent: int.parse(dayEquivalentController.text),
    );

    _stateStream.value = AddGoalFrequencyLoading();
    var res = await _goalRepository.createGoalFrequency(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddGoalFrequencyFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddGoalFrequencySuccess();
  }
}

class EditGoalFrequencyController extends GetxController {
  EditGoalFrequencyController({required goalRepository})
      : _goalRepository = goalRepository;
  final IGoalRepository _goalRepository;
  final _stateStream = EditGoalFrequencyState().obs;
  final _itemDetail = GoalFrequency().obs;

  GoalFrequency? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditGoalFrequencyState get state => _stateStream.value;

  //fields
  final frequencyController = TextEditingController();
  final dayEquivalentController = TextEditingController();
  void changeEditItem(GoalFrequency? data) {
    if (data != null) {
      frequencyController.text = data.frequency!;
      dayEquivalentController.text = data.dayEquivalent!.toString();

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditGoalFrequencySuccess) {
        Get.back();

        var gController = Get.find<GoalFrequencyController>();
        gController.fetchListItems(QueryModel(
            offset: gController.firstRowIndex,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    var data = GoalFrequency(
      id: itemDetail!.id,
      frequency: frequencyController.text,
      dayEquivalent: int.parse(dayEquivalentController.text),
    );

    _stateStream.value = EditGoalFrequencyLoading();
    var res = await _goalRepository.updateGoalFrequency(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditGoalFrequencyFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditGoalFrequencySuccess();
  }
}