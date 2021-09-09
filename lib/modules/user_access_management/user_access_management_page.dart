import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/test.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/states.dart';
import 'package:test_flutter_web/routes/app_pages.dart';
import 'package:get/get.dart';

class UserAccessManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final EntityTypeController controller1 = Get.find();
  // final EntityTypeController2 controller2 = Get.find();
  // final EntityTypeController3 controller3 = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: Container(
        // constraints: BoxConstraints(maxWidth: maxWidth),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(
                        scaffoldKey: _scaffoldKey,
                        title: 'User Access Management',
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      SubTabs(
                        listController: [controller1],
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Obx(() {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    buildListItem([
                                      controller1,
                                      // controller2,
                                      // controller3
                                    ]),
                                    if (Responsive.isMobile(context))
                                      SizedBox(
                                        height: defaultPadding,
                                      ),
                                    // if (Responsive.isMobile(context))
                                      // ItemDetail(
                                      //   controller: controller1,
                                      //   itemDetailInfo: null,
                                      // ),
                                  ],
                                )),
                            if (!Responsive.isMobile(context))
                              SizedBox(
                                width: defaultPadding,
                              ),
                            // if (!Responsive.isMobile(context))
                              // Expanded(
                              //   flex: 2,
                              //   child: ItemDetail(
                              //     controller: controller1,
                              //     itemDetailInfo: null,
                              //   ),
                              // )
                          ],
                        );
                      }),
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }

  Widget buildListItem(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.entityType.title) {
        var state = controller1.emotionalLogState;
        print(state);
        if (state is EmotionalLoaded) {
          return ListItem(
            controller: controller,
            dataTableSource: EntityTypeData(controller: controller1),
            customDialog: CustomDialog(),
          );
        }
        if (state is EmotionalLoading) {
          return CircularProgressIndicator();
        }
        // return ListItem(
        //   controller: controller,
        //   dataTableSource: MyData(),
        //   isLoading: ((controller as EntityTypeController).emotionalLogState
        //           is EmotionalLoading)
        //       ? true
        //       : false,
        // );
      }
      // if (controller.isCurrent &&
      //     controller.subTabInfoModel.title ==
      //         SubTabInfo.userPermissions.title) {
      //   return ListItem(controller: controller, dataTableSource: MyData());
      // }
      // if (controller.isCurrent &&
      //     controller.subTabInfoModel.title == SubTabInfo.userRoles.title) {
      //   return ListItem(controller: controller, dataTableSource: MyData());
      // }
    }
    return Container();
  }

  Widget buildItemDetail(List<SubTabController> listController) {
    for (var controller in listController) {
      if (controller.isCurrent &&
          controller.subTabInfoModel.title == SubTabInfo.entityType.title) {
        var state = controller1.emotionalLogState;
        if (state is EmotionalLoaded) {
          // return ItemDetail(
          //   controller: controller,
          //   itemDetailInfo: null,
          // );
        }
        if (state is EmotionalLoading) {
          return CircularProgressIndicator();
        }
      }
    }
    return Container();
  }
}

class EntityTypeData extends DataTableSource {
  EntityTypeData({required this.controller});
  // final List<EmotionalLog> _listData;
  // final int _totalItems;
  final EntityTypeController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.emotionalLogState as EmotionalLoaded;
    final _data = state.listData![index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.uid}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.email}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.type}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.description}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(DateFormat.yMd()
                  .add_jm()
                  .format(_data.createdTime!.toLocal())))),
        ],
        onSelectChanged: (bool? selected) {
          controller.selectItemDetail(_data);
        });

    // return DataRow.byIndex(
    //     index: index,
    //     cells: [
    //       DataCell(Text(testData[index]['id'].toString())),
    //       DataCell(Text(testData[index]["title"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["4"])),
    //     ],
    //     onSelectChanged: (bool? selected) {
    //       if (selected!) {
    //         print('selected $index');
    //       }
    //     });
  }
}

class MyData2 extends DataTableSource {
  MyData2({required List<MyModel> listData}) : _listData = listData;
  final List<MyModel> _listData;

