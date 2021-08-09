import 'package:get/get.dart';

class ListItemController extends GetxController {
  final _rowsPerPage = 10.obs;

  int get rowsPerPage => _rowsPerPage.value;

  void changeRowsPerPage(val) {
    _rowsPerPage.value = val;
  }
}

