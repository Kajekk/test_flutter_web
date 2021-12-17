import 'package:flutter/material.dart';
import 'package:test_flutter_web/constants/barrel.dart';
import 'package:test_flutter_web/data/barrel.dart';
import 'package:test_flutter_web/modules/user_access_management/barrel.dart';

class OrganisationDataSource extends DataTableSource {
  OrganisationDataSource({required this.controller});
  final OrganisationController controller;

  bool get isRowCountApproximate => false;
  int get rowCount => controller.totalRows;
  int get selectedRowCount => 0;

  DataRow? getRow(int index) {
    if (index >= controller.totalRows || index < controller.firstRowIndex) {
      return null;
    }
    // var state = controller.goalState as QuoteSuccess;
    // final _data = state.listData![index - controller.firstRowIndex];
    final _data = controller.dataList.cast<Organisation>()[index - controller.firstRowIndex];

    return DataRow.byIndex(
        index: index,
        selected: _data.selected,
        cells: [
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.code}'))),
          DataCell(Container(
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Text('${_data.name}', overflow: TextOverflow.ellipsis,))),
          DataCell(Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              constraints: BoxConstraints(
                minWidth: 50,
                maxWidth: 200,
              ),
              child: RichText(
                overflow: TextOverflow.fade,
                // softWrap: true,
                text: TextSpan(
                    style: TextStyle(color: bodyTextColor),
                    children: _data.permissionList?.map((e) {
                      if (_data.permissionList!.last.id == e.id) {
                        return TextSpan(text: e.name);
                      }
                      return TextSpan(text: e.name! + ', ');
                    }).toList()
                ),
              ))),
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