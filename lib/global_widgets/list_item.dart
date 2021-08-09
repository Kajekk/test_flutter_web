import 'dart:math';

import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_flutter_web/constants/app_constants.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:test_flutter_web/global_widgets/barrel.dart';
import 'package:test_flutter_web/global_widgets/responsive.dart';
import 'package:test_flutter_web/models/account.dart';

class ListItem extends StatelessWidget {
  final String tag;
  final DataTableSource dataTableSource;
  ListItem({Key? key, required this.tag, required this.dataTableSource}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController = Get.find(tag: tag);
    final ListItemController listItemController = Get.find(tag: tag);
    return Container(
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
                  categoryController.currentCategory,
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
            // Obx(() {
            //   return DataTable2(
            //     columnSpacing: defaultPadding,
            //     minWidth: 600,
            //     columns: List.generate(categoryController.dataColumn.length,
            //             (index) => DataColumn(label: Text(categoryController.dataColumn[index]))),
            //     rows: List.generate(
            //         mockupData.length, (index) => (dataRow(mockupData[index]))),
            //   );
            // }),
            SizedBox(
              width: double.infinity,
              child: PaginatedDataTable(
                columnSpacing: defaultPadding,
                columns: List.generate(
                    categoryController.dataColumn.length,
                    (index) => DataColumn(
                        label: Text(categoryController.dataColumn[index]))),
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
    );
  }
}

DataRow dataRow(Account account) {
  return DataRow(cells: [
    DataCell(Text(account.accountName!)),
    DataCell(Text(account.organization!)),
    DataCell(Text(account.role!)),
    DataCell(Text(account.type!)),
  ]);
}

// List mockupData = [
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
//   Account(
//     accountName: "qweqe",
//     organization: "individual",
//     role: "admin",
//     type: "123",
//   ),
// ];

