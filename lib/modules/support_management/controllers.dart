import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';

class AttendanceController extends SubTabController {
  AttendanceController({required this.supportRepository, required this.info});

  final ISupportRepository supportRepository;
  final SubTabInfoModel info;
  final _attendanceStateStream = AttendanceState().obs;
  final _itemDetail = AttendanceModel().obs;

  AttendanceModel? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  } // final _countItemStateStream = CountEmotionalLogsState().obs;

  get attendanceState => _attendanceStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _attendanceStateStream.value = AttendanceLoading();
    var res = await supportRepository.getAttendanceList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _attendanceStateStream.value = AttendanceFailure(message: res.message ?? "Something went wrong, please try again");
    }
    totalRows = res.total ?? 0;
    _attendanceStateStream.value = AttendanceLoaded(listData: res.data!);
  }
  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    // Get.find<EntityTypeController2>().isCurrent = false;
    // Get.find<EntityTypeController3>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is AttendanceModel) {
      itemDetail = item;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;
    itemDetail = null;

    fetchListItems(QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));
  }
}

class AddNewAttendanceController extends GetxController {
  final currentType = 'happy'.obs;
  void addNewItem(Employment data) {

  }
}
