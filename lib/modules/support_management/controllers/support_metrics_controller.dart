import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';
import 'package:test_flutter_web/modules/support_management/states/barrel.dart';

class SupportMetricController extends SubTabController {
  SupportMetricController({required supportRepository, required this.info})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final SubTabInfoModel info;
  final _stateStream = SupportMetricState().obs;
  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = SupportMetricLoading();
    var res = await _supportRepository.getSupportMetricList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = SupportMetricFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = SupportMetricLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<AttendanceController>().isCurrent = false;
    Get.find<SupportLogController>().isCurrent = false;
    Get.find<LocationTrackingController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is SupportMetric) {
      var editController = Get.find<EditSupportMetricController>();
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

    // ever(_attendanceStateStream, (state) {
    //   if (state is DeleteAttendancesSuccess) {
    //     Get.back();
    //
    //     fetchListItems(QueryModel(
    //         offset: 0,
    //         limit: rowsPerPage,
    //         total: true,
    //         reverse: true));
    //   }
    //   if (state is DeleteAttendancesFailure) {
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
    // for (var item in dataList.cast<AttendanceModel>()) {
    //   if (item.selected) selectedItemIds.add(item.id!);
    // }
    //
    // if (dataList.isNotEmpty) {
    //   _attendanceStateStream.value = DeleteAttendancesProcessing();
    //   var res = await _supportRepository.deleteAttendances(QueryModel(
    //     ids: selectedItemIds,
    //   ));
    //   if (res.status != ApiStatus.Ok) {
    //     _attendanceStateStream.value = DeleteAttendancesFailure(
    //         message: res.message ?? "Something went wrong, please try again",
    //         status: res.status);
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _attendanceStateStream.value = DeleteAttendancesSuccess();
    // }
  }
}

class AddNewSupportMetricController extends GetxController {
  AddNewSupportMetricController({required repository})
      : _repository = repository;
  final ISupportRepository _repository;
  final _stateStream = AddSupportMetricState().obs;

  AddSupportMetricState get state => _stateStream.value;
  final nameController = TextEditingController();
  final targetController = TextEditingController();
  final descriptionController = TextEditingController();
  final tips = <String>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddSupportMetricSuccess) {
        Get.back();

        var gController = Get.find<SupportMetricController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));

        clear();
      }
    });
  }

  void addNewItem() async {
    var data = SupportMetric(
      name: nameController.text,
      description: descriptionController.text,
      tips: tips,
      target: int.parse(targetController.text),
    );

    _stateStream.value = AddSupportMetricLoading();
    var res = await _repository.createSupportMetric(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddSupportMetricFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddSupportMetricSuccess();
  }

  void clear() async {
    nameController.text = "";
    descriptionController.text = "";
    targetController.text = "";
    tips.value = [];
  }
}

class EditSupportMetricController extends GetxController {
  EditSupportMetricController({required repository})
      : _repository = repository;
  final ISupportRepository _repository;
  final _stateStream = EditSupportMetricState().obs;
  final _itemDetail = SupportMetric().obs;

  SupportMetric? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditSupportMetricState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final targetController = TextEditingController();
  final tips = <String>[].obs;

  void changeEditItem(SupportMetric? data) {
    if (data != null) {
      nameController.text = data.name!;
      descriptionController.text = data.description ?? "";
      targetController.text = data.target!.toString();
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
      if (state is EditSupportMetricSuccess) {
        Get.back();

        var gController = Get.find<SupportMetricController>();
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
    var data = SupportMetric(
      id: itemDetail!.id,
      name: nameController.text,
      description: descriptionController.text,
      target: int.parse(targetController.text),
      tips: tips,
    );

    _stateStream.value = EditSupportMetricLoading();
    var res = await _repository.updateSupportMetric(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditSupportMetricFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditSupportMetricSuccess();
  }
}

