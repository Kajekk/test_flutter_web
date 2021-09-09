import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'barrel.dart';

class EmploymentDetailController extends SubTabController {
  EmploymentDetailController({required this.employmentRepository, required this.info});

  final IEmploymentRepository employmentRepository;
  final SubTabInfoModel info;
  final _employmentStateStream = EmploymentDetailState().obs;
  final _itemDetail = Employment().obs;

  Employment? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  } // final _countItemStateStream = CountEmotionalLogsState().obs;

  get employmentState => _employmentStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _employmentStateStream.value = EmploymentDetailLoading();
    var res = await employmentRepository.getEmploymentLists(queryModel);
    if (res.status != ApiStatus.Ok) {
      _employmentStateStream.value = EmploymentDetailFailure(message: res.message ?? "Something went wrong, please try again");
    }
    totalRows = res.total ?? 0;
    _employmentStateStream.value = EmploymentDetailLoaded(listData: res.data!);
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
    if (item is Employment) {
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

class AddNewEmploymentController extends GetxController {
  final currentType = 'happy'.obs;
  void addNewItem(Employment data) {

  }
}
