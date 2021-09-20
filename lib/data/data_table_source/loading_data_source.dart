import 'package:flutter/material.dart';

class EmptyDataSource extends DataTableSource {
  final int numCol;
  EmptyDataSource({required this.numCol});

  bool get isRowCountApproximate => false;
  int get rowCount => 10;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    return DataRow.byIndex(
        index: index,
        cells: [
          for (var i=0;i<numCol;i++)
            DataCell(Container(
                constraints: BoxConstraints(
                  maxWidth: 200,
                ),
                child: Text(''),
            ),)
        ],
      );
  }
}