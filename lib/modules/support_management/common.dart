import 'package:test_flutter_web/global_widgets/category_info_card.dart';
import 'package:test_flutter_web/routes/app_pages.dart';

// List<CategoryCardModel> categoryData = [
//   CategoryCardModel(
//       title: "ASDASD", svgSource: "assets/icons/menu_dashboard.svg", route: Routes.ENTITY_TYPE),
//   CategoryCardModel(
//       title: "QWEQWEQWEQWE",
//       svgSource: "assets/icons/menu_dashboard.svg", route: Routes.USER_PERMISSIONS),
//   CategoryCardModel(
//       title: "123123123213", svgSource: "assets/icons/menu_dashboard.svg", route: Routes.USER_ROLES),
  // CategoryCardModel(
  //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
  // CategoryCardModel(
  //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
// ];

Map<String, Map<String, dynamic>> categoryMap = {
  "ASDASD": {
    "dataColumn": [
      "ASDASD 1",
      "Type 1",
      "Role 1 ",
      "Account Name 1",
    ],
    "title": "ASDASD",
  },
  "QWEQWEQWEQWE": {
    "dataColumn": [
      "QWEQWEQWEQWE 2",
      "Type 2",
      "Role 2 ",
      "Account Name 2",
    ],
    "title": "QWEQWEQWEQWE",
  },
  "123123123213": {
    "dataColumn": [
      "123123123213 3",
      "Type 3",
      "Role 3 ",
      "Account Name 3",
    ],
    "title": "123123123213",
  }
};