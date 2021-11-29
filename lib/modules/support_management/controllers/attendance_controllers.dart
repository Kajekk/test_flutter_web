import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';
import 'package:test_flutter_web/modules/support_management/states/barrel.dart';

class AttendanceController extends SubTabController {
  AttendanceController({required supportRepository, required this.info})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final SubTabInfoModel info;
  final _attendanceStateStream = AttendanceState().obs;
  get attendanceState => _attendanceStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _attendanceStateStream.value = AttendanceLoading();
    var res = await _supportRepository.getAttendanceList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _attendanceStateStream.value = AttendanceFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _attendanceStateStream.value = AttendanceLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<SupportMetricController>().isCurrent = false;
    Get.find<SupportLogController>().isCurrent = false;
    Get.find<LocationTrackingController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is AttendanceModel) {
      // itemDetail = item;
      var editController = Get.find<EditAttendanceController>();
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

    ever(_attendanceStateStream, (state) {
      if (state is DeleteAttendancesSuccess) {
        Get.back();

        fetchListItems(QueryModel(
            offset: 0,
            limit: rowsPerPage,
            total: true,
            reverse: true));
      }
      if (state is DeleteAttendancesFailure) {
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
    for (var item in dataList.cast<AttendanceModel>()) {
      if (item.selected) selectedItemIds.add(item.id!);
    }

    if (dataList.isNotEmpty) {
      _attendanceStateStream.value = DeleteAttendancesProcessing();
      var res = await _supportRepository.deleteAttendances(QueryModel(
        ids: selectedItemIds,
      ));
      if (res.status != ApiStatus.Ok) {
        _attendanceStateStream.value = DeleteAttendancesFailure(
            message: res.message ?? "Something went wrong, please try again",
            status: res.status);
        return;
      }
      dataList.removeWhere((element) => element.selected);
      totalRows = dataList.length;
      _attendanceStateStream.value = DeleteAttendancesSuccess();
    }
  }
}

class AddNewAttendanceController extends GetxController {
  AddNewAttendanceController({required supportRepository})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final _stateStream = AddAttendanceState().obs;

  AddAttendanceState get state => _stateStream.value;
  //fields
  final emailController = TextEditingController();
  final checkInDateController = TextEditingController();
  final checkInTimeController = TextEditingController();
  final checkOutDateController = TextEditingController();
  final checkOutTimeController = TextEditingController();
  final checkedInFar = false.obs;
  final checkedOutFar = false.obs;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddAttendanceSuccess) {
        Get.back();

        var aController = Get.find<AttendanceController>();
        aController.fetchListItems(QueryModel(
            offset: 0,
            limit: aController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
    var checkInDateTime = DateFormat.yMd()
        .add_jm()
        .parse(checkInDateController.text + " " + checkInTimeController.text).toUtc();
    DateTime? checkOutDateTime;
    bool? isCheckedOut;
    bool? isCheckOutFar;
    if (checkOutDateController.text != '' && checkOutTimeController.text != '') {
      checkOutDateTime = DateFormat.yMd()
          .add_jm()
          .parse(checkOutDateController.text + " " + checkOutTimeController.text).toUtc();
      isCheckedOut = true;
      isCheckOutFar = checkedOutFar.value;
    }

    var data = AttendanceModel(
        createdTime: checkInDateTime,
        lastUpdatedTime: checkOutDateTime,
        email: emailController.text,
        isCheckedIn: true,
        isCheckInFar: checkedInFar.value,
        isCheckedOut: isCheckedOut,
        isCheckOutFar: isCheckOutFar,
    );

    _stateStream.value = AddAttendanceLoading();
    var res = await _supportRepository.createAttendance(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddAttendanceFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddAttendanceSuccess();
  }
}

class EditAttendanceController extends GetxController {
  EditAttendanceController({required supportRepository})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final _stateStream = EditAttendanceState().obs;
  final _itemDetail = AttendanceModel().obs;

  AttendanceModel? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditAttendanceState get state => _stateStream.value;

  //fields
  final emailController = TextEditingController();
  final checkInDateController = TextEditingController();
  final checkInTimeController = TextEditingController();
  final checkOutDateController = TextEditingController();
  final checkOutTimeController = TextEditingController();
  final checkedInFar = false.obs;
  final checkedOutFar = false.obs;

  void changeEditItem(AttendanceModel? data) {
    if (data != null) {
      // clear previous data
      checkOutDateController.text = "";
      checkOutTimeController.text = "";
      checkedOutFar.value = false;

      var checkInDateTime = DateFormat.yMd().add_jm().format(data.createdTime!.toLocal());
      var idx = checkInDateTime.indexOf(" ");
      var checkInDate = checkInDateTime.substring(0, idx).trim();
      var checkInTime = checkInDateTime.substring(idx++).trim();

      if (data.isCheckedOut != null) {
        var checkOutDateTime = DateFormat.yMd().add_jm().format(data.lastUpdatedTime!.toLocal());
        var idx = checkOutDateTime.indexOf(" ");
        var checkOutDate = checkInDateTime.substring(0, idx).trim();
        var checkOutTime = checkInDateTime.substring(idx++).trim();
        checkOutDateController.text = checkOutDate;
        checkOutTimeController.text = checkOutTime;
        checkedOutFar.value = data.isCheckOutFar ?? false;
      }

      emailController.text = data.email!;
      checkInDateController.text = checkInDate;
      checkInTimeController.text = checkInTime;
      checkedInFar.value = data.isCheckInFar ?? false;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditAttendanceSuccess) {
        Get.back();

        var eController = Get.find<AttendanceController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void editItem() async {
    var checkInDateTime = DateFormat.yMd()
        .add_jm()
        .parse(checkInDateController.text + " " + checkInTimeController.text).toUtc();
    DateTime? checkOutDateTime;
    bool? isCheckedOut;
    bool? isCheckOutFar;

    if (checkOutDateController.text != '' && checkOutTimeController.text != '') {
      checkOutDateTime = DateFormat.yMd()
          .add_jm()
          .parse(checkOutDateController.text + " " + checkOutTimeController.text).toUtc();
      isCheckedOut = true;
      isCheckOutFar = checkedOutFar.value;
    }


    var data = AttendanceModel(
      id: itemDetail!.id,
      createdTime: checkInDateTime,
      lastUpdatedTime: checkOutDateTime,
      email: emailController.text,
      isCheckedIn: true,
      isCheckInFar: checkedInFar.value,
      isCheckedOut: isCheckedOut,
      isCheckOutFar: isCheckOutFar,
    );

    _stateStream.value = EditAttendanceLoading();
    var res = await _supportRepository.updateAttendance(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditAttendanceFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditAttendanceSuccess();
  }
}
