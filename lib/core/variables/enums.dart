import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/colorTable.dart';

enum Pages {
  today,
  settings,
  calendar,
  allTasks,
  dbtc;

  Color get getPageColor {
    switch (this) {
      case Pages.today:
        return const Color.fromARGB(255, 48, 213, 200);
      case Pages.settings:
        return Colors.red;
      case Pages.calendar:
        return Colors.yellow;
      case Pages.allTasks:
        return Colors.green;
      case Pages.dbtc:
        return Colors.purple;
    }
  }

  int get getPageNumber {
    switch (this) {
      case Pages.today:
        return 0;
      case Pages.allTasks:
        return 1;
      case Pages.settings:
        return 2;
      case Pages.calendar:
        return 3;
      case Pages.dbtc:
        return 4;
    }
  }
}

enum SuccessStatus {
  successful,
  neutral,
  today,
  fail;

  IconData? get getIcon {
    switch (this) {
      case SuccessStatus.successful:
        return Icons.check;
      case SuccessStatus.fail:
        return Icons.close;
      default:
        return null;
    }
  }

  Color get getSuccessStatusColor {
    switch (this) {
      case SuccessStatus.today:
        return ColorTable.primaryColor;
      case SuccessStatus.successful:
        return ColorTable.getPositiveButtonColor;
      case SuccessStatus.neutral:
        return ColorTable.getNeutralButtonColor;
      case SuccessStatus.fail:
        return ColorTable.getNegativeButtonColor;
    }
  }
}
