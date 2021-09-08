import 'package:test_flutter_web/global_widgets/barrel.dart';

import 'barrel.dart';

class CategoryListData {
  // static const String entityType = 'Entity Type';
  // static const List<String> entityTypeDataCol = [
  //   "Organization 1",
  //   "Type 1",
  //   "Role 1",
  //   "Account Name 1",
  // ];
  static const CategoryModel entityType = CategoryModel(
      title: "Entity Type",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization 1",
        "Type 1",
        "Role 1",
        "Account Name 1",
      ]);

  static const CategoryModel userPermissions = CategoryModel(
      title: "User Permissions",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization 2",
        "Type 2",
        "Role 2",
        "Account Name 2",
      ]);

  static const CategoryModel userRoles = CategoryModel(
      title: "User Roles",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization 3",
        "Type 3",
        "Role 3",
        "Account Name 3",
      ]);
}
