import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/states/contact_form_states.dart';

import 'barrel.dart';

class ContactFormController extends SubTabController {
  ContactFormController({required repository, required this.info}) : _repository = repository;

  final IEmploymentRepository _repository;
  final SubTabInfoModel info;
  final _stateStream = ContactFormState().obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = ContactFormLoading();
    var res = await _repository.getContactForms(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = ContactFormFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = ContactFormLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<EmploymentDetailController>().isCurrent = false;
    Get.find<WorkplaceDetailController>().isCurrent = false;
    Get.find<ProWorkScheduleController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is ProWorkSchedule) {
      var editController = Get.find<EditProScheduleController>();
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