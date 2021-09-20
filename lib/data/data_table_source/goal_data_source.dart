import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/modules/goal_management/barrel.dart';
import 'package:test_flutter_web/modules/goal_management/states/goal_states.dart';

class GoalData extends DataTableSource {
  GoalData({required this.controller});
  final GoalController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    var state = controller.goalState as GoalLoaded;
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
              child: Text('${_data.frequency}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.description}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.nature}'))),
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
