import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorTable {
  static Color primaryColor = Color.fromARGB(255, 48, 213, 200);
  static Color primaryColorDark = Color.fromARGB(255, 48, 213, 200);
  static const Color accentColor = Color.fromARGB(255, 48, 213, 200);

  static const Color darkModeBg = Color(0xff292929);

  static Color get getTextColor => Get.isDarkMode ? Colors.white : const Color.fromARGB(255, 107, 107, 107);
  static Color get getReversedTextColor => Get.isDarkMode ? Colors.black : Colors.white;
  static Color get getTitleColor => Color.fromARGB(255, 48, 213, 200);
  static Color get getHintTextColor => Colors.grey;
  static Color get getNegativeButtonColor => Colors.red;
  static Color get getPositiveButtonColor => Color.fromARGB(255, 48, 213, 200);
}
