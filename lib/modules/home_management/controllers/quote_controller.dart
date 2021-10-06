import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/data/repository/barrel.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';
import 'package:test_flutter_web/modules/home_management/barrel.dart';

class QuoteController extends SubTabController {
  QuoteController({required homeRepository, required this.info})
      : _homeRepository = homeRepository;

  final IHomeRepository _homeRepository;
  final SubTabInfoModel info;
  final _quoteStateStream = QuoteState().obs;

  get goalState => _quoteStateStream.value;

  void fetchListItems(QueryModel queryModel) async {
    _quoteStateStream.value = QuoteLoading();
    var res = await _homeRepository.getQuoteList(queryModel);
    if (res.status != ApiStatus.Ok) {
      _quoteStateStream.value = QuoteFailure(
          message: res.message ?? "Something went wrong, please try again",
          status: res.status);
      return;
    }
    totalRows = res.total ?? 0;
    _quoteStateStream.value = QuoteSuccess(listData: res.data!);
    dataList = res.data!;
  }

  void countItems() {
    // _countItemStateStream.value = CountEmotionalLoading();
    // var res = await
  }
  void changeSubTab() {
    isCurrent = true;
    // Get.find<GoalController>().isCurrent = false;
    // Get.find<GoalRelationshipController>().isCurrent = false;
  }

  void selectItemDetail(BaseModel? item) {
    if (item is Quote) {
      var editController = Get.find<EditQuoteController>();
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

    ever(_quoteStateStream, (state) {
      if (state is DeleteQuotesSuccess) {
        Get.back();

        fetchListItems(QueryModel(
            offset: 0,
            limit: rowsPerPage,
            total: true,
            reverse: true));
      }
      if (state is DeleteQuotesFailure) {
        Get.snackbar("Error", state.message,
            backgroundColor: Colors.redAccent,
            margin: EdgeInsets.only(bottom: 15),
            snackPosition: SnackPosition.BOTTOM);
      }
    });
  }

  @override
  void deleteItems() async {
    var selectedItemIds = <String>[];
    for (var item in dataList.cast<Quote>()) {
      if (item.selected) selectedItemIds.add(item.id!);
    }

    if (dataList.isNotEmpty) {
      _quoteStateStream.value = DeleteQuotesProcessing();
      var res = await _homeRepository.deleteQuotes(QueryModel(
        ids: selectedItemIds,
      ));
      if (res.status != ApiStatus.Ok) {
        _quoteStateStream.value = DeleteQuotesFailure(
            message: res.message ?? "Something went wrong, please try again",
            status: res.status);
        return;
      }
      dataList.removeWhere((element) => element.selected);
      totalRows = dataList.length;
      _quoteStateStream.value = DeleteQuotesSuccess();
    }
  }
}

class AddNewQuoteController extends GetxController {
  AddNewQuoteController({required homeRepository})
      : _homeRepository = homeRepository;
  final IHomeRepository _homeRepository;
  final _stateStream = AddQuoteState().obs;

  AddQuoteState get state => _stateStream.value;
  final quoteController = TextEditingController();
  final authorController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    ever(_stateStream, (state) {
      if (state is AddQuoteSuccess) {
        Get.back();

        var gController = Get.find<QuoteController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void addNewItem() async {
    var data = Quote(
      quote: quoteController.text,
      author: authorController.text
    );

    _stateStream.value = AddQuoteLoading();
    var res = await _homeRepository.createQuote(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = AddQuoteFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = AddQuoteSuccess();
  }
}

class EditQuoteController extends GetxController {
  EditQuoteController({required homeRepository})
      : _homeRepository = homeRepository;
  final IHomeRepository _homeRepository;
  final _stateStream = EditQuoteState().obs;
  final _itemDetail = Quote().obs;

  Quote? get itemDetail => _itemDetail.value;

  set itemDetail(value) {
    _itemDetail.value = value;
  }

  EditQuoteState get state => _stateStream.value;

  //fields
  final quoteController = TextEditingController();
  final authorController = TextEditingController();
  void changeEditItem(Quote? data) {
    if (data != null) {
      quoteController.text = data.quote!;
      authorController.text = data.author!;

      itemDetail = data;
    }
  }

  @override
  void onInit() {
    super.onInit();
    itemDetail = null;

    ever(_stateStream, (state) {
      if (state is EditQuoteSuccess) {
        Get.back();

        var gController = Get.find<QuoteController>();
        gController.fetchListItems(QueryModel(
            offset: 0,
            limit: gController.rowsPerPage,
            total: true,
            reverse: true));
      }
    });
  }

  void editItem() async {
    var data = Quote(
      id: itemDetail!.id,
      quote: quoteController.text,
      author: authorController.text,
    );

    _stateStream.value = EditQuoteLoading();
    var res = await _homeRepository.updateQuote(data);
    if (res.status != ApiStatus.Ok) {
      _stateStream.value = EditQuoteFailure(
          message: res.message ?? "Something went wrong, please try again");
      return;
    }
    _stateStream.value = EditQuoteSuccess();
  }
}