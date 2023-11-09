// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageHome.dart';
import 'package:to_do_app/app/pages/settingsPage/settingsPageView.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageView.dart';

class HomeController extends GetxController {
  dynamic pageViews = [
    const TodayPageView(),
    const PlanningPageHome(),
    const SettingsPage(),
  ];
}
