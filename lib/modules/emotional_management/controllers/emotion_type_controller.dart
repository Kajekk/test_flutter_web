import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/emotional_management/states/barrel.dart';

class EmotionTypeController extends SubTabController {
  EmotionTypeController({required emotionTypeRepository, required this.info}) : _emotionTypeRepository = emotionTypeRepository;

  final IEmotionalRepository _emotionTypeRepository;
  final SubTabInfoModel info;
  final _emotionTypeStateStream = EmotionTypeState().obs;

  get emotionTypeState => _emotionTypeStateStream.value;

  @override
  void onInit() {
    super.onInit();
    subTabInfoModel = info;

    fetchListItems(
        QueryModel(offset: 0, limit: rowsPerPage, total: true));
  }

  @override
  void changeSubTab() {
    // TODO: implement changeSubTab
  }

  @override
  void countItems() {
    // TODO: implement countItems
  }

  @override
  void fetchListItems(QueryModel queryModel) async {
    _emotionTypeStateStream.value = EmotionTypeLoading();
    var res = await _emotionTypeRepository.getEmotionalTypes(queryModel);
    if (res.status != ApiStatus.Ok) {
      _emotionTypeStateStream.value = EmotionTypeFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    totalRows = res.total ?? 0;
    _emotionTypeStateStream.value = EmotionTypeLoaded(listData: res.data!);
  }

  @override
  void selectItemDetail(BaseModel? item) {
    // TODO: implement selectItemDetail
  }

}