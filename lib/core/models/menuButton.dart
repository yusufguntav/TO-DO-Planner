// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuButtonModel {
  String herotag;
  GetxController? controller;
  int selectedPageNumber;
  IconData? icon;
  Color? color;
  double bottomPosition;
  double leftPosition;
  MenuButtonModel(this.herotag, this.controller, this.selectedPageNumber, this.icon, this.color, this.bottomPosition, this.leftPosition);
}
