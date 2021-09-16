import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/controllers/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

class EmploymentItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditEmploymentController controller = Get.find();
    WorkplaceDetailController wpController = Get.find();
    return Obx(() {
      if (controller.itemDetail == null) {
        return Center(
          child: Text(
            "Select 1 row to view detail",
            style: Theme.of(context).textTheme.bodyText2,
          ),
        );
      }

      var startingTime =
          toTimeString(context, controller.itemDetail!.workingTimeFrom!);
      var finishingTime =
          toTimeString(context, controller.itemDetail!.workingTimeTo!);
      var lunchTimeFrom =
          toTimeString(context, controller.itemDetail!.lunchTimeFrom!);
      var lunchTimeTo =
          toTimeString(context, controller.itemDetail!.lunchTimeTo!);
      var workingDays = "";
      if (controller.itemDetail!.workingDays!.length != 0) {
        for (var day in controller.itemDetail!.workingDays!) {
          if (day == 0) continue;
          workingDays += getWeekDayString(day);
          if (day != controller.itemDetail!.workingDays!.last)
            workingDays += ", ";
        }
        if (controller.itemDetail!.workingDays!.first == 0)
          workingDays += ", " +
              getWeekDayString(controller.itemDetail!.workingDays!.first);
      }
      var timeToWork = controller.itemDetail!.timeToWork.toString();
      if (controller.itemDetail!.timeToWork == 0) timeToWork = "WFH";

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
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Workplace: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.workplaceName),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Working hours: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: startingTime + " - " + finishingTime),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Lunch Time: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: lunchTimeFrom + " - " + lunchTimeTo),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Travel time to work (minutes): \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: timeToWork),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Working days: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: workingDays),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Job Scope: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...controller.itemDetail!.scopeList!.map((e) {
              return TextSpan(children: [
                TextSpan(text: e.name! + "\n"),
                for (var task in e.task!) TextSpan(text: "- " + task + "\n")
              ]);
            }).toList(),
          ])),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Coaches: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...controller.itemDetail!.coachList!.map((e) {
              return TextSpan(text: e.name! + " - " + e.type! + "\n");
            }).toList(),
          ])),
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

class EmploymentDetailDialog extends StatelessWidget {
  final AddNewEmploymentController controller = Get.find();
  final WorkplaceDetailController wpController = Get.find();
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
      // _key.currentState!.save();
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
                        ...workplaceDetailField(),
                        ...workingHoursField(context),
                        ...lunchTimeField(context),
                        ...workingDaysField(),
                        ...timeToWorkField(),
                        ...jobScopeField(),
                        ...coachListField(),
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
                        if (controller.state is AddEmploymentFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddEmploymentFailure)
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
        keyboardType: TextInputType.emailAddress,
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

