import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/global_widgets/controllers/barrel.dart';

// class GoalManagementPage extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final EmotionalLogController emoController = Get.find();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: SideMenu(),
//       body: Container(
//         // constraints: BoxConstraints(maxWidth: maxWidth),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (Responsive.isDesktop(context))
//               Expanded(
//                 child: SideMenu(),
//               ),
//             Expanded(
//                 flex: 5,
//                 child: SafeArea(
//                     child: SingleChildScrollView(
//                       padding: EdgeInsets.all(defaultPadding),
//                       child: Column(
//                         children: [
//                           Header(
//                             scaffoldKey: _scaffoldKey,
//                             title: 'Emotional Management',
//                           ),
//                           SizedBox(
//                             height: defaultPadding,
//                           ),
//                           SubTabs(
//                             listController: [emoController],
//                           ),
//                           SizedBox(
//                             height: defaultPadding,
//                           ),
//                           Obx(() {
//                             return Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                     flex: 5,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                       children: [
//                                         buildListItem([
//                                           emoController,
//                                           // controller2,
//                                           // controller3
//                                         ]),
//                                         if (Responsive.isMobile(context))
//                                           SizedBox(
//                                             height: defaultPadding,
//                                           ),
//                                         if (Responsive.isMobile(context))
//                                           buildItemDetail([emoController])
//                                       ],
//                                     )),
//                                 if (!Responsive.isMobile(context))
//                                   SizedBox(
//                                     width: defaultPadding,
//                                   ),
//                                 if (!Responsive.isMobile(context))
//                                   Expanded(
//                                       flex: 2,
//                                       child: buildItemDetail([emoController])
//                                   )
//                               ],
//                             );
//                           }),
//                         ],
//                       ),
//                     )))
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildListItem(List<SubTabController> listController) {
//     for (var controller in listController) {
//       if (controller.isCurrent &&
//           controller.subTabInfoModel.title == SubTabInfo.emotionalLog.title) {
//         var state = emoController.emotionalLogState;
//         if (state is EmotionalLogLoaded) {
//           return ListItem(
//             controller: controller,
//             dataTableSource: EmotionalLogData(controller: emoController),
//             customDialog: EmotionalLogDialog(),
//           );
//         }
//         if (state is EmotionalLogLoading) {
//           return ListItem(
//             controller: controller,
//             dataTableSource: LoadingDataSource(numCol: emoController.info.dataColumn!.length),
//             isLoading: true,
//           );
//         }
//       }
//       // if (controller.isCurrent &&
//       //     controller.subTabInfoModel.title ==
//       //         SubTabInfo.userPermissions.title) {
//       //   return ListItem(controller: controller, dataTableSource: MyData());
//       // }
//       // if (controller.isCurrent &&
//       //     controller.subTabInfoModel.title == SubTabInfo.userRoles.title) {
//       //   return ListItem(controller: controller, dataTableSource: MyData());
//       // }
//     }
//     return Container();
//   }
//
//   Widget buildItemDetail(List<SubTabController> listController) {
//     for (var controller in listController) {
//       if (controller.isCurrent &&
//           controller.subTabInfoModel.title == SubTabInfo.emotionalLog.title) {
//         var editController = Get.find<EditEmotionalLogController>();
//         return ItemDetail(
//           itemDetailInfo: EmotionalLogItemDetailInfo(),
//           customDialog: editController.itemDetail == null ? null : EditEmotionalLogDialog(),
//         );
//       }
//     }
//     return Container();
//   }
// }