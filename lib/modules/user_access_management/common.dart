import 'package:test_flutter_web/global_widgets/category_info_card.dart';
import 'package:test_flutter_web/routes/app_pages.dart';

// List<CategoryCardModel> categoryData = [
//   CategoryCardModel(
//       title: "Entity Type",
//       svgSource: "assets/icons/menu_dashboard.svg",
//       dataColumn: [
//         "Organization 1",
//         "Type 1",
//         "Role 1",
//         "Account Name 1",
//       ]),
//   CategoryCardModel(
//       title: "User Permissions",
//       svgSource: "assets/icons/menu_dashboard.svg",
//       dataColumn: [
//         "Organization 2",
//         "Type 2",
//         "Role 2",
//         "Account Name 2",
//       ]),
//   CategoryCardModel(
//       title: "User Roles",
//       svgSource: "assets/icons/menu_dashboard.svg",
//       dataColumn: [
//         "Organization 3",
//         "Type 3",
//         "Role 3 ",
//         "Account Name 3",
//       ]),
  // CategoryCardModel(
  //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
  // CategoryCardModel(
  //     title: "Account", svgSource: "assets/icons/menu_dashboard.svg"),
// ];

Map<String, Map<String, dynamic>> categoryMap = {
  "Entity Type": {
    "dataColumn": [
      "Organization 1",
      "Type 1",
      "Role 1 ",
      "Account Name 1",
    ],
    "title": "Entity Type",
    "svgSource": "assets/icons/menu_dashboard.svg",
  },
  "User Permissions": {
    "dataColumn": [
      "Organization 2",
      "Type 2",
      "Role 2 ",
      "Account Name 2",
    ],
    "title": "User Permissions",
    "svgSource": "assets/icons/menu_dashboard.svg",
  },
  "User Roles": {
    "dataColumn": [
      "Organization 3",
      "Type 3",
      "Role 3 ",
      "Account Name 3",
    ],
    "title": "User Roles",
    "svgSource": "assets/icons/menu_dashboard.svg",
  }
};
