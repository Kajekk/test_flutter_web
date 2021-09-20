import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/goal_states.dart';

class GoalItemDetailInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EditGoalController controller = Get.find();
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
                text: "Name: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.name),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Frequency: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.frequency),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Description: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.description),
          ])),
          SizedBox(
            height: defaultPadding / 2,
          ),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Tips: \n",
                style: Theme.of(context).textTheme.subtitle1),
            ...controller.itemDetail!.tips!.map((e) {
              return TextSpan(text: "- " + e + "\n");
            }).toList(),
          ])),
          Text.rich(TextSpan(children: [
            TextSpan(
                text: "Nature: \n",
                style: Theme.of(context).textTheme.subtitle1),
            TextSpan(text: controller.itemDetail!.nature),
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

class GoalDetailDialog extends StatelessWidget {
  final AddNewGoalController controller = Get.find();
  final GoalFrequencyController frequencyController = Get.find();
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
                        ...nameField(),
                        ...frequencyField(),
                        ...descriptionField(),
                        ...tipsField(),
                        ...natureField(),
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
                        if (controller.state is AddGoalFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddGoalFailure)
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

  List<Widget> nameField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Name',
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
        controller: controller.nameController,
        validator: (val) {
          if (val == "") {
            return 'Name is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> descriptionField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Description',
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
        controller: controller.descriptionController,
        validator: (val) {
          if (val == "") {
            return 'Description is required';
          }
          return null;
        },
        minLines: 5,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> tipsField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
            labelText: 'Tips (Make new line if there are multiple tips)',
            labelStyle: TextStyle(
                color: Color(0xFF999999),
                fontWeight: FontWeight.bold),
            // filled: true,
            // isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
        cursorColor: Color(0xFF999999),
        onChanged: (String? newVal) {
          if (newVal != null) {
            LineSplitter ls = LineSplitter();
            List<String> tips = ls.convert(newVal);
            controller.tips.value = tips;
          }
        },
        validator: (value) {
          if (value == "") {
            return 'Description is required.';
          }
          return null;
        },
        minLines: 5,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> frequencyField() {
    var frequencyList = <GoalFrequency>[];
    if (frequencyController.goalState is GoalFrequencyLoaded) {
      frequencyList =
          (frequencyController.goalState as GoalFrequencyLoaded).listData ?? [];
    }
    return <Widget>[
      DropdownButtonFormField(
        items: frequencyList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.frequency!.toUpperCase())],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.frequencyId.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Frequency',
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

  List<Widget> natureField() {
    var natureList = ['system', 'non-system'];

    return <Widget>[
      DropdownButtonFormField(
        items: natureList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Row(
              children: [Text(e.toUpperCase())],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          controller.nature.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Nature',
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
}

class EditGoalDetailDialog extends StatelessWidget {
  final EditGoalController controller = Get.find();
  final GoalFrequencyController frequencyController = Get.find();
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
                        ...nameField(),
                        ...frequencyField(),
                        ...descriptionField(),
                        ...tipsField(),
                        ...natureField(),
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
                        if (controller.state is AddGoalFailure)
                          Padding(
                            padding: EdgeInsets.only(top: defaultPadding / 2),
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  (controller.state as AddGoalFailure)
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

  List<Widget> nameField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Name',
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
        controller: controller.nameController,
        validator: (val) {
          if (val == "") {
            return 'Name is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> descriptionField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Name',
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
        minLines: 5,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: controller.descriptionController,
        validator: (val) {
          if (val == "") {
            return 'Description is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> tipsField() {
    String tips = '';
    controller.tips.forEach((tip) {
      tips += tip + '\n';
    });

    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
            labelText: 'Tips (Make new line if there are multiple tips)',
            labelStyle: TextStyle(
                color: Color(0xFF999999),
                fontWeight: FontWeight.bold),
            // filled: true,
            // isDense: true,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: Colors.redAccent),
              borderRadius: BorderRadius.circular(15),
            )),
        cursorColor: Color(0xFF999999),
        initialValue: tips,
        onChanged: (String? newVal) {
          if (newVal != null) {
            LineSplitter ls = LineSplitter();
            List<String> tips = ls.convert(newVal);
            controller.tips.value = tips;
          }
        },
        validator: (value) {
          if (value == "") {
            return 'Description is required.';
          }
          return null;
        },
        minLines: 5,
        keyboardType: TextInputType.multiline,
        maxLines: null,
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> frequencyField() {
    var frequencyList = <GoalFrequency>[];
    if (frequencyController.goalState is GoalFrequencyLoaded) {
      frequencyList =
          (frequencyController.goalState as GoalFrequencyLoaded).listData ?? [];
    }
    return <Widget>[
      DropdownButtonFormField(
        items: frequencyList.map((e) {
          return DropdownMenuItem(
            value: e.id,
            child: Row(
              children: [Text(e.frequency!.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.frequencyId.value,
        onChanged: (String? newValue) {
          controller.frequencyId.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Frequency',
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

  List<Widget> natureField() {
    var natureList = ['system', 'non-system'];

    return <Widget>[
      DropdownButtonFormField(
        items: natureList.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Row(
              children: [Text(e.toUpperCase())],
            ),
          );
        }).toList(),
        value: controller.nature.value,
        onChanged: (String? newValue) {
          controller.nature.value = newValue!;
        },
        validator: (val) {
          if (val == null || val == "") {
            return 'Required';
          }
          return null;
        },
        decoration: InputDecoration(
            labelText: 'Nature',
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
}