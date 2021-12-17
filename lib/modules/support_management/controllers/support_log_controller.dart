import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';
import 'package:test_flutter_web/modules/support_management/states/barrel.dart';

class SupportLogController extends SubTabController {
  SupportLogController({required supportRepository, required this.info})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final SubTabInfoModel info;
  final _stateStream = SupportLogState().obs;
  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = SupportLogLoading();
    var res = await _supportRepository.getSupportLogList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = SupportLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = SupportLogLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<AttendanceController>().isCurrent = false;
    Get.find<SupportMetricController>().isCurrent = false;
    Get.find<LocationTrackingController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is SupportLog) {
      var editController = Get.find<EditSupportLogController>();
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

class AddNewSupportLogController extends GetxController {
  AddNewSupportLogController({required repository})
      : _repository = repository;
  final ISupportRepository _repository;
  final _stateStream = AddSupportLogState().obs;

  AddSupportLogState get state => _stateStream.value;
  final emailController = TextEditingController();
  final forEmailController = TextEditingController();
  final type = 'in_person'.obs;
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final observations = <Observation>[].obs;
  final metrics = <Metric>[].obs;
  final textControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddSupportLogSuccess) {
        Get.back();

        var gController = Get.find<SupportLogController>();
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
    var startDateTime = DateFormat.yMd()
        .add_jm()
        .parse(startDateController.text + " " + startTimeController.text).toUtc();
    var endDateTime = DateFormat.yMd()
        .add_jm()
        .parse(endDateController.text + " " + endTimeController.text).toUtc();

    var data = SupportLog(
      email: emailController.text,
      forEmail: forEmailController.text,
      type: type.value,
      startAt: startDateTime,
      endAt: endDateTime,
      observations: observations,
      metrics: metrics,
    );

    _stateStream.value = AddSupportLogLoading();
    var res = await _repository.createSupportLog(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddSupportLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddSupportLogSuccess();
  }

  void clear() async {
    emailController.text = "";
    forEmailController.text = "";
    type.value = "in_person";
    observations.value = [];
    metrics.value = [];
    startDateController.text = "";
    startTimeController.text = "";
    endDateController.text = "";
    endTimeController.text = "";
  }
}

class EditSupportLogController extends GetxController {
  EditSupportLogController({required repository})
      : _repository = repository;
  final ISupportRepository _repository;
  final _stateStream = EditSupportLogState().obs;
  final _itemDetail = SupportLog().obs;

  SupportLog? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditSupportLogState get state => _stateStream.value;

  //fields
  final emailController = TextEditingController();
  final forEmailController = TextEditingController();
  final type = 'in_person'.obs;
  final startDateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endDateController = TextEditingController();
  final endTimeController = TextEditingController();
  final observations = <Observation>[].obs;
  final metrics = <Metric>[].obs;
  final textControllers = <TextEditingController>[].obs;

  void changeEditItem(SupportLog? data) {
    if (data != null) {
      emailController.text = data.email!;
      forEmailController.text = data.forEmail!;
      type.value = data.type!;
      if (data.metrics != null && data.metrics!.length > 0) {
        metrics.value = data.metrics!;
      }
      if (data.observations != null && data.observations!.length > 0) {
        observations.value = data.observations!;
        textControllers.value = List<TextEditingController>.generate(data.observations!.length, (index) => TextEditingController());
        for (var i=0; i<textControllers.length; i++) {
          textControllers[i].text = DateFormat('hh:mm a').format(observations[i].time!.toLocal());
        }
      }

      var startDateTime = DateFormat.yMd().add_jm().format(data.startAt!.toLocal());
      var idx = startDateTime.indexOf(" ");
      var startDate = startDateTime.substring(0, idx).trim();
      var startTime = startDateTime.substring(idx++).trim();

      var endDateTime = DateFormat.yMd().add_jm().format(data.endAt!.toLocal());
      idx = endDateTime.indexOf(" ");
      var endDate = endDateTime.substring(0, idx).trim();
      var endTime = endDateTime.substring(idx++).trim();

      startDateController.text = startDate;
      startTimeController.text = startTime;
      endDateController.text = endDate;
      endTimeController.text = endTime;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditSupportLogSuccess) {
        Get.back();

        var gController = Get.find<SupportLogController>();
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
    var startDateTime = DateFormat.yMd()
        .add_jm()
        .parse(startDateController.text + " " + startTimeController.text).toUtc();
    var endDateTime = DateFormat.yMd()
        .add_jm()
        .parse(endDateController.text + " " + endTimeController.text).toUtc();

    var data = SupportLog(
      id: itemDetail!.id,
      email: emailController.text,
      forEmail: forEmailController.text,
      type: type.value,
      observations: observations,
      metrics: metrics,
      startAt: startDateTime,
      endAt: endDateTime,
    );

    _stateStream.value = EditSupportLogLoading();
    var res = await _repository.updateSupportLog(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditSupportLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditSupportLogSuccess();
  }
}
