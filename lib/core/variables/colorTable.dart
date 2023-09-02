// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorTable {
  static Color primaryColor = const Color.fromARGB(255, 48, 213, 200);
  static Color primaryColorDark = const Color.fromARGB(255, 48, 213, 200);
  static const Color accentColor = Color.fromARGB(255, 48, 213, 200);

  static const Color darkModeBg = Color(0xff292929);

  static Color get getTextColor => Get.isDarkMode ? Colors.white : const Color.fromARGB(255, 107, 107, 107);
  static Color get getReversedTextColor => Get.isDarkMode ? Colors.black : Colors.white;
  static Color get getTitleColor => const Color.fromARGB(255, 48, 213, 200);
  static Color get getHintTextColor => Colors.grey;
  static Color get getNegativeColor => Colors.red;
  static Color get getPositiveColor => Colors.green;
  static Color get getNeutralColor => Colors.grey;
}
