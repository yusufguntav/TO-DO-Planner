// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageView.dart';
import 'package:to_do_app/app/pages/settingsPage/settingsPageController.dart';
import 'package:to_do_app/app/pages/settingsPage/settingsPageView.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageController.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageView.dart';

class HomeController extends GetxController {
  dynamic pageViews = [
    const TodayPageView(),
    const AllTaskView(),
    const SettingsPage(),
  ];
  dynamic pageControllers = [
    TodayPageController(),
    AllTaskController(),
    SettingsPageController(),
  ];
}
