import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/community_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

class TopicController extends SubTabController {
  TopicController({required communityRepository, required this.info}) : _communityRepository = communityRepository;

  final ICommunityRepository _communityRepository;
  final SubTabInfoModel info;
  final _topicStateStream = CommunityTopicState().obs;

  get topicStateStream => _topicStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _topicStateStream.value = CommunityTopicLoading();
    var res = await _communityRepository.getTopics(queryModel);
    if (res.status != ApiStatus.Ok) {
      _topicStateStream.value = CommunityTopicFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _topicStateStream.value = CommunityTopicLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    // Get.find<EmotionTypeController>().isCurrent = false;
    // Get.find<EntityTypeController3>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is CommunityTopic) {
      var editController = Get.find<EditCommunityTopicController>();
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

    //TODO
    // ever(_topicStateStream, (state) {
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
    //TODO
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
    //         message: res.message ?? "Something went wrong, please try again",
    //       );
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _emotionalStateStream.value = DeleteEmotionalLogsSuccess();
    // }
  }
}

class AddNewCommunityController extends GetxController {
  AddNewCommunityController({required communityRepository})
      : _communityRepository = communityRepository;
  final ICommunityRepository _communityRepository;
  final _stateStream = AddCommunityTopicState().obs;

  AddCommunityTopicState get state => _stateStream.value;
  final topicController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final organisation = ''.obs;

  @override
  void onInit() {
    super.onInit();

    Get.find<OrganisationController>().fetchAll();

    ever(_stateStream, (state) {
      if (state is AddCommunityTopicSuccess) {
        Get.back();

        var eController = Get.find<TopicController>();
        eController.fetchListItems(
            QueryModel(offset: 0, limit: eController.rowsPerPage, total: true, reverse: true));

        clear();
      }
    });

  }

  void addNewItem() async {
    DateTime? startDate;
    DateTime? endDate;
    if (startDateController.text.isNotEmpty) {
      startDate = DateFormat.yMd().parse(startDateController.text).toUtc();
    }
    if (endDateController.text.isNotEmpty) {
      endDate = DateFormat.yMd().parse(endDateController.text);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59).toUtc();
    }

    var data = CommunityTopic(
      organisation: organisation.value,
      topic: topicController.text,
      startTime: startDate,
      endTime: endDate,
    );

    _stateStream.value = AddCommunityTopicLoading();
    var res = await _communityRepository.createTopic(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddCommunityTopicFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddCommunityTopicSuccess();
  }

  void clear() async {
    topicController.text = "";
    startDateController.text = "";
    endDateController.text = "";
    organisation.value = "";
  }
}

class EditCommunityTopicController extends GetxController {
  EditCommunityTopicController({required communityRepository})
      : _communityRepository = communityRepository;
  final ICommunityRepository _communityRepository;
  final _stateStream = EditCommunityTopicState().obs;
  final _itemDetail = CommunityTopic().obs;

  CommunityTopic? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditCommunityTopicState get state => _stateStream.value;
  final topicController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final organisation = ''.obs;

  void changeEditItem(CommunityTopic? data) {
    if (data != null) {
      topicController.text = data.topic!;
      organisation.value = data.organisation!;
      var startDate = DateFormat.yMd().add_jm().format(data.startTime!.toLocal());
      var endDate = DateFormat.yMd().add_jm().format(data.endTime!.toLocal());
      startDateController.text = startDate;
      endDateController.text = endDate;

      itemDetail = data;
    }
  }

  void clearEdit() {
    topicController.text = itemDetail!.topic!;
    organisation.value = itemDetail!.organisation!;
    var startDate = DateFormat.yMd().add_jm().format(itemDetail!.startTime!.toLocal());
    var endDate = DateFormat.yMd().add_jm().format(itemDetail!.endTime!.toLocal());
    startDateController.text = startDate;
    endDateController.text = endDate;
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditCommunityTopicSuccess) {
        Get.back();

        //fetch list data after edit item
        //set detail to null
        var eController = Get.find<TopicController>();
        eController.fetchListItems(
            QueryModel(offset: eController.firstRowIndex, limit: eController.rowsPerPage, total: true, reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    DateTime? startDate;
    DateTime? endDate;
    if (startDateController.text.isNotEmpty) {
      startDate = DateFormat.yMd().parse(startDateController.text).toUtc();
    }
    if (endDateController.text.isNotEmpty) {
      endDate = DateFormat.yMd().parse(endDateController.text);
      endDate = DateTime(endDate.year, endDate.month, endDate.day, 23, 59).toUtc();
    }

    var data = CommunityTopic(
      id: itemDetail!.id,
      organisation: organisation.value,
      topic: topicController.text,
      startTime: startDate,
      endTime: endDate,
    );

    _stateStream.value = EditCommunityTopicLoading();
    var res = await _communityRepository.updateTopic(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditCommunityTopicFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditCommunityTopicSuccess();
  }
}