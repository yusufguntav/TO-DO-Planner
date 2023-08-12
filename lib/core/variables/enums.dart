import 'package:flutter/material.dart';

enum MenuColors {
  home,
  settings,
  calendar,
  allTasks,
  dbtc;

  Color get getMenuTag {
    switch (this) {
      case MenuColors.home:
        return const Color.fromARGB(255, 48, 213, 200);
      case MenuColors.settings:
        return Colors.red;
      case MenuColors.calendar:
        return Colors.yellow;
      case MenuColors.allTasks:
        return Colors.green;
      case MenuColors.dbtc:
        return Colors.purple;
    }
  }
}
