import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states/barrel.dart';

class PermissionModuleController extends SubTabController {
  PermissionModuleController({required userAccessRepository, required this.info}) : _userAccessRepository = userAccessRepository;

  final IUserAccessRepository _userAccessRepository;
  final SubTabInfoModel info;
  final _stateStream = PermissionModuleState().obs;
  final allItemsList = <PermissionModule>[].obs;
  final itemsList = <PermissionModule>[].obs;

  get state => _stateStream.value;

  void fetchAll() async {
    var res = await _userAccessRepository.getPermissionModules(QueryModel(
      total: true,
      reverse: true,
      offset: 0,
      limit: 10000,
    ));
    if (res.status != ApiStatus.Ok) {
      return;
    }
    allItemsList.value = res.data!;
  }

  void fetch(QueryModel queryModel) async {
    var res = await _userAccessRepository.getPermissionModules(queryModel);
    if (res.status != ApiStatus.Ok) {
      return;
    }
    itemsList.value = res.data!;
  }

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = PermissionModuleLoading();
    var res = await _userAccessRepository.getPermissionModules(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = PermissionModuleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = PermissionModuleLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }

  void changeSubTab() {
    isCurrent = true;
    Get.find<RoleController>().isCurrent = false;
    Get.find<OrganisationController>().isCurrent = false;
    Get.find<PermissionController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is PermissionModule) {
      var editController = Get.find<EditPermissionModuleController>();
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

class AddNewPermissionModuleController extends GetxController {
  AddNewPermissionModuleController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = AddPermissionModuleState().obs;

  AddPermissionModuleState get state => _stateStream.value;
  final nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddPermissionModuleSuccess) {
        Get.back();

        var gController = Get.find<PermissionModuleController>();
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
    var data = PermissionModule(
      name: nameController.text,
    );

    _stateStream.value = AddPermissionModuleLoading();
    var res = await _repository.createPermissionModule(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddPermissionModuleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddPermissionModuleSuccess();
  }
  void clear() async {
    nameController.text = "";
  }
}

class EditPermissionModuleController extends GetxController {
  EditPermissionModuleController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = EditPermissionModuleState().obs;
  final _itemDetail = PermissionModule().obs;

  PermissionModule? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditPermissionModuleState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();

  void changeEditItem(PermissionModule? data) {
    if (data != null) {
      nameController.text = data.name!;
      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditPermissionModuleSuccess) {
        Get.back();

        var gController = Get.find<PermissionModuleController>();
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
    var data = PermissionModule(
      id: itemDetail!.id,
      name: nameController.text,
    );

    _stateStream.value = EditPermissionModuleLoading();
    var res = await _repository.updatePermissionModule(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditPermissionModuleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditPermissionModuleSuccess();
  }
}
