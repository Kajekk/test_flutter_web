import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';
import 'package:test_flutter_web/modules/support_management/states/barrel.dart';

class SupportMetricController extends SubTabController {
  SupportMetricController({required supportRepository, required this.info})
      : _supportRepository = supportRepository;
  final ISupportRepository _supportRepository;
  final SubTabInfoModel info;
  final _stateStream = SupportMetricState().obs;
  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = SupportMetricLoading();
    var res = await _supportRepository.getSupportMetricList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = SupportMetricFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = SupportMetricLoaded(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<AttendanceController>().isCurrent = false;
    Get.find<SupportLogController>().isCurrent = false;
    Get.find<LocationTrackingController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is SupportMetric) {
      // itemDetail = item;
      // var editController = Get.find<EditAttendanceController>();
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

    // ever(_attendanceStateStream, (state) {
    //   if (state is DeleteAttendancesSuccess) {
    //     Get.back();
    //
    //     fetchListItems(QueryModel(
    //         offset: 0,
    //         limit: rowsPerPage,
    //         total: true,
    //         reverse: true));
    //   }
    //   if (state is DeleteAttendancesFailure) {
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
    // for (var item in dataList.cast<AttendanceModel>()) {
    //   if (item.selected) selectedItemIds.add(item.id!);
    // }
    //
    // if (dataList.isNotEmpty) {
    //   _attendanceStateStream.value = DeleteAttendancesProcessing();
    //   var res = await _supportRepository.deleteAttendances(QueryModel(
    //     ids: selectedItemIds,
    //   ));
    //   if (res.status != ApiStatus.Ok) {
    //     _attendanceStateStream.value = DeleteAttendancesFailure(
    //         message: res.message ?? "Something went wrong, please try again",
    //         status: res.status);
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _attendanceStateStream.value = DeleteAttendancesSuccess();
    // }
  }
}
