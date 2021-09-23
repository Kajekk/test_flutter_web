import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/goal_relationship_states.dart';

import 'barrel.dart';

class GoalRelationshipController extends SubTabController {
  GoalRelationshipController({required goalRepository, required this.info})
      : _goalRepository = goalRepository;

  final IGoalRepository _goalRepository;
  final SubTabInfoModel info;
  final _goalStateStream = GoalRelationshipState().obs;

  get goalState => _goalStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _goalStateStream.value = GoalRelationshipLoading();
    var res = await _goalRepository.getGoalRelationshipList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _goalStateStream.value = GoalRelationshipFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _goalStateStream.value = GoalRelationshipLoaded(listData: res.data!);
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<GoalController>().isCurrent = false;
    Get.find<GoalFrequencyController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is GoalRelationship) {
      var editController = Get.find<EditGoalRelationshipController>();
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
  }
}
//
// class AddNewGoalRelationshipController extends GetxController {
//   AddNewGoalRelationshipController({required goalRepository})
//       : _goalRepository = goalRepository;
//   final IGoalRepository _goalRepository;
//   final _stateStream = AddGoalRelationshipState().obs;
//
//   AddGoalRelationshipState get state => _stateStream.value;
//   final frequencyController = TextEditingController();
//   final dayEquivalentController = TextEditingController();
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     ever(_stateStream, (state) {
//       if (state is AddGoalFrequencySuccess) {
//         Get.back();
//
//         var gController = Get.find<GoalFrequencyController>();
//         gController.fetchListItems(QueryModel(
//             offset: 0,
//             limit: gController.rowsPerPage,
//             total: true,
//             reverse: true));
//       }
//     });
//   }
//
//   void addNewItem() async {
//     var data = GoalFrequency(
//       frequency: frequencyController.text,
//       dayEquivalent: int.parse(dayEquivalentController.text),
//     );
//
//     _stateStream.value = AddGoalFrequencyLoading();
//     var res = await _goalRepository.createGoalFrequency(data);
//     if (res.status != ApiStatus.Ok) {
//       _stateStream.value = AddGoalFrequencyFailure(
//           message: res.message ?? "Something went wrong, please try again");
//       return;
//     }
//     _stateStream.value = AddGoalFrequencySuccess();
//   }
// }
//
class EditGoalRelationshipController extends GetxController {
  EditGoalRelationshipController({required goalRepository})
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
  final emailController = TextEditingController();
  void changeEditItem(GoalRelationship? data) {
    if (data != null) {
      emailController.text = data.email!;

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
    // var data = GoalFrequency(
    //   id: itemDetail!.id,
    //   frequency: frequencyController.text,
    //   dayEquivalent: int.parse(dayEquivalentController.text),
    // );
    //
    // _stateStream.value = EditGoalRelationshipLoading();
    // var res = await _goalRepository.updateGoalFrequency(data);
    // if (res.status != ApiStatus.Ok) {
    //   _stateStream.value = EditGoalRelationshipFailure(
    //       message: res.message ?? "Something went wrong, please try again");
    //   return;
    // }
    // _stateStream.value = EditGoalRelationshipSuccess();
  }
}