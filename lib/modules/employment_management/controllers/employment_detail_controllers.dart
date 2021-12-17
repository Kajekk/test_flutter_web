import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/states/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

class EmploymentDetailController extends SubTabController {
  EmploymentDetailController({required employmentRepository, required this.info}) : _employmentRepository = employmentRepository;

  final IEmploymentRepository _employmentRepository;
  final SubTabInfoModel info;
  final _employmentStateStream = EmploymentDetailState().obs;
  // final _itemDetail = Employment().obs;

  // Employment? get itemDetail => _itemDetail.value;
  //
  // set itemDetail(value) {
  //   _itemDetail.value = value;
  // }

  get employmentState => _employmentStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _employmentStateStream.value = EmploymentDetailLoading();
    var res = await _employmentRepository.getEmploymentLists(queryModel);
    if (res.status != ApiStatus.Ok) {
      _employmentStateStream.value = EmploymentDetailFailure(message: res.message ?? "Something went wrong, please try again");
    }
    totalRows = res.total ?? 0;
    _employmentStateStream.value = EmploymentDetailLoaded(listData: res.data!);
    dataList = res.data!;
  }
  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<WorkplaceDetailController>().isCurrent = false;
    Get.find<ProWorkScheduleController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Employment) {
      // itemDetail = item;
      var editController = Get.find<EditEmploymentController>();
      editController.changeEditItem(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;
    // itemDetail = null;

    fetchListItems(QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));

    ever(_employmentStateStream, (state) {
      if (state is DeleteEmploymentDetailsSuccess) {
        Get.back();

        fetchListItems(QueryModel(
            offset: 0,
            limit: rowsPerPage,
            total: true,
            reverse: true));
      }
      if (state is DeleteEmploymentDetailsFailure) {
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
    for (var item in dataList.cast<Employment>()) {
      if (item.selected) selectedItemIds.add(item.id!);
    }

    if (dataList.isNotEmpty) {
      _employmentStateStream.value = DeleteEmploymentDetailsProcessing();
      var res = await _employmentRepository.deleteEmployments(QueryModel(
        ids: selectedItemIds,
      ));
      if (res.status != ApiStatus.Ok) {
        _employmentStateStream.value = DeleteEmploymentDetailsFailure(
            message: res.message ?? "Something went wrong, please try again",
            status: res.status);
        return;
      }
      dataList.removeWhere((element) => element.selected);
      totalRows = dataList.length;
      _employmentStateStream.value = DeleteEmploymentDetailsSuccess();
    }
  }
}

class AddNewEmploymentController extends GetxController {
  AddNewEmploymentController({required employmentRepository})
      : _employmentRepository = employmentRepository;
  final IEmploymentRepository _employmentRepository;
  final _stateStream = AddEmploymentState().obs;

  AddEmploymentState get state => _stateStream.value;
  final workingDays = <int>[].obs;
  final workplaceId = ''.obs;
  final emailController = TextEditingController();
  final travelTimeController = TextEditingController();
  final workingTimeStartController = TextEditingController();
  final workingTimeEndController = TextEditingController();
  final lunchTimeStartController = TextEditingController();
  final lunchTimeEndController = TextEditingController();
  final scopeList = <Scope>[].obs;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddEmploymentSuccess) {
        Get.back();

        var eController = Get.find<EmploymentDetailController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void addNewItem() async {
    var format = DateFormat.jm();
    var wkf = format.parse(workingTimeStartController.text);
    var wkt = format.parse(workingTimeEndController.text);
    var ltf = format.parse(lunchTimeStartController.text);
    var ltt = format.parse(lunchTimeEndController.text);
    var workingTimeFrom = wkf.hour * 60 + wkf.minute;
    var workingTimeTo = wkt.hour * 60 + wkt.minute;
    var lunchTimeFrom = ltf.hour * 60 + ltf.minute;
    var lunchTimeTo = ltt.hour * 60 + ltt.minute;

    var data = Employment(
      email: emailController.text,
      workplaceId: workplaceId.value,
      workingTimeFrom: workingTimeFrom,
      workingTimeTo: workingTimeTo,
      lunchTimeFrom: lunchTimeFrom,
      lunchTimeTo: lunchTimeTo,
      timeToWork: int.parse(travelTimeController.text),
      workingDays: workingDays,
      scopeList: scopeList,
    );

    _stateStream.value = AddEmploymentLoading();
    var res = await _employmentRepository.createEmployment(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddEmploymentFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddEmploymentSuccess();
  }
}

class EditEmploymentController extends GetxController {
  EditEmploymentController({required employmentRepository})
      : _employmentRepository = employmentRepository;
  final IEmploymentRepository _employmentRepository;
  final _stateStream = EditEmploymentState().obs;
  final _itemDetail = Employment().obs;

  Employment? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditEmploymentState get state => _stateStream.value;

  //fields
  final workingDays = <int>[].obs;
  final workplaceId = ''.obs;
  final emailController = TextEditingController();
  final travelTimeController = TextEditingController();
  final workingTimeStartController = TextEditingController();
  final workingTimeEndController = TextEditingController();
  final lunchTimeStartController = TextEditingController();
  final lunchTimeEndController = TextEditingController();
  final scopeList = <Scope>[].obs;
  void changeEditItem(Employment? data) {
    if (data != null) {
      var startingTime = toTimeStringC(data.workingTimeFrom!);
      var endingTime = toTimeStringC(data.workingTimeTo!);
      var lunchStartingTime = toTimeStringC(data.lunchTimeFrom!);
      var lunchEndingTime = toTimeStringC(data.lunchTimeTo!);

      workplaceId.value = data.workplaceId!;
      emailController.text = data.email!;
      travelTimeController.text = data.timeToWork!.toString();
      workingTimeStartController.text = startingTime;
      workingTimeEndController.text = endingTime;
      lunchTimeStartController.text = lunchStartingTime;
      lunchTimeEndController.text = lunchEndingTime;
      if (data.workingDays != null && data.workingDays!.length > 0) {
        workingDays.value = data.workingDays!;
      }
      if (data.scopeList != null) {
        scopeList.value = data.scopeList!;
      }

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditEmploymentSuccess) {
        Get.back();

        var eController = Get.find<EmploymentDetailController>();
        eController.fetchListItems(
            QueryModel(offset: eController.firstRowIndex, limit: eController.rowsPerPage, total: true, reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    var format = DateFormat.jm();
    var wkf = format.parse(workingTimeStartController.text);
    var wkt = format.parse(workingTimeEndController.text);
    var ltf = format.parse(lunchTimeStartController.text);
    var ltt = format.parse(lunchTimeEndController.text);
    var workingTimeFrom = wkf.hour * 60 + wkf.minute;
    var workingTimeTo = wkt.hour * 60 + wkt.minute;
    var lunchTimeFrom = ltf.hour * 60 + ltf.minute;
    var lunchTimeTo = ltt.hour * 60 + ltt.minute;

    var data = Employment(
      id: itemDetail!.id,
      email: emailController.text,
      workplaceId: workplaceId.value,
      workingTimeFrom: workingTimeFrom,
      workingTimeTo: workingTimeTo,
      lunchTimeFrom: lunchTimeFrom,
      lunchTimeTo: lunchTimeTo,
      timeToWork: int.parse(travelTimeController.text),
      workingDays: workingDays,
      scopeList: scopeList,
    );

    _stateStream.value = EditEmploymentLoading();
    var res = await _employmentRepository.updateEmployment(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditEmploymentFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditEmploymentSuccess();
  }
}