import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/term_service_privacy_policy/barrel.dart';

class AgreementController extends SubTabController {
  AgreementController({required repository, required this.info}) : _repository = repository;

  final IAgreementAndPolicyRepository _repository;
  final SubTabInfoModel info;
  final _stateStream = AgreementState().obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = AgreementLoading();
    var res = await _repository.getAgreements(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AgreementFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = AgreementLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<PolicyController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Agreement) {
      // var editController = Get.find<EditEmotionalLogController>();
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

class AddNewAgreementController extends GetxController {
  AddNewAgreementController({required repository})
      : _repository = repository;
  final IAgreementAndPolicyRepository _repository;
  final _stateStream = AddAgreementState().obs;

  AddAgreementState get state => _stateStream.value;
  final agreementController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddAgreementSuccess) {
        Get.back();

        var gController = Get.find<AgreementController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
    var data = Agreement(
        description: agreementController.text,
    );

    _stateStream.value = AddAgreementLoading();
    var res = await _repository.createAgreement(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddAgreementFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddAgreementSuccess();
  }
}

class EditAgreementController extends GetxController {
  EditAgreementController({required repository})
      : _repository = repository;
  final IAgreementAndPolicyRepository _repository;
  final _stateStream = EditAgreementState().obs;
  final _itemDetail = Agreement().obs;

  Agreement? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditAgreementState get state => _stateStream.value;

  //fields
  final agreementController = TextEditingController();
  void changeEditItem(Agreement? data) {
    if (data != null) {
      agreementController.text = data.description!;
      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditAgreementSuccess) {
        Get.back();

        var gController = Get.find<AgreementController>();
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
    var data = Agreement(
      id: itemDetail!.id,
      description: agreementController.text,
    );

    _stateStream.value = EditAgreementLoading();
    var res = await _repository.updateAgreement(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditAgreementFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditAgreementSuccess();
  }
}
