import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../variables/colorTable.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorTable.primaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorTable.primaryColor),
      ),
    ),
    primaryColorDark: ColorTable.primaryColorDark,
    primaryColor: ColorTable.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: ColorTable.primaryColor,
      secondary: ColorTable.accentColor, // Your accent color
    ),
    iconTheme: IconThemeData(color: ColorTable.primaryColor), //Default Icon Color
    scaffoldBackgroundColor: const Color(0xFFF6F6F6),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );

  static ThemeData dark = ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.greenAccent),
      ),
    ),
    primaryColorDark: ColorTable.primaryColorDark,
    primaryColor: ColorTable.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      brightness: Brightness.light,
      primary: ColorTable.primaryColor,
      secondary: ColorTable.accentColor, // Your accent color
    ),

    iconTheme: IconThemeData(color: ColorTable.primaryColor), //Default Icon Color
    scaffoldBackgroundColor: ColorTable.darkModeBg,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );
}