  final List<Map<String, dynamic>> testData = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  int get rowCount => _listData.length;
  // int get rowCount => testData.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= _listData.length) {
      return null;
    }
    final _data = _listData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${_data.id}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
      ],
    );

    // return DataRow.byIndex(
    //     index: index,
    //     cells: [
    //       DataCell(Text(testData[index]['id'].toString())),
    //       DataCell(Text(testData[index]["title"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["4"])),
    //       DataCell(Text(testData[index]["4"])),
    //     ],
    //     onSelectChanged: (bool? selected) {
    //       if (selected!) {
    //         print('selected $index');
    //       }
    //     });
  }
}

class MyData3 extends DataTableSource {
  MyData3({required List<MyModel> listData}) : _listData = listData;
  final List<MyModel> _listData;

  final List<Map<String, dynamic>> testData = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  int get rowCount => _listData.length;
  // int get rowCount => testData.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= _listData.length) {
      return null;
    }
    final _data = _listData[index];

    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('${_data.id}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
        DataCell(Text('${_data.title}')),
      ],
    );

    // return DataRow.byIndex(
    //     index: index,
    //     cells: [
    //       DataCell(Text(testData[index]['id'].toString())),
    //       DataCell(Text(testData[index]["title"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["4"])),
    //       DataCell(Text(testData[index]["price"].toString())),
    //       DataCell(Text(testData[index]["price"].toString())),
    //     ],
    //     onSelectChanged: (bool? selected) {
    //       if (selected!) {
    //         print('selected $index');
    //       }
    //     });
  }
}

class CustomDialog extends StatelessWidget {
  final AddNewEntityTypeController controller = Get.find();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();

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
    AddNewEntityTypeController controller = Get.find();
    if (_key.currentState!.validate()) {
      _key.currentState!.save();

      controller.addNewItem(EmotionalLog(
          email: _emailController.text,
          type: controller.currentType.value,
          description: _descriptionController.text));
    }
  }

  Widget dialogContent(BuildContext context) {
    var types = [
      "happy",
      "grateful",
      "positive",
      "tired",
      "sleepy",
      "angry",
      "disappointed",
    ];

    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 400,
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15
            ),
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
                Text('Add new item', style: Theme.of(context).textTheme.subtitle1,),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xFF999999),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              color: Color(0xFF999999),
                              fontWeight: FontWeight.bold),
                          // filled: true,
                          // isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF999999)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xFF999999)),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.redAccent),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        cursorColor: Color(0xFF999999),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
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
                      DropdownButtonFormField(items: types.map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Row(
                            children: [Text(val.toUpperCase())],
                          ),
                        );
                      }).toList(),
                        value: controller.currentType.value,
                        onChanged: (String? newValue) {
                          controller.currentType.value = newValue!;
                        },
                        decoration: InputDecoration(
                            labelText: 'Type',
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
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        // value: controller.,
                      ),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      TextFormField(
                        style: TextStyle(
                          color: Color(0xFF999999),
                        ),
                        decoration: InputDecoration(
                            labelText: 'Description',
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
                              borderSide:
                                  BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.redAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: _descriptionController,
                        cursorColor: Color(0xFF999999),
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
                      ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        child: Text('Submit'),

                        // onPressed: _controller.state is LoginLoading
                        //     ? () {}
                        //     : _onLoginButtonPressed,
                        // child: (_controller.state is LoginLoading)
                        //     ? SizedBox(
                        //   child: CircularProgressIndicator(),
                        //   height: 20.0,
                        //   width: 20.0,
                        // )
                        //     : Text('LOG IN'),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 2,
                                  vertical: defaultPadding)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.deepPurpleAccent),
                        ),
                      ),
                      // if (_controller.state is LoginFailure)
                      //   Padding(
                      //     padding: const EdgeInsets.only(top: defaultPadding),
                      //     child: Text(
                      //       (_controller.state as LoginFailure).error,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(
                      //           color: Get.theme.errorColor // easy way to access theme
                      //       ),
                      //     ),
                      //   ),
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
  }
}
