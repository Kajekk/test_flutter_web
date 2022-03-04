import 'package:flutter/material.dart';
import 'package:test_flutter_web/data/models/barrel.dart';
import 'package:test_flutter_web/modules/employment_management/barrel.dart';

class ContactFormDataSource extends DataTableSource {
  ContactFormDataSource({required this.controller, required this.context});
  // final List<EmotionalLog> _listData;
  // final int _totalItems;
  final ContactFormController controller;
  final BuildContext context;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    // var state = controller.employmentState as EmploymentDetailLoaded;
    // final _data = state.listData![index - controller.firstRowIndex];
    final _data = controller.dataList.cast<ContactForm>()[index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        selected: _data.selected,
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
              child: Text('${_data.email}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.phone}'))),
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