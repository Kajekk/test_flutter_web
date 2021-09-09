import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/modules/emotional_management/barrel.dart';

class EmotionalLogData extends DataTableSource {
  EmotionalLogData({required this.controller});
  // final List<EmotionalLog> _listData;
  // final int _totalItems;
  final EmotionalLogController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.emotionalLogState as EmotionalLogLoaded;
    final _data = state.listData![index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        cells: [
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
