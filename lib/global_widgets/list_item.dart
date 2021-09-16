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
  ListItem(
      {Key? key,
      required this.controller,
      required this.dataTableSource,
      this.customDialog,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // categoryController.currentCategory,
                      controller.subTabInfoModel.title!,
                      style: Theme.of(context).textTheme.subtitle1,
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
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding / 2,
                ),
                SizedBox(
                  width: double.infinity,
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
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    rowsPerPage: controller.rowsPerPage,
                    // onSelectAll: _data.se,
                    source: dataTableSource,
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