import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';

class GoalFrequencyData extends DataTableSource {
  GoalFrequencyData({required this.controller});
  final GoalFrequencyController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.goalState as GoalFrequencyLoaded;
    final _data = state.listData![index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        cells: [
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.frequency}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.dayEquivalent.toString()}'))),
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
  }
}
