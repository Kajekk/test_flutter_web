import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

class ProWorkScheduleController extends SubTabController {
  ProWorkScheduleController({required repository, required this.info}) : _repository = repository;

  final IEmploymentRepository _repository;
  final SubTabInfoModel info;
  final _stateStream = ProWorkScheduleState().obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = ProWorkScheduleLoading();
    var res = await _repository.getProScheduleLists(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = ProWorkScheduleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = ProWorkScheduleLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<EmploymentDetailController>().isCurrent = false;
    Get.find<WorkplaceDetailController>().isCurrent = false;
    Get.find<ContactFormController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is ProWorkSchedule) {
      var editController = Get.find<EditProScheduleController>();
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

    // ever(_stateStream, (state) {
    //   if (state is DeleteEmotionalLogsSuccess) {
    //     Get.back();
    //
    //     fetchListItems(QueryModel(
    //         offset: 0,
    //         limit: rowsPerPage,
    //         total: true,
    //         reverse: true));
    //   }
    //   if (state is DeleteEmotionalLogsFailure) {
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
    // for (var item in dataList.cast<EmotionalLog>()) {
    //   if (item.selected) selectedItemIds.add(item.id!);
    // }
    //
    // if (dataList.isNotEmpty) {
    //   _emotionalStateStream.value = DeleteEmotionalLogsProcessing();
    //   var res = await _emotionalLogRepository.deleteEmotionalLogs(QueryModel(
    //     ids: selectedItemIds,
    //   ));
    //   if (res.status != ApiStatus.Ok) {
    //     _emotionalStateStream.value = DeleteEmotionalLogsFailure(
    //       message: res.message ?? "Something went wrong, please try again",
    //     );
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _emotionalStateStream.value = DeleteEmotionalLogsSuccess();
    // }
  }
}

class AddNewProScheduleController extends GetxController {
  AddNewProScheduleController({required repository})
      : _repository = repository;
  final IEmploymentRepository _repository;
  final _stateStream = AddProWorkScheduleState().obs;

  AddProWorkScheduleState get state => _stateStream.value;
  final emailController = TextEditingController();
  final employmentEmailController = TextEditingController();
  final workingDays = <WorkingDay>[].obs;
  final workingTimeStartControllers = List<TextEditingController>.generate(7, (i) => TextEditingController());
  final workingTimeEndControllers = List<TextEditingController>.generate(7, (i) => TextEditingController());

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddProWorkScheduleSuccess) {
        Get.back();

        var gController = Get.find<ProWorkScheduleController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true,
        ));

        clear();
      }
    });
  }

  void addNewItem() async {
    for (var i=0; i<workingDays.length; i++) {
      var format = DateFormat.jm();
      var wkf = format.parse(workingTimeStartControllers[workingDays[i].weekday!].text);
      var wkt = format.parse(workingTimeEndControllers[workingDays[i].weekday!].text);
      var workingTimeFrom = wkf.hour * 60 + wkf.minute;
      var workingTimeTo = wkt.hour * 60 + wkt.minute;

      workingDays[i] = WorkingDay(
        weekday: workingDays[i].weekday,
        workingTimeFrom: workingTimeFrom,
        workingTimeTo: workingTimeTo,
      );
    }

    var data = ProWorkSchedule(
      email: emailController.text,
      employmentEmail: employmentEmailController.text,
      workingDays: workingDays,
    );

    _stateStream.value = AddProWorkScheduleLoading();
    var res = await _repository.createProSchedule(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddProWorkScheduleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddProWorkScheduleSuccess();
  }

  void clear() async {
    emailController.text = "";
    employmentEmailController.text = "";
    workingDays.value = [];
  }
}

class EditProScheduleController extends GetxController {
  EditProScheduleController({required repository})
      : _repository = repository;
  final IEmploymentRepository _repository;
  final _stateStream = EditProWorkScheduleState().obs;
  final _itemDetail = ProWorkSchedule().obs;

  ProWorkSchedule? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditProWorkScheduleState get state => _stateStream.value;

  //fields
  final emailController = TextEditingController();
  final employmentEmailController = TextEditingController();
  final workingDays = <WorkingDay>[].obs;
  final workingTimeStartControllers = List<TextEditingController>.generate(7, (i) => TextEditingController()).obs;
  final workingTimeEndControllers = List<TextEditingController>.generate(7, (i) => TextEditingController()).obs;

  void changeEditItem(ProWorkSchedule? data) {
    if (data != null) {
      employmentEmailController.text = data.employmentEmail!;
      emailController.text = data.email!;
      workingDays.value = [...data.workingDays!];

      workingTimeStartControllers.value = List<TextEditingController>.generate(7, (i) => TextEditingController());
      workingTimeEndControllers.value = List<TextEditingController>.generate(7, (i) => TextEditingController());
      data.workingDays!.forEach((day) {
        var startingTime = toTimeStringC(day.workingTimeFrom!);
        var endingTime = toTimeStringC(day.workingTimeTo!);

        workingTimeStartControllers[day.weekday!].text = startingTime;
        workingTimeEndControllers[day.weekday!].text = endingTime;
      });

      itemDetail = data;
    }
  }

  void clearEdit() {
    employmentEmailController.text = itemDetail!.employmentEmail!;
    emailController.text = itemDetail!.email!;
    workingDays.value = [...itemDetail!.workingDays!];
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditProWorkScheduleSuccess) {
        Get.back();

        var gController = Get.find<ProWorkScheduleController>();
        gController.fetchListItems(QueryModel(
            offset: gController.firstRowIndex,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true,
        ));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    for (var i=0; i<workingDays.length; i++) {
      var format = DateFormat.jm();
      var wkf = format.parse(workingTimeStartControllers[workingDays[i].weekday!].text);
      var wkt = format.parse(workingTimeEndControllers[workingDays[i].weekday!].text);
      var workingTimeFrom = wkf.hour * 60 + wkf.minute;
      var workingTimeTo = wkt.hour * 60 + wkt.minute;

      workingDays[i] = WorkingDay(
        weekday: workingDays[i].weekday,
        workingTimeFrom: workingTimeFrom,
        workingTimeTo: workingTimeTo,
      );
    }

    var data = ProWorkSchedule(
      id: itemDetail!.id,
      email: emailController.text,
      employmentEmail: employmentEmailController.text,
      workingDays: workingDays,
    );

    _stateStream.value = EditProWorkScheduleLoading();
    var res = await _repository.updateProSchedule(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditProWorkScheduleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditProWorkScheduleSuccess();
  }
}