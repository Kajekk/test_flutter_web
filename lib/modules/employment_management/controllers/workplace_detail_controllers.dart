import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/models/workplace_detail.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/states/barrel.dart';

class WorkplaceDetailController extends SubTabController {
  WorkplaceDetailController({required employmentRepository, required this.info}) : _employmentRepository = employmentRepository;

  final IEmploymentRepository _employmentRepository;
  final SubTabInfoModel info;
  final _workplaceStateStream = WorkplaceDetailState().obs;
  // final _itemDetail = WorkplaceDetail().obs;
  //
  // WorkplaceDetail? get itemDetail => _itemDetail.value;
  //
  // set itemDetail(value) {
  //   _itemDetail.value = value;
  // }

  WorkplaceDetailState get state => _workplaceStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _workplaceStateStream.value = WorkplaceDetailLoading();
    var res = await _employmentRepository.getWorkplaceDetailLists(queryModel);
    if (res.status != ApiStatus.Ok) {
      _workplaceStateStream.value = WorkplaceDetailFailure(message: res.message ?? "Something went wrong, please try again");
    }
    totalRows = res.total ?? 0;
    _workplaceStateStream.value = WorkplaceDetailLoaded(listData: res.data!);
  }
  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    if (!isCurrent) {
      isCurrent = true;
      Get.find<EmploymentDetailController>().isCurrent = false;
      // Get.find<EntityTypeController3>().isCurrent = false;

    }
  }

  void selectItemDetail(BaseModel? item) {
    if (item is WorkplaceDetail) {
      EditWorkplaceController editController = Get.find();
      editController.changeEditItem(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    subTabInfoModel = info;
    // itemDetail = null;

    fetchListItems(QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));
  }
}

class AddNewWorkplaceController extends GetxController {
  AddNewWorkplaceController({required employmentRepository})
      : _employmentRepository = employmentRepository;
  final IEmploymentRepository _employmentRepository;
  final _stateStream = AddWorkplaceDetailState().obs;

  AddWorkplaceDetailState get state => _stateStream.value;
  //fields
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddWorkplaceDetailSuccess) {
        Get.back();

        var eController = Get.find<WorkplaceDetailController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void addNewItem() async {
    var data = WorkplaceDetail(
      name: nameController.text,
      address: addressController.text,
      latitude: double.parse(latController.text),
      longitude: double.parse(longController.text),
    );

    _stateStream.value = AddWorkplaceDetailLoading();
    var res = await _employmentRepository.createWorkplace(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddWorkplaceDetailFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddWorkplaceDetailSuccess();
  }
}

class EditWorkplaceController extends GetxController {
  EditWorkplaceController({required employmentRepository})
      : _employmentRepository = employmentRepository;
  final IEmploymentRepository _employmentRepository;
  final _stateStream = EditWorkplaceDetailState().obs;
  final _itemDetail = WorkplaceDetail().obs;

  WorkplaceDetail? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }
  EditWorkplaceDetailState get state => _stateStream.value;

  //fields
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final latController = TextEditingController();
  final longController = TextEditingController();

  void changeEditItem(WorkplaceDetail? data) {
    if (data != null) {
      nameController.text = data.name!;
      addressController.text = data.address!;
      latController.text = data.latitude!.toString();
      longController.text = data.longitude!.toString();

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditWorkplaceDetailSuccess) {
        Get.back();

        var eController = Get.find<WorkplaceDetailController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));
      }
    });
  }

  void editItem() async {
    var data = WorkplaceDetail(
      id: itemDetail!.id,
      name: nameController.text,
      address: addressController.text,
      latitude: double.parse(latController.text),
      longitude: double.parse(longController.text),
    );

    _stateStream.value = EditWorkplaceDetailLoading();
    var res = await _employmentRepository.updateWorkplace(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditWorkplaceDetailFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditWorkplaceDetailSuccess();
  }
}