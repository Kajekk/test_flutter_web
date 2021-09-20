import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/emotional_management/states/barrel.dart';

class EmotionalLogController extends SubTabController {
  EmotionalLogController({required emotionalLogRepository, required this.info}) : _emotionalLogRepository = emotionalLogRepository;

  final IEmotionalRepository _emotionalLogRepository;
  final SubTabInfoModel info;
  final _emotionalStateStream = EmotionalLogState().obs;

  get emotionalLogState => _emotionalStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _emotionalStateStream.value = EmotionalLogLoading();
    var res = await _emotionalLogRepository.getEmotionalLogs(queryModel);
    if (res.status != ApiStatus.Ok) {
      _emotionalStateStream.value = EmotionalLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _emotionalStateStream.value = EmotionalLogLoaded(listData: res.data!);
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    // Get.find<EntityTypeController2>().isCurrent = false;
    // Get.find<EntityTypeController3>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is EmotionalLog) {
      var editController = Get.find<EditEmotionalLogController>();
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

class AddNewEmotionalLogController extends GetxController {
  AddNewEmotionalLogController({required emotionalLogRepository})
      : _emotionalLogRepository = emotionalLogRepository;
  final currentType = 'happy'.obs;
  final IEmotionalRepository _emotionalLogRepository;
  final _stateStream = AddEmotionalLogState().obs;

  AddEmotionalLogState get state => _stateStream.value;

  @override
  void onInit() {
    super.onInit();
    ever(_stateStream, (state) {
      if (state is AddEmotionalLogSuccess) {
        Get.back();

        var eController = Get.find<EmotionalLogController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void addNewItem(EmotionalLog data) async {
    _stateStream.value = AddEmotionalLogLoading();
    var res = await _emotionalLogRepository.createEmotionalLog(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddEmotionalLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddEmotionalLogSuccess();
  }
}

class EditEmotionalLogController extends GetxController {
  EditEmotionalLogController({required emotionalLogRepository})
      : _emotionalLogRepository = emotionalLogRepository;
  final IEmotionalRepository _emotionalLogRepository;
  final _stateStream = EditEmotionalLogState().obs;
  // EmotionalLog? editData = EmotionalLog();
  final _itemDetail = EmotionalLog().obs;

  EmotionalLog? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditEmotionalLogState get state => _stateStream.value;

  //fields
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final typeField = "".obs;
  void changeEditItem(EmotionalLog? data) {
    if (data != null) {
      emailController.text = data.email!;
      descriptionController.text = data.description!;
      typeField.value = data.type!;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditEmotionalLogSuccess) {
        Get.back();

        //fetch list data after edit item
        //set detail to null
        var eController = Get.find<EmotionalLogController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem(EmotionalLog data) async {
    _stateStream.value = EditEmotionalLogLoading();
    var res = await _emotionalLogRepository.updateEmotionalLog(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditEmotionalLogFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditEmotionalLogSuccess();
  }
}