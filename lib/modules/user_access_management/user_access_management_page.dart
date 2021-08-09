import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/routes/app_pages.dart';
import 'package:get/get.dart';

import 'common.dart';

class UserAccessManagementPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final CategoryController categoryController = Get.find();

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
                      Category(tag: 'user-access-management'),
                      SizedBox(
                        height: defaultPadding,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  ListItem(
                                    tag: 'user-access-management',
                                    dataTableSource: MyData(),
                                  ),
                                  if (Responsive.isMobile(context))
                                    SizedBox(
                                      height: defaultPadding,
                                    ),
                                  if (Responsive.isMobile(context))
                                    ItemDetail(),
                                ],
                              )),
                          if (!Responsive.isMobile(context))
                            SizedBox(
                              width: defaultPadding,
                            ),
                          if (!Responsive.isMobile(context))
                            Expanded(
                              flex: 2,
                              child: ItemDetail(),
                            )
                        ],
                      )
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}

List<String> dataColumn = [
  "Organization",
  "Type",
  "Role",
  "Account Name",
];

class MyData extends DataTableSource {
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      5,
      (index) => {
            "id": index,
            "title": "Item $index",
            "price": Random().nextInt(10000),
            "4": "123213123",
          });

  bool get isRowCountApproximate => false;
  int get rowCount => _data.length;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= _data.length) {
      return null;
    }

    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Text(_data[index]['id'].toString())),
          DataCell(Text(_data[index]["title"])),
          DataCell(Text(_data[index]["price"].toString())),
          DataCell(Text(_data[index]["4"])),
        ],
        onSelectChanged: (bool? selected) {
          if (selected!) {
            print('selected $index');
          }
        });
  }
}
