import 'package:flutter/material.dart';

import 'colorTable.dart';

enum PageStates {
  initial,
  busy,
  loaded,
  error,
}

enum StatusCodes {
  informational,
  successful,
  redirection,
  clientError,
  serverError;

  bool checkStatusCode(int statusCode) {
    switch (this) {
      case StatusCodes.informational:
        return (100 <= statusCode && statusCode <= 199) ? true : false;
      case StatusCodes.successful:
        return (200 <= statusCode && statusCode <= 299) ? true : false;
      case StatusCodes.redirection:
        return (300 <= statusCode && statusCode <= 399) ? true : false;
      case StatusCodes.clientError:
        return (400 <= statusCode && statusCode <= 499) ? true : false;
      case StatusCodes.serverError:
        return (500 <= statusCode && statusCode <= 599) ? true : false;
      default:
        return false;
    }
  }
}

enum Endpoints {
  signUp,
  signIn,
  addCategory,
  getCategory,
  deleteCategory,
  updateCategory,
  addSpecialList,
  getSpeciaLists,
  updateSpecialList,
  deleteSpecialList,
  getTasksByDate,
  getTasksForSpecialList,
  getTasksForRoutine,
  addTask,
  deleteTask,
  updateTaskOrder,
  updateSpecialListTaskOrder,
  createRoutine,
  getRoutines,
  updateRoutine,
  deleteRoutine,
  checkRoutine;

  String get path {
    switch (this) {
      case Endpoints.signIn:
        return '/user/signIn/';
      case Endpoints.signUp:
        return '/user/signUp/';
      case Endpoints.addCategory:
        return '/category/addCategory/';
      case Endpoints.getCategory:
        return '/category/';
      case Endpoints.deleteCategory:
        return '/category/';
      case Endpoints.updateCategory:
        return '/category/updateCategory/';
      case Endpoints.addSpecialList:
        return '/specialList/addSpecialList/';
      case Endpoints.getSpeciaLists:
        return '/specialList/';
      case Endpoints.updateSpecialList:
        return '/specialList/updateSpecialList/';
      case Endpoints.deleteSpecialList:
        return '/specialList/';
      case Endpoints.getTasksByDate:
        return '/task/getTasks/';
      case Endpoints.addTask:
        return '/task/addTask/';
      case Endpoints.deleteTask:
        return '/task/deleteTask/';
      case Endpoints.updateTaskOrder:
        return '/task/updateOrder/';
      case Endpoints.getTasksForRoutine:
        return '/task/getTasksForRoutine/';
      case Endpoints.getTasksForSpecialList:
        return '/task/getTasksForSpecialList/';
      case Endpoints.updateSpecialListTaskOrder:
        return '/task/updateSpecialListTaskOrder/';
      case Endpoints.createRoutine:
        return '/routine/addRoutine/';
      case Endpoints.getRoutines:
        return '/routine/getRoutines/';
      case Endpoints.updateRoutine:
        return '/routine/updateRoutine/';
      case Endpoints.deleteRoutine:
        return '/routine/';
      case Endpoints.checkRoutine:
        return '/routine/checkRoutine/';
    }
  }
}

enum WeekDay {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  daily;

  int get dayNumber {
    switch (this) {
      case WeekDay.daily:
        return 0;
      case WeekDay.monday:
        return 1;
      case WeekDay.tuesday:
        return 2;
      case WeekDay.wednesday:
        return 3;
      case WeekDay.thursday:
        return 4;
      case WeekDay.friday:
        return 5;
      case WeekDay.saturday:
        return 6;
      case WeekDay.sunday:
        return 7;
    }
  }

  String get getDayAsString {
    switch (this) {
      case WeekDay.monday:
        return "Monday";
      case WeekDay.tuesday:
        return "Tuesday";
      case WeekDay.wednesday:
        return "Wednesday";
      case WeekDay.thursday:
        return "Thursday";
      case WeekDay.friday:
        return "Friday";
      case WeekDay.saturday:
        return "Saturday";
      case WeekDay.sunday:
        return "Sunday";
      case WeekDay.daily:
        return "Daily";
    }
  }
}

enum MainPages {
  today,
  settings,
  calendar,
  planning,
  dbtc;

  Color get getPageColor {
    switch (this) {
      case MainPages.today:
        return const Color.fromARGB(255, 48, 213, 200);
      case MainPages.settings:
        return Colors.red;
      case MainPages.calendar:
        return Colors.yellow;
      case MainPages.planning:
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
      case MainPages.planning:
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
        return ColorTable.getPositiveColor;
      case SuccessStatus.neutral:
        return ColorTable.getNeutralColor;
      case SuccessStatus.fail:
        return ColorTable.getNegativeColor;
    }
  }
}
