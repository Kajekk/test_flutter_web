import 'package:get/get.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/categoryModel.dart';

import '../category_info_card.dart';

class CategoryController extends GetxController {
  CategoryController({required this.mapCategoryCard});

  final _route = ''.obs;
  final _currentCategory = ''.obs;
  final _dataColumn = <String>[].obs;
  // final listCategoryCard;
  final Map<String, Map<String, dynamic>> mapCategoryCard;

  String get route => _route.value;
  String get currentCategory => _currentCategory.value;
  List<String> get dataColumn => _dataColumn;

  @override
  void onInit() {
    // var curCategory = (listCategoryCard as List<CategoryCardModel>)[0];
    // _currentCategory.value = curCategory.title!;
    // _dataColumn.value = curCategory.dataColumn!;
    _currentCategory.value = mapCategoryCard.values.elementAt(0)["title"];
    _dataColumn.value = mapCategoryCard.values.elementAt(0)["dataColumn"];
    super.onInit();
  }

  void changeCategory(val) {
    _currentCategory.value = val;
    _dataColumn.value = mapCategoryCard[val]!["dataColumn"];

    //fetch
    mapCategoryCard[val]!["fetchData"]();
  }
}

abstract class SubTabController extends GetxController {
  final _isCurrent = false.obs;
  final _itemPerPage = 10.obs;
  CategoryModel categoryModel = CategoryModel();

  bool get isCurrent => _isCurrent.value;

  set isCurrent(value) {
    _isCurrent.value = value;
  }

  int get itemPerPage => _itemPerPage.value;

  set itemPerPage(value) {
    _itemPerPage.value = value;
  }

  void fetchListItems(int offset, limit);
  void countItems();
  void changeSubTab();
}

class SubTabItem {
  final String? title;
  final String? svgSource;
  SubTabItem({this.title, this.svgSource});
}