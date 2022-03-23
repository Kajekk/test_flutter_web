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

  static const SubTabInfoModel emotionType = SubTabInfoModel(
      title: "Emotion Type",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Type",
        "Group",
        "Is Enabled"
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

  static const SubTabInfoModel proWorkSchedule = SubTabInfoModel(
      title: "Pro Schedule",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Employment Email",
      ]);

  static const SubTabInfoModel contactForm = SubTabInfoModel(
      title: "Contact Form",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Email",
        "Phone",
      ]);

  static const SubTabInfoModel checkInOut = SubTabInfoModel(
      title: "Check in/out",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Checked in",
        "Checked out",
      ]);

  static const SubTabInfoModel supportMetric = SubTabInfoModel(
      title: "Support Metrics",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Description",
        "Target",
      ]);

  static const SubTabInfoModel supportLog = SubTabInfoModel(
      title: "Support Log",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Type",
        "For Email",
        "Start At",
        "End At",
        "Created Time",
      ]);

  static const SubTabInfoModel locationTracking = SubTabInfoModel(
      title: "Location Tracking",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Latitude",
        "Longitude",
        "Created Time",
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

  static const SubTabInfoModel goalTracking = SubTabInfoModel(
      title: "Goal Tracking",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Email",
        "Goal",
        "Created By",
        "Status",
        "Start Date",
        "End Date",
      ]);

  static const SubTabInfoModel quotes = SubTabInfoModel(
      title: "Quotes",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Quote",
        "Author",
        "Created Time"
      ]);

  static const SubTabInfoModel account = SubTabInfoModel(
      title: "Account",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organization",
        "Type",
        "Role",
        "Name",
        "Email",
      ]);

  static const SubTabInfoModel permission = SubTabInfoModel(
      title: "Permission",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Description",
        "Action",
        "Resource",
      ]);

  static const SubTabInfoModel permissionModule = SubTabInfoModel(
      title: "Permission Module",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
      ]);

  static const SubTabInfoModel role = SubTabInfoModel(
      title: "Role",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organisation",
        "Role",
        "Description",
        "Permissions",
      ]);

  static const SubTabInfoModel organisation = SubTabInfoModel(
      title: "Organisation",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Code",
        "Name",
        "Permissions",
      ]);

  static const SubTabInfoModel communityTopic = SubTabInfoModel(
      title: "Community Topic",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Organisation",
        "Topic",
        "Start Date",
        "End Date",
      ]);

  static const SubTabInfoModel agreement = SubTabInfoModel(
      title: "Agreement",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Description",
      ]);

  static const SubTabInfoModel policy = SubTabInfoModel(
      title: "Policy",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Description",
      ]);

  static const SubTabInfoModel inclusiveEmployment = SubTabInfoModel(
      title: "Inclusive Employment",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Email",
        "Number",
        "Created Time"
      ]);

  static const SubTabInfoModel contactUs = SubTabInfoModel(
      title: "Contact Us",
      svgSource: "assets/icons/menu_dashboard.svg",
      dataColumn: [
        "Name",
        "Email",
        "Number",
        "Message",
        "Created Time"
      ]);
}