  List<Widget> workingHoursField(BuildContext context) {
    return <Widget>[
      Text(
        'Working Hours',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TimePickerField(
            controller: controller.workingTimeStartController,
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
            controller: controller.workingTimeEndController,
            labelText: 'End',
          )),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> lunchTimeField(BuildContext context) {
    return <Widget>[
      Text(
        'Lunch Time',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TimePickerField(
            controller: controller.lunchTimeStartController,
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
            controller: controller.lunchTimeEndController,
            labelText: 'End',
          )),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> workplaceDetailField() {
    var workplaceList = <WorkplaceDetail>[];
    if (wpController.state is WorkplaceDetailLoaded) {
      workplaceList =
          (wpController.state as WorkplaceDetailLoaded).listData ?? [];
    }
    return <Widget>[
      DropdownButtonFormField(
        items: workplaceList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        // value: controller.workplaceId.value,
        onChanged: (String? newValue) {
          controller.workplaceId.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Workplace',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> workingDaysField() {
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
        children: [
          for (var i = 0; i < 7; i++)
            Expanded(
                child: RawMaterialButton(
              fillColor: controller.workingDays.contains(i)
                  ? Colors.deepPurpleAccent
                  : null,
              shape: CircleBorder(
                  side: BorderSide(
                      color: controller.workingDays.contains(i)
                          ? Colors.white54
                          : Color(0xFF999999),
                      width: 2.0)),
              onPressed: () {
                if (controller.workingDays.contains(i))
                  controller.workingDays.remove(i);
                else {
                  controller.workingDays.add(i);
                  controller.workingDays.sort();
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  getWeekDayString(i),
                  style: TextStyle(
                      fontSize: 12,
                      color: controller.workingDays.contains(i)
                          ? Colors.white54
                          : null,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ))
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> timeToWorkField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Travel time to work (minutes)',
          labelStyle:
              TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          hintText: 'e.g 0 = WFH',
          hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
        keyboardType: TextInputType.number,
        controller: controller.travelTimeController,
        validator: (val) {
          if (val == "") {
            return 'Travel time is required';
          }
          var value = int.tryParse(val!);
          if (value == null || value < 0) return 'Invalid travel time';
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> jobScopeField() {
    return <Widget>[
      Text('Job Scope', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.scopeList.asMap().entries.map((e) {
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Scope name',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
                hintText: 'e.g Safety Management Floor Officer',
                hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
              onChanged: (String? newVal) {
                controller.scopeList[e.key] =
                    controller.scopeList[e.key].copyWith(
                  name: newVal,
                );
              },
              validator: (val) {
                if (val == "") {
                  return 'Scope name is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Tasks (Make new line if there are multiple tasks)',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              onChanged: (String? newVal) {
                if (newVal != null) {
                  LineSplitter ls = LineSplitter();
                  List<String> tasks = ls.convert(newVal);
                  controller.scopeList[e.key] =
                      controller.scopeList[e.key].copyWith(task: tasks);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Scope tasks is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.scopeList.add(Scope());
              },
              icon: Icon(Icons.add),
              label: Text("Add New Scope"),
            ),
          ),
          if (controller.scopeList.length > 0)
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                ),
                onPressed: () {
                  controller.scopeList.removeLast();
                },
                icon: Icon(Icons.remove),
                label: Text("Remove Scope"),
              ),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> coachListField() {
    return <Widget>[
      Text('Coaches', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(
        height: defaultPadding / 2,
      ),
      ...controller.coachList.asMap().entries.map((e) {
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Coach email',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
              onChanged: (String? newVal) {
                if (newVal != null) {
                  controller.coachList[e.key] =
                      controller.coachList[e.key].copyWith(email: newVal);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Coach email is required';
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding / 2),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Type',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
                hintText: 'e.g Life skills coach',
                hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
              onChanged: (String? newVal) {
                if (newVal != null) {
                  controller.coachList[e.key] =
                      controller.coachList[e.key].copyWith(type: newVal);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Coach type is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
            ),
            onPressed: () {
              controller.coachList.add(Coach());
            },
            icon: Icon(Icons.add),
            label: Text("Add New Coach"),
          )),
          if (controller.coachList.length > 0)
            Expanded(
                child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.coachList.removeLast();
              },
              icon: Icon(Icons.remove),
              label: Text("Remove Coach"),
            ))
        ],
      ),
      SizedBox(height: defaultPadding),
    ];
  }
}

class EditEmploymentDetailDialog extends StatelessWidget {
  final EditEmploymentController controller = Get.find();
  final WorkplaceDetailController wpController = Get.find();
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
      // _key.currentState!.save();
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
                        ...workplaceDetailField(),
                        ...workingHoursField(context),
                        ...lunchTimeField(context),
                        ...workingDaysField(),
                        ...timeToWorkField(),
                        ...jobScopeField(),
                        ...coachListField(),
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
                        if (controller.state is AddEmploymentFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddEmploymentFailure)
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
        keyboardType: TextInputType.emailAddress,
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

  List<Widget> workingHoursField(BuildContext context) {
    return <Widget>[
      Text(
        'Working Hours',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TimePickerField(
            controller: controller.workingTimeStartController,
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
            controller: controller.workingTimeEndController,
            labelText: 'End',
          )),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> lunchTimeField(BuildContext context) {
    return <Widget>[
      Text(
        'Lunch Time',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TimePickerField(
            controller: controller.lunchTimeStartController,
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
            controller: controller.lunchTimeEndController,
            labelText: 'End',
          )),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> workplaceDetailField() {
    var workplaceList = <WorkplaceDetail>[];
    if (wpController.state is WorkplaceDetailLoaded) {
      workplaceList =
          (wpController.state as WorkplaceDetailLoaded).listData ?? [];
    }
    return <Widget>[
      DropdownButtonFormField(
        items: workplaceList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.name!.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.workplaceId.value,
        onChanged: (String? newValue) {
          controller.workplaceId.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Workplace',
            labelStyle: TextStyle(
                color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
            )),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> workingDaysField() {
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
        children: [
          for (var i = 0; i < 7; i++)
            Expanded(
                child: RawMaterialButton(
              fillColor: controller.workingDays.contains(i)
                  ? Colors.deepPurpleAccent
                  : null,
              shape: CircleBorder(
                  side: BorderSide(
                      color: controller.workingDays.contains(i)
                          ? Colors.white54
                          : Color(0xFF999999),
                      width: 2.0)),
              onPressed: () {
                if (controller.workingDays.contains(i))
                  controller.workingDays.remove(i);
                else {
                  controller.workingDays.add(i);
                  controller.workingDays.sort();
                }
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  getWeekDayString(i),
                  style: TextStyle(
                      fontSize: 12,
                      color: controller.workingDays.contains(i)
                          ? Colors.white54
                          : null,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ))
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> timeToWorkField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Travel time to work (minutes)',
          labelStyle:
              TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
          hintText: 'e.g 0 = WFH',
          hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
        keyboardType: TextInputType.number,
        controller: controller.travelTimeController,
        validator: (val) {
          if (val == "") {
            return 'Travel time is required';
          }
          var value = int.tryParse(val!);
          if (value == null || value < 0) return 'Invalid travel time';
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> jobScopeField() {
    return <Widget>[
      Text('Job Scope', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: defaultPadding / 2),
      ...controller.scopeList.asMap().entries.map((e) {
        var taskString = "";
        if (e.value.task != null) {
          for (var i = 0; i < e.value.task!.length; i++) {
            taskString += e.value.task![i];
            if (i != e.value.task!.length) {
              taskString += "\n";
            }
          }
        }

        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Scope name',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
                hintText: 'e.g Safety Management Floor Officer',
                hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
              initialValue: controller.scopeList[e.key].name,
              onChanged: (String? newVal) {
                controller.scopeList[e.key] =
                    controller.scopeList[e.key].copyWith(
                  name: newVal,
                );
              },
              validator: (val) {
                if (val == "") {
                  return 'Scope name is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Tasks (Make new line if there are multiple tasks)',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
              minLines: 6,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              initialValue: taskString,
              onChanged: (String? newVal) {
                if (newVal != null) {
                  LineSplitter ls = LineSplitter();
                  List<String> tasks = ls.convert(newVal);
                  controller.scopeList[e.key] =
                      controller.scopeList[e.key].copyWith(task: tasks);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Scope tasks is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.scopeList.add(Scope());
              },
              icon: Icon(Icons.add),
              label: Text("Add New Scope"),
            ),
          ),
          if (controller.scopeList.length > 0)
            Expanded(
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding / 2),
                ),
                onPressed: () {
                  controller.scopeList.removeLast();
                },
                icon: Icon(Icons.remove),
                label: Text("Remove Scope"),
              ),
            ),
        ],
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> coachListField() {
    return <Widget>[
      Text('Coaches', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(
        height: defaultPadding / 2,
      ),
      ...controller.coachList.asMap().entries.map((e) {
        return Column(
          children: [
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Coach email',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
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
              initialValue: controller.coachList[e.key].name,
              onChanged: (String? newVal) {
                if (newVal != null) {
                  controller.coachList[e.key] =
                      controller.coachList[e.key].copyWith(email: newVal);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Coach email is required';
                }
                return null;
              },
            ),
            SizedBox(height: defaultPadding / 2),
            TextFormField(
              style: TextStyle(
                color: Color(0xFF999999),
              ),
              decoration: InputDecoration(
                labelText: 'Type',
                labelStyle: TextStyle(
                    color: Color(0xFF999999), fontWeight: FontWeight.bold),
                hintText: 'e.g Life skills coach',
                hintStyle: TextStyle(color: Color(0xFF999999).withOpacity(0.5)),
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
              initialValue: controller.coachList[e.key].type,
              onChanged: (String? newVal) {
                if (newVal != null) {
                  controller.coachList[e.key] =
                      controller.coachList[e.key].copyWith(type: newVal);
                }
              },
              validator: (val) {
                if (val == "") {
                  return 'Coach type is required';
                }
                return null;
              },
            ),
            SizedBox(
              height: defaultPadding / 2,
            ),
          ],
        );
      }).toList(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Row(
        children: [
          Expanded(
              child: TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.deepPurpleAccent,
              padding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding / 2),
            ),
            onPressed: () {
              controller.coachList.add(Coach());
            },
            icon: Icon(Icons.add),
            label: Text("Add New Coach"),
          )),
          if (controller.coachList.length > 0)
            Expanded(
                child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.symmetric(
                    horizontal: defaultPadding, vertical: defaultPadding / 2),
              ),
              onPressed: () {
                controller.coachList.removeLast();
              },
              icon: Icon(Icons.remove),
              label: Text("Remove Coach"),
            ))
        ],
      ),
      SizedBox(height: defaultPadding),
    ];
  }
}


