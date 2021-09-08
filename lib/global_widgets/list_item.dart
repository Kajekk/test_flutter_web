import 'dart:math';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import '../data/models/account.dart';

class ListItem extends StatelessWidget {
  // final String tag;
  final SubTabController controller;
  final DataTableSource dataTableSource;
  final isLoading;
  ListItem({Key? key, required this.controller, required this.dataTableSource, this.isLoading = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final CategoryController categoryController = Get.find(tag: tag);
    final ListItemController listItemController = Get.find();

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
                      controller.categoryModel.title!,
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
                      onPressed: () {},
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
                        controller.categoryModel.dataColumn!.length,
                            (index) => DataColumn(
                            label: Text(controller.categoryModel.dataColumn![index]))),
                    onRowsPerPageChanged: (value) {
                      listItemController.changeRowsPerPage(value);
                    },
                    onPageChanged: (rowIndex) {
                      print("onPageChanged");
                      print(rowIndex);
                    },
                    showCheckboxColumn: false,
                    showFirstLastButtons: true,
                    rowsPerPage: listItemController.rowsPerPage,
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
            child: Container(decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.grey.withOpacity(0.8)
            ),),
          ),
        ),
      ],
    );
  }
}