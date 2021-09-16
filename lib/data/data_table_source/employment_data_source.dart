import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';
import 'package:test_flutter_web/utils/barrel.dart';

class EmploymentDetailData extends DataTableSource {
  EmploymentDetailData({required this.controller, required this.context});
  // final List<EmotionalLog> _listData;
  // final int _totalItems;
  final EmploymentDetailController controller;
  final BuildContext context;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.employmentState as EmploymentDetailLoaded;
    final _data = state.listData![index - controller.firstRowIndex];

    var startingTime = toTimeString(context, _data.workingTimeFrom!);
    var finishingTime = toTimeString(context, _data.workingTimeTo!);
    var workingDays = "";
    if (_data.workingDays!.length != 0) {
      for (var day in _data.workingDays!) {
        if (day == 0) continue;
        workingDays += getWeekDayString(day);
        if (day != _data.workingDays!.last)
          workingDays += ", ";
      }
      if (_data.workingDays!.first == 0)
        workingDays +=
            ", " + getWeekDayString(_data.workingDays!.first);
    }

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
              child: Text('${_data.workplaceName}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(startingTime + " - " + finishingTime))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(workingDays))),
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
