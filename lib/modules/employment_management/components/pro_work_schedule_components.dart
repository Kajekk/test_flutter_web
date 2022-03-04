import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

class ProWorkItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditProScheduleController controller = Get.find();
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
                text: "Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.email),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Employment Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.employmentEmail),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Working Days: ", style: Theme.of(context).textTheme.subtitle1),
              ...?controller.itemDetail!.workingDays?.map((e) {
                var workingTimeFrom =
                  toTimeString(context, e.workingTimeFrom!);
                var workingTimeTo =
                  toTimeString(context, e.workingTimeTo!);

                  return Text("- ${getWeekDayString(e.weekday)}: $workingTimeFrom - $workingTimeTo");
              }).toList(),
            ],
          ),
        ],
      );
    });
  }
}

class AddProWorkDialog extends StatelessWidget {
  final AddNewProScheduleController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      controller.addNewItem();
    }
  }

  Widget dialogContent(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 650,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Color(0xFF242430),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Add new item',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...emailField(),
                        ...employmentEmailField(),
                        ...workingDaysField(context),

                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: () {
                              _submitForm();
                            },
                            child: Text('Submit'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding / 1.5)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
                        ),
                        if (controller.state is AddProWorkScheduleFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddProWorkScheduleFailure)
                                      .message,
                                  style: TextStyle(color: Get.theme.errorColor),
                                )),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.emailController,
        validator: (val) {
          if (val == "") {
            return 'Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> employmentEmailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Employment Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.employmentEmailController,
        validator: (val) {
          if (val == "") {
            return 'Employment Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> workingDaysField(BuildContext context) {
    return <Widget>[
      Text(
        'Working Days',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<int>.generate(7, (i) => i++).map((i) {
          return Expanded(
              child: RawMaterialButton(
                fillColor: controller.workingDays.any((element) => element.weekday == i)
                    ? Colors.deepPurpleAccent
                    : null,
                shape: CircleBorder(
                    side: BorderSide(
                        color: controller.workingDays.any((element) => element.weekday == i)
                            ? Colors.white54
                            : Color(0xFF999999),
                        width: 2.0)),
                onPressed: () {
                  if (controller.workingDays.any((element) => element.weekday == i)) {
                    controller.workingDays.removeWhere((element) => element.weekday == i);
                  } else {
                    controller.workingDays.add(WorkingDay(
                      weekday: i,
                    ));
                    controller.workingTimeStartControllers.add(TextEditingController());
                    controller.workingTimeEndControllers.add(TextEditingController());
                    controller.workingDays.sort((a, b) => a.weekday!.compareTo(b.weekday!));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    getWeekDayString(i),
                    style: TextStyle(
                        fontSize: 12,
                        color: controller.workingDays.any((element) => element.weekday == i)
                            ? Colors.white54
                            : null,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ));
        }).toList(),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Column(
        children: controller.workingDays.asMap().entries.map((e) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getWeekDayString(e.value.weekday)),
              SizedBox(
                height: defaultPadding / 2,
              ),
              Row(
                children: [
                  Expanded(
                      child: TimePickerField(
                        controller: controller.workingTimeStartControllers[e.value.weekday!],
                        labelText: 'Start',
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '-',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Expanded(
                      child: TimePickerField(
                        controller: controller.workingTimeEndControllers[e.value.weekday!],
                        labelText: 'End',
                      )),
                ],
              ),
              SizedBox(
                height: defaultPadding / 2,
              ),
            ],
          );
        }).toList(),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
}

class EditProWorkDialog extends StatelessWidget {
  final EditProScheduleController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      controller.editItem();
    }
  }

  Widget dialogContent(BuildContext context) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0),
        child: Stack(
          children: <Widget>[
            Container(
              width: 650,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              margin: EdgeInsets.only(top: 13.0, right: 8.0),
              decoration: BoxDecoration(
                  color: Color(0xFF242430),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Update item',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...emailField(),
                        ...employmentEmailField(),
                        ...workingDaysField(context),

                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text('Submit'),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          horizontal: defaultPadding,
                                          vertical: defaultPadding / 1.5)),
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.deepPurpleAccent))
                          ),
                        ),
                        if (controller.state is EditProWorkScheduleFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as EditProWorkScheduleFailure)
                                      .message,
                                  style: TextStyle(color: Get.theme.errorColor),
                                )),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  controller.clearEdit();
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.close, color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.emailController,
        validator: (val) {
          if (val == "") {
            return 'Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> employmentEmailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Employment Email',
          labelStyle:
          TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          // filled: true,
          // isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: Colors.redAccent),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        cursorColor: Color(0xFF999999),
        keyboardType: TextInputType.text,
        controller: controller.employmentEmailController,
        validator: (val) {
          if (val == "") {
            return 'Employment Email is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
  List<Widget> workingDaysField(BuildContext context) {
    return <Widget>[
      Text(
        'Working Days',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<int>.generate(7, (i) => i++).map((i) {
          return Expanded(
              child: RawMaterialButton(
                fillColor: controller.workingDays.any((element) => element.weekday == i)
                    ? Colors.deepPurpleAccent
                    : null,
                shape: CircleBorder(
                    side: BorderSide(
                        color: controller.workingDays.any((element) => element.weekday == i)
                            ? Colors.white54
                            : Color(0xFF999999),
                        width: 2.0)),
                onPressed: () {
                  if (controller.workingDays.any((element) => element.weekday == i)) {
                    controller.workingDays.removeWhere((element) => element.weekday == i);
                  } else {
                    controller.workingDays.add(WorkingDay(
                      weekday: i,
                    ));
                    controller.workingTimeStartControllers.add(TextEditingController());
                    controller.workingTimeEndControllers.add(TextEditingController());
                    controller.workingDays.sort((a, b) => a.weekday!.compareTo(b.weekday!));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    getWeekDayString(i),
                    style: TextStyle(
                        fontSize: 12,
                        color: controller.workingDays.any((element) => element.weekday == i)
                            ? Colors.white54
                            : null,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ));
        }).toList(),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Column(
        children: controller.workingDays.asMap().entries.map((e) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(getWeekDayString(e.value.weekday)),
              SizedBox(
                height: defaultPadding / 2,
              ),
              Row(
                children: [
                  Expanded(
                      child: TimePickerField(
                        controller: controller.workingTimeStartControllers[e.value.weekday!],
                        labelText: 'Start',
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '-',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Expanded(
                      child: TimePickerField(
                        controller: controller.workingTimeEndControllers[e.value.weekday!],
                        labelText: 'End',
                      )),
                ],
              ),
              SizedBox(
                height: defaultPadding / 2,
              ),
            ],
          );
        }).toList(),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }
}