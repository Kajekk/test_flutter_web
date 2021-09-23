import 'package:test_flutter_web/global_widgets/barrel.dart';

import 'barrel.dart';

class SubTabInfo {
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
        "Workplace",
        "Working Hours",
        "Working Days",
        "Created Time"
      ]);
  static const SubTabInfoModel workplaceDetail = SubTabInfoModel(
      title: "Workplace Detail",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Address",
        "Latitude",
        "Longitude"
      ]);

  static const SubTabInfoModel checkInOut = SubTabInfoModel(
      title: "Check in/out",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Checked in",
        "Checked out",
      ]);

  static const SubTabInfoModel goal = SubTabInfoModel(
      title: "Goal",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Frequency",
        "Description",
        "Nature",
        "Created Time"
      ]);

  static const SubTabInfoModel goalFrequency = SubTabInfoModel(
      title: "Goal Frequency",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Frequency",
        "Days Equivalent Frequency",
        "Created Time"
      ]);

  static const SubTabInfoModel goalRelationship = SubTabInfoModel(
      title: "Goal Relationship",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Goal",
        "Created By",
        "Created Time",
      ]);
}
