import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/colorTable.dart';

enum WelcomePages {
  welcomePage,
  signIn,
  signUp;

  int get getPageNumber {
    switch (this) {
      case WelcomePages.welcomePage:
        return 0;
      case WelcomePages.signIn:
        return 1;
      case WelcomePages.signUp:
        return 2;
    }
  }
}

enum MainPages {
  today,
  settings,
  calendar,
  allTasks,
  dbtc;

  Color get getPageColor {
    switch (this) {
      case MainPages.today:
        return const Color.fromARGB(255, 48, 213, 200);
      case MainPages.settings:
        return Colors.red;
      case MainPages.calendar:
        return Colors.yellow;
      case MainPages.allTasks:
        return Colors.green;
      case MainPages.dbtc:
        return Colors.purple;
      default:
        return const Color.fromARGB(255, 48, 213, 200);
    }
  }

  int get getPageNumber {
    switch (this) {
      case MainPages.today:
        return 0;
      case MainPages.allTasks:
        return 1;
      case MainPages.settings:
        return 2;
      case MainPages.calendar:
        return 3;
      case MainPages.dbtc:
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
