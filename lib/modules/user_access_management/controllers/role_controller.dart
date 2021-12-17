import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states/barrel.dart';

class RoleController extends SubTabController {
  RoleController({required userAccessRepository, required this.info}) : _userAccessRepository = userAccessRepository;

  final IUserAccessRepository _userAccessRepository;
  final SubTabInfoModel info;
  final _stateStream = RoleState().obs;
  final allItemsList = <Role>[].obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = RoleLoading();
    var res = await _userAccessRepository.getRoles(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = RoleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = RoleLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void fetchAll() async {
    var res = await _userAccessRepository.getRoles(QueryModel(
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
    Get.find<PermissionController>().isCurrent = false;
    Get.find<OrganisationController>().isCurrent = false;
    Get.find<PermissionModuleController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Role) {
      var editController = Get.find<EditRoleController>();
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

class AddNewRoleController extends GetxController {
  AddNewRoleController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = AddRoleState().obs;

  AddRoleState get state => _stateStream.value;
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final organisation = ''.obs;
  final selectedModules = <String>[].obs;
  final selectedPermissions = <Permission>[].obs;

  @override
  void onInit() {
    super.onInit();

    Get.find<OrganisationController>().fetchAll();

    ever(_stateStream, (state) {
      if (state is AddRoleSuccess) {
        Get.back();

        var gController = Get.find<RoleController>();
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
    var data = Role(
      name: nameController.text,
      description: descriptionController.text,
      organisation: organisation.value,
      permissions: selectedPermissions.map((e) => e.id!).toList(),
    );

    _stateStream.value = AddRoleLoading();
    var res = await _repository.createRole(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddRoleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddRoleSuccess();
  }
  void clear() async {
    nameController.text = "";
    descriptionController.text = "";
    organisation.value = "";
  }
}

class EditRoleController extends GetxController {
  EditRoleController({required repository})
      : _repository = repository;
  final IUserAccessRepository _repository;
  final _stateStream = EditRoleState().obs;
  final _itemDetail = Role().obs;

  Role? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditRoleState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final organisation = ''.obs;
  final selectedModules = <String>[].obs;
  final selectedPermissions = <Permission>[].obs;

  void changeEditItem(Role? data) {
    if (data != null) {
      nameController.text = data.name!;
      descriptionController.text = data.description!;
      organisation.value = data.organisation ?? "";
      selectedPermissions.value = List<Permission>.from(data.permissionList ?? []);
      itemDetail = data;
    }
  }

  void clearEdit() {
    nameController.text = itemDetail!.name!;
    descriptionController.text = itemDetail!.description!;
    organisation.value = itemDetail!.organisation ?? "";
    selectedPermissions.value = List<Permission>.from(itemDetail!.permissionList ?? []);
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditRoleSuccess) {
        Get.back();

        var gController = Get.find<RoleController>();
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
    var data = Role(
      id: itemDetail!.id,
      name: nameController.text,
      description: descriptionController.text,
      organisation: organisation.value,
      permissions: selectedPermissions.map((e) => e.id!).toList(),
    );

    _stateStream.value = EditRoleLoading();
    var res = await _repository.updateRole(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditRoleFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditRoleSuccess();
  }
}