import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/emotional_management/barrel.dart';
import 'package:test_flutter_web/modules/emotional_management/states/barrel.dart';

class EmotionTypeController extends SubTabController {
  EmotionTypeController({required emotionTypeRepository, required this.info}) : _emotionTypeRepository = emotionTypeRepository;

  final IEmotionalRepository _emotionTypeRepository;
  final SubTabInfoModel info;
  final _emotionTypeStateStream = EmotionTypeState().obs;

  get emotionTypeState => _emotionTypeStateStream.value;

  @override
  void onInit() {
    super.onInit();
    subTabInfoModel = info;

    fetchListItems(
        QueryModel(offset: 0, limit: rowsPerPage, total: true));
  }

  @override
  void changeSubTab() {
    isCurrent = true;
    Get.find<EmotionalLogController>().isCurrent = false;
  }

  @override
  void countItems() {

  }

  @override
  void fetchListItems(QueryModel queryModel) async {
    _emotionTypeStateStream.value = EmotionTypeLoading();
    var res = await _emotionTypeRepository.getEmotionalTypes(queryModel);
    if (res.status != ApiStatus.Ok) {
      _emotionTypeStateStream.value = EmotionTypeFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _emotionTypeStateStream.value = EmotionTypeLoaded(listData: res.data!);
    dataList = res.data!;
  }

  @override
  void selectItemDetail(BaseModel? item) {
    if (item is EmotionType) {
      var editController = Get.find<EditEmotionTypeController>();
      editController.changeEditItem(item);
    }
  }

  @override
  void deleteItems() {
    // TODO: implement deleteItems
  }

}

class AddNewEmotionTypeController extends GetxController {
  AddNewEmotionTypeController({required emotionTypeRepository})
      : _emotionTypeRepository = emotionTypeRepository;
  final IEmotionalRepository _emotionTypeRepository;
  final _stateStream = AddEmotionTypeState().obs;

  AddEmotionTypeState get state => _stateStream.value;

  @override
  void onInit() {
    super.onInit();
    ever(_stateStream, (state) {
      if (state is AddEmotionTypeSuccess) {
        Get.back();

        var eController = Get.find<EmotionTypeController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void addNewItem(EmotionType data) async {
    _stateStream.value = AddEmotionTypeLoading();
    var res = await _emotionTypeRepository.createEmotionalType(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddEmotionTypeFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddEmotionTypeSuccess();
  }
}

class EditEmotionTypeController extends GetxController {
  EditEmotionTypeController({required emotionTypeRepository})
      : _emotionTypeRepository = emotionTypeRepository;
  final IEmotionalRepository _emotionTypeRepository;
  final _stateStream = EditEmotionTypeState().obs;
  // EmotionalLog? editData = EmotionalLog();
  final _itemDetail = EmotionType().obs;

  EmotionType? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditEmotionTypeState get state => _stateStream.value;

  //fields
  // final emailController = TextEditingController();
  // final descriptionController = TextEditingController();
  // final typeField = "".obs;
  void changeEditItem(EmotionType? data) {
    if (data != null) {
      // emailController.text = data.email!;
      // descriptionController.text = data.description!;
      // typeField.value = data.type!;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditEmotionTypeSuccess) {
        Get.back();

        //fetch list data after edit item
        //set detail to null
        var eController = Get.find<EmotionTypeController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem(EmotionType data) async {
    _stateStream.value = EditEmotionTypeLoading();
    var res = await _emotionTypeRepository.updateEmotionalType(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditEmotionTypeFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditEmotionTypeSuccess();
  }
}