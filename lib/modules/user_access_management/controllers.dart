import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/base_model.dart';
import 'package:test_flutter_web/data/models/emotional_log.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/data/models/test.dart';
import 'package:test_flutter_web/data/repository/emotional_repository.dart';
import 'package:test_flutter_web/data/repository/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states.dart';

class EntityTypeController extends SubTabController {
  EntityTypeController({required this.emotionalRepository, required this.info});

  final IEmotionalRepository emotionalRepository;
  final SubTabInfoModel info;
  final _emotionalLogStateStream = EmotionalLogState().obs;
  // final _countItemStateStream = CountEmotionalLogsState().obs;

  get emotionalLogState => _emotionalLogStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _emotionalLogStateStream.value = EmotionalLoading();
    var res = await emotionalRepository.getEmotionalLogs(queryModel);
    if (res.status != ApiStatus.Ok) {
      _emotionalLogStateStream.value = EmotionalFailure(message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _emotionalLogStateStream.value = EmotionalLoaded(listData: res.data!);
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
    // itemDetail = item;
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;
    // itemDetail = null;

    fetchListItems(QueryModel(offset: 0, limit: rowsPerPage, total: true));
  }

  @override
  void deleteItems() {
    // TODO: implement deleteItems
  }
}

class AddNewEntityTypeController extends GetxController {
  final currentType = 'happy'.obs;
  void addNewItem(EmotionalLog data) {

  }
}

