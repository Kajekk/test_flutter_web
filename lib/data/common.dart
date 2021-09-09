import 'package:test_flutter_web/global_widgets/barrel.dart';

import 'barrel.dart';

class SubTabInfo {
  // static const String entityType = 'Entity Type';
  // static const List<String> entityTypeDataCol = [
  //   "Organization 1",
  //   "Type 1",
  //   "Role 1",
  //   "Account Name 1",
  // ];
  static const SubTabInfoModel entityType = SubTabInfoModel(
      title: "Entity Type",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Uid",
        "Email",
        "Type",
        "Description",
        "Created Time"
      ]);

  static const SubTabInfoModel userPermissions = SubTabInfoModel(
      title: "User Permissions",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization 2",
        "Type 2",
        "Role 2",
        "Account Name 2",
      ]);

  static const SubTabInfoModel userRoles = SubTabInfoModel(
      title: "User Roles",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization 3",
        "Type 3",
        "Role 3",
        "Account Name 3",
      ]);

  static const SubTabInfoModel emotionalLog = SubTabInfoModel(
      title: "Emotional Log",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Type",
        "Description",
        "Created Time"
      ]);

  static const SubTabInfoModel employmentDetail = SubTabInfoModel(
      title: "Employment Detail",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Working Hours",
        "Working Days",
        "Created Time"
      ]);

  static const SubTabInfoModel checkInOut = SubTabInfoModel(
      title: "Check in/out",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Checked in",
        "Checked out",
      ]);
}
