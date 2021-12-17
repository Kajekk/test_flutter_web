import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/account_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

class PwdController extends SubTabController {
  PwdController({required accountRepository, required this.info}) : _accountRepository = accountRepository;

  final IAccountRepository _accountRepository;
  final SubTabInfoModel info;
  final _stateStream = PwdAccountState().obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = PwdAccountLoading();
    var res = await _accountRepository.getAccounts(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = PwdAccountFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = PwdAccountLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<ProController>().isCurrent = false;
    // Get.find<EntityTypeController3>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Account) {
      var editController = Get.find<EditPwdAccountController>();
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
        QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true, q: jsonEncode({'type': 'PWD'})));

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

class AddNewPwdAccountController extends GetxController {
  AddNewPwdAccountController({required repository})
      : _repository = repository;
  final IAccountRepository _repository;
  final _stateStream = AddPwdAccountState().obs;

  AddPwdAccountState get state => _stateStream.value;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final organisation = ''.obs;
  final role = ''.obs;
  final gender = 'male'.obs;
  final obscureText = true.obs;

  @override
  void onInit() {
    super.onInit();

    Get.find<OrganisationController>().fetchAll();
    Get.find<RoleController>().fetchAll();

    ever(_stateStream, (state) {
      if (state is AddPwdAccountSuccess) {
        Get.back();

        var gController = Get.find<PwdController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true,
            q: jsonEncode({'type': 'PWD'})
        ));

        clear();
      }
    });
  }

  void addNewItem() async {
    DateTime? dateOfBirth;
    if (dateOfBirthController.text.isNotEmpty) {
      dateOfBirth = DateFormat.yMd().parse(dateOfBirthController.text).toUtc();
    }
    var data = Account(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      organisation: organisation.value,
      role: role.value,
      phoneNumber: phoneNumberController.text,
      gender: gender.value,
      homeAddress: addressController.text,
      dateOfBirth: dateOfBirth,
      type: "PWD",
    );

    _stateStream.value = AddPwdAccountLoading();
    var res = await _repository.createAccount(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddPwdAccountFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddPwdAccountSuccess();
  }
  void clear() async {
    nameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    phoneNumberController.text = "";
    addressController.text = "";
    dateOfBirthController.text = "";
    organisation.value = "";
    role.value = "";
  }
}

class EditPwdAccountController extends GetxController {
  EditPwdAccountController({required repository})
      : _repository = repository;
  final IAccountRepository _repository;
  final _stateStream = EditPwdAccountState().obs;
  final _itemDetail = Account().obs;

  Account? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditPwdAccountState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final organisation = ''.obs;
  final role = ''.obs;
  final gender = 'male'.obs;
  final obscureText = true.obs;
  final uid = "".obs;

  void changeEditItem(Account? data) {
    if (data != null) {
      nameController.text = data.name!;
      emailController.text = data.email!;
      addressController.text = data.homeAddress ?? "";
      phoneNumberController.text = data.phoneNumber ?? "";
      if (data.dateOfBirth != null) {
        dateOfBirthController.text = DateFormat.yMd().format(data.dateOfBirth!.toLocal());
      }
      organisation.value = data.organisation ?? "";
      role.value = data.role ?? "";
      if (data.gender != null) {
        gender.value = data.gender!;
      }
      uid.value = data.uid!;

      itemDetail = data;
    }
  }

  void clearEdit() {
    nameController.text = itemDetail!.name!;
    emailController.text = itemDetail!.email!;
    addressController.text = itemDetail!.homeAddress ?? "";
    phoneNumberController.text = itemDetail!.phoneNumber ?? "";
    if (itemDetail!.dateOfBirth != null) {
      dateOfBirthController.text = DateFormat.yMd().format(itemDetail!.dateOfBirth!.toLocal());
    }
    organisation.value = itemDetail!.organisation!;
    role.value = itemDetail!.role!;
    if (itemDetail!.gender != null) {
      gender.value = itemDetail!.gender!;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditPwdAccountSuccess) {
        Get.back();

        var gController = Get.find<PwdController>();
        gController.fetchListItems(QueryModel(
            offset: gController.firstRowIndex,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true,
            q: jsonEncode({'type': 'PWD'})
        ));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    DateTime? dateOfBirth;
    if (dateOfBirthController.text.isNotEmpty) {
      dateOfBirth = DateFormat.yMd().parse(dateOfBirthController.text).toUtc();
    }
    var data = Account(
      id: itemDetail!.id,
      uid: uid.value,
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      organisation: organisation.value,
      role: role.value,
      phoneNumber: phoneNumberController.text,
      gender: gender.value,
      homeAddress: addressController.text,
      dateOfBirth: dateOfBirth,
      type: "PWD",
    );

    _stateStream.value = EditPwdAccountState();
    var res = await _repository.updateAccount(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditPwdAccountFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditPwdAccountSuccess();
  }
}
