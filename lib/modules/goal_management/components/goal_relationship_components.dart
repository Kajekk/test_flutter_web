import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';

class GoalRelationshipItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditGoalRelationshipController controller = Get.find();
    return Obx(() {
      if (controller.itemDetail == null) {
        return Center(
          child: Text(
            "Select 1 row to view detail",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Email (Assignee): \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.email),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Goal: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.goal!.name),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Created By (Assigner): \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.createdBy),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Created time: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(
                text: DateFormat.yMd()
                    .add_jm()
                    .format(controller.itemDetail!.createdTime!.toLocal())),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Last updated time: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(
                text: DateFormat.yMd()
                    .add_jm()
                    .format(controller.itemDetail!.lastUpdatedTime!.toLocal())),
          ])),
        ],
      );
    });
  }
}

// class GoalRelationshipDialog extends StatelessWidget {
//   final AddNewGoalFrequencyController controller = Get.find();
//   final GlobalKey<FormState> _key = GlobalKey<FormState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Dialog(
//         shape:
//         RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         child: dialogContent(context),
//       ),
//     );
//   }
//
//   void _submitForm() {
//     if (_key.currentState!.validate()) {
//       // _key.currentState!.save();
//       controller.addNewItem();
//     }
//   }
//
//   Widget dialogContent(BuildContext context) {
//     return Obx(() {
//       return Container(
//         margin: EdgeInsets.only(left: 0.0, right: 0.0),
//         child: Stack(
//           children: <Widget>[
//             Container(
//               width: 400,
//               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
//               margin: EdgeInsets.only(top: 13.0, right: 8.0),
//               decoration: BoxDecoration(
//                   color: Color(0xFF242430),
//                   shape: BoxShape.rectangle,
//                   borderRadius: BorderRadius.circular(16.0),
//                   boxShadow: <BoxShadow>[
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 0.0,
//                       offset: Offset(0.0, 0.0),
//                     ),
//                   ]),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Text(
//                     'Add new item',
//                     style: Theme.of(context).textTheme.subtitle1,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Form(
//                     key: _key,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ...frequencyField(),
//                         ...daysEquivalentField(),
//                         Align(
//                           alignment: Alignment.center,
//                           child: ElevatedButton(
//                             onPressed: () {
//                               _submitForm();
//                             },
//                             child: Text('Submit'),
//                             style: ButtonStyle(
//                               padding: MaterialStateProperty.all<EdgeInsets>(
//                                   EdgeInsets.symmetric(
//                                       horizontal: defaultPadding,
//                                       vertical: defaultPadding / 1.5)),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.deepPurpleAccent),
//                             ),
//                           ),
//                         ),
//                         if (controller.state is AddGoalFailure)
//                           Padding(
//                             padding: EdgeInsets.only(top: defaultPadding / 2),
//                             child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   (controller.state as AddGoalFailure)
//                                       .message,
//                                   style: TextStyle(color: Get.theme.errorColor),
//                                 )),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 0.0,
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: CircleAvatar(
//                     radius: 14.0,
//                     backgroundColor: Colors.white,
//                     child: Icon(Icons.close, color: Colors.red),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   List<Widget> frequencyField() {
//     return <Widget>[
//       TextFormField(
//         style: TextStyle(
//           color: Color(0xFF999999),
//         ),
//         decoration: InputDecoration(
//           labelText: 'Frequency',
//           labelStyle:
//           TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
//           // filled: true,
//           // isDense: true,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Colors.redAccent),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Colors.redAccent),
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         cursorColor: Color(0xFF999999),
//         keyboardType: TextInputType.text,
//         controller: controller.frequencyController,
//         validator: (val) {
//           if (val == "") {
//             return 'Frequency is required';
//           }
//           return null;
//         },
//       ),
//       SizedBox(
//         height: defaultPadding,
//       ),
//     ];
//   }
//
//   List<Widget> daysEquivalentField() {
//     return <Widget>[
//       TextFormField(
//         style: TextStyle(
//           color: Color(0xFF999999),
//         ),
//         decoration: InputDecoration(
//           labelText: 'Days Equivalent Frequency',
//           labelStyle:
//           TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
//           // filled: true,
//           // isDense: true,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Colors.redAccent),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 2, color: Colors.redAccent),
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//         cursorColor: Color(0xFF999999),
//         keyboardType: TextInputType.text,
//         controller: controller.dayEquivalentController,
//         validator: (val) {
//           if (val == null || val == "") {
//             return 'Days Equivalent Frequency is required';
//           }
//           var value = int.tryParse(val);
//           if (value == null) return 'Invalid input';
//           return null;
//         },
//       ),
//       SizedBox(
//         height: defaultPadding,
//       ),
//     ];
//   }
// }
