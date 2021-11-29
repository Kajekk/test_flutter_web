import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';

class GoalTrackingController extends SubTabController {
  GoalTrackingController({required goalRepository, required this.info})
      : _goalRepository = goalRepository;

  final IGoalRepository _goalRepository;
  final SubTabInfoModel info;
  final _goalStateStream = GoalTrackingState().obs;

  get goalState => _goalStateStream.value;

  Future<void> fetchListItems(QueryModel queryModel) async {
    _goalStateStream.value = GoalTrackingLoading();
    var res = await _goalRepository.getGoalTrackingList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _goalStateStream.value = GoalTrackingFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _goalStateStream.value = GoalTrackingLoaded(listData: res.data!);
    dataList = res.data;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<GoalController>().isCurrent = false;
    Get.find<GoalFrequencyController>().isCurrent = false;
    Get.find<GoalRelationshipController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is GoalTracking) {
      // var editController = Get.find<EditGoalTrackingController>();
      // editController.changeEditItem(item);
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

    // ever(_goalStateStream, (state) {
    //   if (state is DeleteGoalsSuccess) {
    //     Get.back();
    //
    //     fetchListItems(QueryModel(
    //         offset: 0, limit: rowsPerPage, total: true, reverse: true));
    //   }
    //   if (state is DeleteGoalsFailure) {
    //     Get.snackbar("Error", state.message,
    //         backgroundColor: Colors.redAccent,
    //         margin: EdgeInsets.only(bottom: 15),
    //         snackPosition: SnackPosition.BOTTOM);
    //   }
    // });
  }

  @override
  void deleteItems() async {
    // var selectedItemIds = <String>[];
    // for (var item in dataList.cast<Goal>()) {
    //   if (item.selected) selectedItemIds.add(item.id!);
    // }
    //
    // if (dataList.isNotEmpty) {
    //   _goalStateStream.value = DeleteGoalsProcessing();
    //   var res = await _goalRepository.deleteGoals(QueryModel(
    //     ids: selectedItemIds,
    //   ));
    //   if (res.status != ApiStatus.Ok) {
    //     _goalStateStream.value = DeleteGoalsFailure(
    //         message: res.message ?? "Something went wrong, please try again",
    //         status: res.status);
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _goalStateStream.value = DeleteGoalsSuccess();
    // }
  }
}

class EditGoalTrackingController extends GetxController {
  EditGoalTrackingController({required goalRepository})
      : _goalRepository = goalRepository;
  final IGoalRepository _goalRepository;
  final _stateStream = EditGoalRelationshipState().obs;
  final _itemDetail = GoalRelationship().obs;

  GoalRelationship? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditGoalRelationshipState get state => _stateStream.value;

  //fields
  final goalId = ''.obs;
  final emailController = TextEditingController();
  final createdByController = TextEditingController();
  void changeEditItem(GoalRelationship? data) {
    if (data != null) {
      emailController.text = data.email!;
      createdByController.text = data.createdBy!;
      goalId.value = data.goal!.id!;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditGoalRelationshipSuccess) {
        Get.back();

        var gController = Get.find<GoalRelationshipController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void editItem() async {
    var data = GoalRelationship(
      id: itemDetail!.id,
      email: emailController.text,
      createdBy: createdByController.text,
      goalId: goalId.value,
    );

    _stateStream.value = EditGoalRelationshipLoading();
    var res = await _goalRepository.updateGoalRelationship(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditGoalRelationshipFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditGoalRelationshipSuccess();
  }
}