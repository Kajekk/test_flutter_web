import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

class OrganisationController extends SubTabController {
  OrganisationController({required userAccessRepository, required this.info}) : _userAccessRepository = userAccessRepository;

  final IUserAccessRepository _userAccessRepository;
  final SubTabInfoModel info;
  final _stateStream = OrganisationState().obs;
  final allItemsList = <Organisation>[].obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = OrganisationLoading();
    var res = await _userAccessRepository.getOrganisations(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = OrganisationFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = OrganisationLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void fetchAll() async {
    var res = await _userAccessRepository.getOrganisations(QueryModel(
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

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<RoleController>().isCurrent = false;
    Get.find<PermissionController>().isCurrent = false;
    Get.find<PermissionModuleController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Organisation) {
      var editController = Get.find<EditOrganisationController>();
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

class AddNewOrganisationController extends GetxController {
  AddNewOrganisationController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = AddOrganisationState().obs;

  AddOrganisationState get state => _stateStream.value;
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final selectedModules = <String>[].obs;
  final selectedPermissions = <Permission>[].obs;

  @override
  void onInit() {
    super.onInit();

    Get.find<PermissionController>().fetchAll();
    Get.find<PermissionModuleController>().fetchAll();

    ever(_stateStream, (state) {
      if (state is AddOrganisationSuccess) {
        Get.back();

        var gController = Get.find<OrganisationController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
        gController.fetchAll();
        clear();
      }
    });
  }

  void addNewItem() async {
    var data = Organisation(
      name: nameController.text,
      code: codeController.text,
      permissions: selectedPermissions.map((e) => e.id!).toList(),
    );

    _stateStream.value = AddOrganisationLoading();
    var res = await _repository.createOrganisation(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddOrganisationFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddOrganisationSuccess();
  }
  void clear() async {
    nameController.text = "";
    codeController.text = "";
    selectedModules.value = [];
    selectedPermissions.value = [];
  }
}

class EditOrganisationController extends GetxController {
  EditOrganisationController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = EditOrganisationState().obs;
  final _itemDetail = Organisation().obs;

  Organisation? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditOrganisationState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final codeController = TextEditingController();
  final selectedModules = <String>[].obs;
  final selectedPermissions = <Permission>[].obs;

  void changeEditItem(Organisation? data) {
    if (data != null) {
      nameController.text = data.name!;
      codeController.text = data.code!;
      selectedPermissions.value = List<Permission>.from(data.permissionList ?? []);
      itemDetail = data;
    }
  }

  void clearEdit() {
    nameController.text = itemDetail!.name!;
    codeController.text = itemDetail!.code!;
    selectedPermissions.value = List<Permission>.from(itemDetail!.permissionList ?? []);
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    Get.find<PermissionController>().fetchAll();
    Get.find<PermissionModuleController>().fetchAll();

    ever(_stateStream, (state) {
      if (state is EditOrganisationSuccess) {
        Get.back();

        var gController = Get.find<OrganisationController>();
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
    var data = Organisation(
      id: itemDetail!.id,
      name: nameController.text,
      code: codeController.text,
      permissions: selectedPermissions.map((e) => e.id!).toList(),
    );

    _stateStream.value = EditOrganisationLoading();
    var res = await _repository.updateOrganisation(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditOrganisationFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditOrganisationSuccess();
  }
}
