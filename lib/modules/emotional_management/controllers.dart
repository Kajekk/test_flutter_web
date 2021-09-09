import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';

class EmotionalLogController extends SubTabController {
  EmotionalLogController({required this.emotionalLogRepository, required this.info});

  final IEmotionalRepository emotionalLogRepository;
  final SubTabInfoModel info;
  final _employmentStateStream = EmotionalLogState().obs;
  final _itemDetail = EmotionalLog().obs;

  EmotionalLog? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  } // final _countItemStateStream = CountEmotionalLogsState().obs;

  get emotionalLogState => _employmentStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _employmentStateStream.value = EmotionalLogLoading();
    var res = await emotionalLogRepository.getEmotionalLogs(queryModel);
    if (res.status != ApiStatus.Ok) {
      _employmentStateStream.value = EmotionalLogFailure(message: res.message ?? "Something went wrong, please try again");
    }
    totalRows = res.total ?? 0;
    _employmentStateStream.value = EmotionalLogLoaded(listData: res.data!);
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
    if (item is EmotionalLog) {
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

class AddNewEmotionalLogController extends GetxController {
  final currentType = 'happy'.obs;
  void addNewItem(EmotionalLog data) {

  }
}
