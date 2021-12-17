import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/data/models/query_models.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import '../data/models/account.dart';

class ListItem extends StatelessWidget {
  // final String tag;
  final SubTabController controller;
  final DataTableSource dataTableSource;
  final isLoading;
  final Widget? customDialog;
  final double? dataRowHeight;

  ListItem(
      {Key? key,
      required this.controller,
      required this.dataTableSource,
      this.customDialog,
      this.dataRowHeight,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CategoryController categoryController = Get.find(tag: tag);
    // final ListItemController listItemController = Get.find();
    void onAddNewPressed() {
      if (customDialog != null) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return customDialog!;
            });
      }
    }

    void onDeleteItemsPressed() {
      var numSelected = 0;

      for (var i in controller.dataList) {
        if (i.selected) numSelected++;
      }

      if (numSelected > 0) {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                child: Container(
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
                    children: <Widget>[
                      Text(
                        'Are you sure you want to delete $numSelected item(s)?',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Navigator.of(context).pop();
                          ElevatedButton(
                            onPressed: controller.deleteItems,
                            child: Text('Yes'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding / 1.5)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
                          SizedBox(width: defaultPadding * 2,),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('No'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.symmetric(
                                      horizontal: defaultPadding,
                                      vertical: defaultPadding / 1.5)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurpleAccent),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        );
      }
    }

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        // categoryController.currentCategory,
                        controller.subTabInfoModel.title!,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        padding: EdgeInsets.symmetric(
                            horizontal: defaultPadding,
                            vertical: defaultPadding /
                                (Responsive.isMobile(context) ? 1.5 : 1.2)),
                      ),
                      onPressed: onAddNewPressed,
                      icon: Icon(Icons.add),
                      label: Text("Add New"),
                    ),
                    SizedBox(width: 10,),
                    IconButton(
                      icon: Icon(Icons.delete_forever),
                      onPressed: onDeleteItemsPressed,
                      color: Colors.deepPurpleAccent,
                      iconSize: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding / 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.dark().copyWith(
                        primary: Colors.deepPurpleAccent,
                      )
                    ),
                    child: PaginatedDataTable(
                      columns: List.generate(
                          // categoryController.dataColumn.length,
                          controller.subTabInfoModel.dataColumn!.length,
                          (index) => DataColumn(
                              label: Text(controller
                                  .subTabInfoModel.dataColumn![index]))),
                      onRowsPerPageChanged: (value) {
                        controller.rowsPerPage = value;
                        controller.firstRowIndex = 0;
                        controller.fetchListItems(QueryModel(
                            offset: 0,
                            limit: controller.rowsPerPage,
                            total: true,
                            reverse: true,
                        ));
                      },
                      onPageChanged: (rowIndex) {
                        controller.firstRowIndex = rowIndex;
                        // if (dataTableSource.rowCount - rowIndex < controller.itemPerPage) {
                        //   controller.itemPerPage = dataTableSource.rowCount - rowIndex;
                        // } else
                        //   controller.itemPerPage = 10;
                        controller.fetchListItems(QueryModel(
                            offset: rowIndex,
                            limit: controller.rowsPerPage,
                            total: true,
                            reverse: true,
                        ));
                      },
                      initialFirstRowIndex: controller.firstRowIndex,
                      availableRowsPerPage: [10, 20, 50],
                      showCheckboxColumn: true,
                      showFirstLastButtons: true,
                      rowsPerPage: controller.rowsPerPage,
                      source: dataTableSource,
                      dataRowHeight: dataRowHeight ?? kMinInteractiveDimension,
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
        Visibility(
          visible: isLoading,
          child: Positioned.fill(
            child: DotWaveLoader(
              dotColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}