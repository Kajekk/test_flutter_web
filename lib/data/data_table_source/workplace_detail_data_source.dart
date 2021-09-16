import 'package:flutter/material.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';

class WorkplaceDetailData extends DataTableSource {
  WorkplaceDetailData({required this.controller, required this.context});
  final WorkplaceDetailController controller;
  final BuildContext context;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.state as WorkplaceDetailLoaded;
    final _data = state.listData![index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.name}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.address}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.latitude.toString()}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.longitude.toString()}'))),
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
