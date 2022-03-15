import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/community_management/barrel.dart';

class CommunityTopicData extends DataTableSource {
  CommunityTopicData({required this.controller});
  final TopicController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    final _data = controller.dataList.cast<CommunityTopic>()[index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        selected: _data.selected,
        cells: [
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.organisation}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.topic}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(DateFormat.yMd()
                  .add_jm()
                  .format(_data.startTime!.toLocal())))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text(DateFormat.yMd()
                  .add_jm()
                  .format(_data.endTime!.toLocal())))),
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