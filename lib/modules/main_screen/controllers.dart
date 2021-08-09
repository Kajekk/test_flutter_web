import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';


class MainScreenController extends GetxController {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  var rng = new Random();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}