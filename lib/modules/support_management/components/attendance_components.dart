import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/support_management/controllers/barrel.dart';

class AttendanceItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditAttendanceController controller = Get.find();
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
                text: "Uid: \n", style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.uid),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Email: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.email),
          ])),
          if (controller.itemDetail!.isCheckedIn == true)
            SizedBox(
              height: defaultPadding / 2,
            ),
          if (controller.itemDetail!.isCheckedIn == true)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Checked in: \n",
                  style: Theme.of(context).textTheme.subtitle1),
              TextSpan(
                  text: DateFormat.yMd()
                      .add_jm()
                      .format(controller.itemDetail!.createdTime!.toLocal())),
            ])),
          if (controller.itemDetail!.isCheckedIn == true)
            SizedBox(
              height: defaultPadding / 2,
            ),
          if (controller.itemDetail!.isCheckedIn == true)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Checked in far: \n",
                  style: Theme.of(context).textTheme.subtitle1),
              TextSpan(text: controller.itemDetail!.isCheckInFar.toString()),
            ])),
          if (controller.itemDetail!.isCheckedOut == true)
            SizedBox(
              height: defaultPadding / 2,
            ),
          if (controller.itemDetail!.isCheckedOut == true)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Checked out: \n",
                  style: Theme.of(context).textTheme.subtitle1),
              TextSpan(
                  text: DateFormat.yMd().add_jm().format(
                      controller.itemDetail!.lastUpdatedTime!.toLocal())),
            ])),
          if (controller.itemDetail!.isCheckedOut == true)
            SizedBox(
              height: defaultPadding / 2,
            ),
          if (controller.itemDetail!.isCheckedOut == true)
            Text.rich(TextSpan(children: [
              TextSpan(
                  text: "Checked out far: \n",
                  style: Theme.of(context).textTheme.subtitle1),
              TextSpan(text: controller.itemDetail!.isCheckOutFar.toString()),
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

class AttendanceDialog extends StatelessWidget {
  final AddNewAttendanceController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

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
              width: 400,
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
                        ...checkInField(),
                        ...checkOutField(),
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
                                      horizontal: defaultPadding * 2,
                                      vertical: defaultPadding)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
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
          if (val == null || val == "") {
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

  List<Widget> checkInField() {
    return <Widget>[
      Text('Check in', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.checkInDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.checkInTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2,),
      Row(
        children: [
          Text('Checked in far', style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: controller.checkedInFar.value,
            onChanged: (newValue) {
              if (newValue != null) controller.checkedInFar.value = newValue;
            },
            splashRadius: 0,
            activeColor: Colors.deepPurpleAccent,
          ),
        ],
      ),
      SizedBox(height: defaultPadding,),
    ];
  }

  List<Widget> checkOutField() {
    return <Widget>[
      Text('Check out', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.checkOutDateController,
                labelText: 'Date',
                isRequireValidate: false,
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.checkOutTimeController,
              labelText: 'Time',
              isRequireValidate: false,
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2,),
      Row(
        children: [
          Text('Checked out far', style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: controller.checkedOutFar.value,
            onChanged: (newValue) {
              if (newValue != null) controller.checkedOutFar.value = newValue;
            },
            splashRadius: 0,
            activeColor: Colors.deepPurpleAccent,
          )
        ],
      ),
      SizedBox(height: defaultPadding,),
    ];
  }
}

class EditAttendanceDialog extends StatelessWidget {
  final EditAttendanceController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  void _submitForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

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
              width: 400,
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
                        ...checkInField(),
                        ...checkOutField(),
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
                                      horizontal: defaultPadding * 2,
                                      vertical: defaultPadding)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
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
          if (val == null || val == "") {
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

  List<Widget> checkInField() {
    return <Widget>[
      Text('Check in', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.checkInDateController,
                labelText: 'Date',
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.checkInTimeController,
              labelText: 'Time',
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2,),
      Row(
        children: [
          Text('Checked in far', style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: controller.checkedInFar.value,
            onChanged: (newValue) {
              if (newValue != null) controller.checkedInFar.value = newValue;
            },
            splashRadius: 0,
            activeColor: Colors.deepPurpleAccent,
          ),
        ],
      ),
      SizedBox(height: defaultPadding,),
    ];
  }

  List<Widget> checkOutField() {
    return <Widget>[
      Text('Check out', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      Row(
        children: [
          Expanded(
              flex: 2,
              child: DatePickerField(
                controller: controller.checkOutDateController,
                labelText: 'Date',
                isRequireValidate: false,
              )),
          SizedBox(width: defaultPadding / 2,),
          Expanded(
            child: TimePickerField(
              controller: controller.checkOutTimeController,
              labelText: 'Time',
              isRequireValidate: false,
            ),
          )
        ],
      ),
      SizedBox(height: defaultPadding / 2,),
      Row(
        children: [
          Text('Checked out far', style: TextStyle(fontWeight: FontWeight.bold)),
          Checkbox(
            value: controller.checkedOutFar.value,
            onChanged: (newValue) {
              if (newValue != null) controller.checkedOutFar.value = newValue;
            },
            splashRadius: 0,
            activeColor: Colors.deepPurpleAccent,
          )
        ],
      ),
      SizedBox(height: defaultPadding,),
    ];
  }
}

