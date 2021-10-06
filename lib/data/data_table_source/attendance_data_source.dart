import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/support_management/barrel.dart';

class AttendanceDataSource extends DataTableSource{
  AttendanceDataSource({required this.controller, required this.context});
  // final List<EmotionalLog> _listData;
  // final int _totalItems;
  final AttendanceController controller;
  final BuildContext context;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    // var state = controller.attendanceState as AttendanceLoaded;
    // final _data = state.listData![index - controller.firstRowIndex];
    final _data = controller.dataList.cast<AttendanceModel>()[index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        selected: _data.selected,
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
              child: Text(DateFormat.yMd()
                  .add_jm()
                  .format(_data.createdTime!.toLocal())))),

          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(_data.isCheckedOut != null
                  ? DateFormat.yMd()
                  .add_jm()
                  .format(_data.lastUpdatedTime!.toLocal())
                  : "Not checked out"))),
        ],
        onSelectChanged: (bool? value) {
          if (_data.selected != value) {
            _data.selected = value!;
            notifyListeners();
          }
          controller.selectItemDetail(_data);
        });
  }
}
