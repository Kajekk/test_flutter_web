import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states/barrel.dart';

class PermissionController extends SubTabController {
  PermissionController({required userAccessRepository, required this.info}) : _userAccessRepository = userAccessRepository;

  final IUserAccessRepository _userAccessRepository;
  final SubTabInfoModel info;
  final _stateStream = PermissionState().obs;
  final allItemsList = <Permission>[].obs;
  final itemsList = <Permission>[].obs;

  get state => _stateStream.value;

  void fetchAll() async {
    var res = await _userAccessRepository.getPermissions(QueryModel(
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
    var res = await _userAccessRepository.getPermissions(queryModel);
    if (res.status != ApiStatus.Ok) {
      return;
    }
    itemsList.value = res.data!;
  }

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = PermissionLoading();
    var res = await _userAccessRepository.getPermissions(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = PermissionFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = PermissionLoaded(listData: res.data!);
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
    Get.find<PermissionModuleController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Permission) {
      var editController = Get.find<EditPermissionController>();
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

class AddNewPermissionController extends GetxController {
  AddNewPermissionController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = AddPermissionState().obs;

  AddPermissionState get state => _stateStream.value;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final resourceController = TextEditingController();
  final moduleId = ''.obs;
  final actionMap = Map<String, bool>.of({
    "GET": false,
    "POST": false,
    "PUT": false,
    "DELETE": false,
  }).obs;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddPermissionSuccess) {
        Get.back();

        var gController = Get.find<PermissionController>();
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
    var actions = <String>[];
    actionMap.forEach((key, hasPermission) {
      if (hasPermission) {
        actions.add(key);
      }
    });

    var data = Permission(
      name: nameController.text,
      description: descriptionController.text,
      resource: resourceController.text,
      action: actions,
      moduleId: moduleId.value,
    );

    _stateStream.value = AddPermissionLoading();
    var res = await _repository.createPermission(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddPermissionFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddPermissionSuccess();
  }
  void clear() async {
    nameController.text = "";
    descriptionController.text = "";
    resourceController.text = "";
    actionMap.forEach((key, value) {
      actionMap[key] = false;
    });
  }
}

class EditPermissionController extends GetxController {
  EditPermissionController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = EditPermissionState().obs;
  final _itemDetail = Permission().obs;

  Permission? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditPermissionState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final resourceController = TextEditingController();
  final actionMap = Map<String, bool>().obs;
  final moduleId = ''.obs;
  void changeEditItem(Permission? data) {
    if (data != null) {
      actionMap['GET'] = false;
      actionMap['POST'] = false;
      actionMap['PUT'] = false;
      actionMap['DELETE'] = false;

      nameController.text = data.name!;
      descriptionController.text = data.description!;
      resourceController.text = data.resource!;
      data.action!.forEach((element) {
        actionMap[element] = true;
      });
      moduleId.value = data.moduleId ?? "others";

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditPermissionSuccess) {
        Get.back();

        var gController = Get.find<PermissionController>();
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
    var actions = <String>[];
    actionMap.forEach((key, hasPermission) {
      if (hasPermission) {
        actions.add(key);
      }
    });

    var data = Permission(
      id: itemDetail!.id,
      name: nameController.text,
      description: descriptionController.text,
      resource: resourceController.text,
      action: actions,
      moduleId: moduleId.value,
    );

    _stateStream.value = EditPermissionLoading();
    var res = await _repository.updatePermission(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditPermissionFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditPermissionSuccess();
  }
}
