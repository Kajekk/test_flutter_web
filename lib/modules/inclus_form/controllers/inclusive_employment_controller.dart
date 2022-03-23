import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/inclus_form/barrel.dart';

class InclusiveEmploymentController extends SubTabController {
  InclusiveEmploymentController({required repository, required this.info})
      : _repository = repository;

  final IInclusFormRepository _repository;
  final SubTabInfoModel info;
  final _stateStream = InclusiveEmploymentState().obs;

  get state => _stateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _stateStream.value = InclusiveEmploymentLoading();
    var res = await _repository.getInclusiveEmploymentFormList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = InclusiveEmploymentFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _stateStream.value = InclusiveEmploymentSuccess(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    Get.find<ContactUsController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is InclusiveEmploymentForm) {
      var editController = Get.find<EditInclusiveEmploymentController>();
      editController.changeEditItem(item);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isCurrent = true;
    subTabInfoModel = info;

    fetchListItems(
        QueryModel(offset: 0, limit: rowsPerPage, total: true, reverse: true));

    //TODO
    // ever(_quoteStateStream, (state) {
    //   if (state is DeleteQuotesSuccess) {
    //     Get.back();
    //
    //     fetchListItems(QueryModel(
    //         offset: 0,
    //         limit: rowsPerPage,
    //         total: true,
    //         reverse: true));
    //   }
    //   if (state is DeleteQuotesFailure) {
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
    // for (var item in dataList.cast<Quote>()) {
    //   if (item.selected) selectedItemIds.add(item.id!);
    // }
    //
    // if (dataList.isNotEmpty) {
    //   _quoteStateStream.value = DeleteQuotesProcessing();
    //   var res = await _homeRepository.deleteQuotes(QueryModel(
    //     ids: selectedItemIds,
    //   ));
    //   if (res.status != ApiStatus.Ok) {
    //     _quoteStateStream.value = DeleteQuotesFailure(
    //         message: res.message ?? "Something went wrong, please try again",
    //         status: res.status);
    //     return;
    //   }
    //   dataList.removeWhere((element) => element.selected);
    //   totalRows = dataList.length;
    //   _quoteStateStream.value = DeleteQuotesSuccess();
    // }
  }
}

class AddNewInclusiveEmploymentController extends GetxController {
  AddNewInclusiveEmploymentController({required repository})
      : _repository = repository;
  final IInclusFormRepository _repository;
  final _stateStream = AddInclusiveEmploymentState().obs;

  AddInclusiveEmploymentState get state => _stateStream.value;

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddInclusiveEmploymentSuccess) {
        Get.back();

        var gController = Get.find<InclusiveEmploymentController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
  //   var data = Quote(
  //     quote: quoteController.text,
  //     author: authorController.text
  //   );
  //
  //   _stateStream.value = AddQuoteLoading();
  //   var res = await _homeRepository.createQuote(data);
  //   if (res.status != ApiStatus.Ok) {
  //     _stateStream.value = AddQuoteFailure(
  //         message: res.message ?? "Something went wrong, please try again");
  //     return;
  //   }
  //   _stateStream.value = AddQuoteSuccess();
  }
}

class EditInclusiveEmploymentController extends GetxController {
  EditInclusiveEmploymentController({required repository}) : _repository = repository;
  final IInclusFormRepository _repository;
  final _stateStream = EditInclusiveEmploymentState().obs;
  final _itemDetail = InclusiveEmploymentForm().obs;

  InclusiveEmploymentForm? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditInclusiveEmploymentState get state => _stateStream.value;

  //fields

  void changeEditItem(InclusiveEmploymentForm? data) {
    if (data != null) {
      //TODO
      // quoteController.text = data.quote!;
      // authorController.text = data.author!;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditInclusiveEmploymentSuccess) {
        Get.back();

        var gController = Get.find<InclusiveEmploymentController>();
        gController.fetchListItems(QueryModel(
            offset: gController.firstRowIndex,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
        itemDetail = null;
      }
    });
  }

  void editItem() async {
    var data = InclusiveEmploymentForm(
      id: itemDetail!.id,
    );

    _stateStream.value = EditInclusiveEmploymentLoading();
    var res = await _repository.updateInclusiveEmploymentForm(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditInclusiveEmploymentFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditInclusiveEmploymentSuccess();
  }
}