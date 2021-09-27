import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/goal_relationship_states.dart';

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

class GoalRelationshipDialog extends StatelessWidget {
  final AddNewGoalRelationshipController controller = Get.find();
  final GoalController gController = Get.find();
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
                Form(key: _key, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...emailField(),
                    ...createdByField(),
                    ...goalField(),
                  ],
                ),),
                SizedBox(
                  height: 20.0,
                ),
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
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email (Assignee)',
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

  List<Widget> createdByField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Created By (Assigner)',
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
        controller: controller.createdByController,
        validator: (val) {
          if (val == "") {
            return 'Created By is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> goalField() {
    return [
      DropdownSearch<Goal>(
        validator: (val) {
          if (val == null) {
            return 'Required';
          }
          return null;
        },
        maxHeight: 300,
        dialogMaxWidth: 400,
        isFilteredOnline: true,
        compareFn: (i, s) => i?.isEqual(s) ?? false,
        onFind: (String? filter) => getData(filter),
        onChanged: (data) {
          if (data != null) {
            controller.goalId.value = data.id!;
          }
        },
        showSearchBox: true,
        showSelectedItems: true,
        popupItemBuilder: _customPopupItemBuilder,
        dropdownBuilder: _customDropDown,
        loadingBuilder: _customLoading,
        emptyBuilder: _customEmpty,
        popupBackgroundColor: secondaryColor,
        dropdownSearchDecoration: InputDecoration(
          labelText: "Goal",
          labelStyle: TextStyle(color: bodyTextColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        searchFieldProps: TextFieldProps(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          cursorColor: bodyTextColor,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            labelText: "Search a goal",
            labelStyle: TextStyle(color: bodyTextColor),
          ),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  Future<List<Goal>> getData(textString) async {
    if (textString == "") return [];

    await gController.fetchListItems(QueryModel(
      q: jsonEncode({"text_search": textString}),
    ));

    if (gController.goalState is GoalLoaded) {
      var listData = (gController.goalState as GoalLoaded).listData;
      if (listData != null) {
        return listData;
      }
    }
    if (gController.goalState is AddGoalRelationshipFailure) {

    }
    return [];
  }

  Widget _customEmpty(BuildContext context, String? searchEntry) {
    return Container();
  }

  Widget _customLoading(BuildContext context, String? searchEntry) {
    return DotWaveLoader(
      dotColor: Colors.white,
    );
  }

  Widget _customDropDown(BuildContext context, Goal? item) {
    if (item == null) {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("No item selected"),
      );
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(item.name!),
      ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, Goal? item, bool isSelected) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selected: isSelected,
          title: Text(item != null ? item.name! : ''),
        ),
      ),
    );
  }

}

class EditGoalRelationshipDialog extends StatelessWidget {
  final EditGoalRelationshipController controller = Get.find();
  final GoalController gController = Get.find();
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
                Form(key: _key, child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...emailField(),
                    ...createdByField(),
                    ...goalField(),
                  ],
                ),),
                SizedBox(
                  height: 20.0,
                ),
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
  }

  List<Widget> emailField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Email (Assignee)',
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

  List<Widget> createdByField() {
    return <Widget>[
      TextFormField(
        style: TextStyle(
          color: Color(0xFF999999),
        ),
        decoration: InputDecoration(
          labelText: 'Created By (Assigner)',
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
        controller: controller.createdByController,
        validator: (val) {
          if (val == "") {
            return 'Created By is required';
          }
          return null;
        },
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  List<Widget> goalField() {
    return [
      DropdownSearch<Goal>(
        validator: (val) {
          if (val == null) {
            return 'Required';
          }
          return null;
        },
        maxHeight: 300,
        dialogMaxWidth: 400,
        isFilteredOnline: true,
        compareFn: (i, s) => i?.isEqual(s) ?? false,
        onFind: (String? filter) => getData(filter),
        onChanged: (data) {
          if (data != null) {
            controller.goalId.value = data.id!;
          }
        },
        selectedItem: controller.itemDetail?.goal,
        showSearchBox: true,
        showSelectedItems: true,
        popupItemBuilder: _customPopupItemBuilder,
        dropdownBuilder: _customDropDown,
        loadingBuilder: _customLoading,
        emptyBuilder: _customEmpty,
        popupBackgroundColor: secondaryColor,
        dropdownSearchDecoration: InputDecoration(
          labelText: "Goal",
          labelStyle: TextStyle(color: bodyTextColor),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        searchFieldProps: TextFieldProps(
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
          cursorColor: bodyTextColor,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF999999)),
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            labelText: "Search a goal",
            labelStyle: TextStyle(color: bodyTextColor),
          ),
        ),
      ),
      SizedBox(
        height: defaultPadding,
      ),
    ];
  }

  Future<List<Goal>> getData(textString) async {
    if (textString == "") return [];

    await gController.fetchListItems(QueryModel(
      q: jsonEncode({"text_search": textString}),
    ));

    if (gController.goalState is GoalLoaded) {
      var listData = (gController.goalState as GoalLoaded).listData;
      if (listData != null) {
        return listData;
      }
    }
    if (gController.goalState is AddGoalRelationshipFailure) {

    }
    return [];
  }

  Widget _customEmpty(BuildContext context, String? searchEntry) {
    return Container();
  }

  Widget _customLoading(BuildContext context, String? searchEntry) {
    return DotWaveLoader(
      dotColor: Colors.white,
    );
  }

  Widget _customDropDown(BuildContext context, Goal? item) {
    if (item == null) {
      return ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text("No item selected"),
      );
    }

    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: Text(item.name!),
      ),
    );
  }

  Widget _customPopupItemBuilder(
      BuildContext context, Goal? item, bool isSelected) {
    return Container(
      width: 100,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
      ),
      child: ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selected: isSelected,
          title: Text(item != null ? item.name! : ''),
        ),
      ),
    );
  }
}

