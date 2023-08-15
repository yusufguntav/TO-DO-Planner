// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageView.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../app/routes/pageRoutes.dart';
import '../../models/menuButton.dart';

class MenuButtonController extends GetxController {
  @override
  void onReady() {
    menuButtons = <MenuButtonModel>[
      MenuButtonModel(
          'settings', null, Pages.settings.getPageNumber, Icons.settings, Pages.settings.getPageColor, (Get.height + 56) * .5, (Get.width + 56) * .5),
      MenuButtonModel('calendar', null, Pages.calendar.getPageNumber, Icons.weekend, Pages.calendar.getPageColor, (Get.height - 56 * 3) * .5,
          (Get.width - 56 * 3) * .5),
      MenuButtonModel(
          'dbtc', null, Pages.dbtc.getPageNumber, Icons.line_axis, Pages.dbtc.getPageColor, (Get.height - 56 * 3) * .5, (Get.width + 56) * .5),
      MenuButtonModel(PageRoutes.allTasks, AllTaskController(), Pages.allTasks.getPageNumber, Icons.task, Pages.allTasks.getPageColor,
          (Get.height + 56) * .5, (Get.width - 56 * 3) * .5),
      MenuButtonModel(PageRoutes.today, TodayPageController(), Pages.today.getPageNumber, Icons.today, Pages.today.getPageColor,
          (Get.height - 56) * .5, (Get.width - 56) * .5),
    ];
    super.onReady();
  }

  //Show menu button control
  final Rx<bool> _showMenuButton = false.obs;
  bool get showMenuButton => _showMenuButton.value;
  set showMenuButton(bool newValue) => _showMenuButton.value = newValue;

  final Rx<bool> _centerMenuButton = false.obs;
  bool get centerMenuButton => _centerMenuButton.value;
  set centerMenuButton(bool newValue) => _centerMenuButton.value = newValue;

  final Rx<bool> _showOtherMenuButtons = false.obs;
  bool get showOtherMenuButtons => _showOtherMenuButtons.value;
  set showOtherMenuButtons(bool newValue) => _showOtherMenuButtons.value = newValue;

  // Selected page
  final Rx<int> _selectedPage = Pages.today.getPageNumber.obs;
  int get selectedPage => _selectedPage.value;
  set selectedPage(int newValue) => _selectedPage.value = newValue;

  //Create model for menu buttons
  final RxList<MenuButtonModel> _menuButtons = <MenuButtonModel>[].obs;
  RxList<MenuButtonModel> get menuButtons => _menuButtons;
  set menuButtons(List<MenuButtonModel> newMenuButtons) => _menuButtons.value = newMenuButtons;
  //Get list of menu button models
  sortMenuButtonModels() {
    MenuButtonModel selectedModel = _menuButtons.where((p0) => p0.selectedPageNumber == selectedPage).first;
    _menuButtons.remove(selectedModel);
    _menuButtons.add(selectedModel);
    _menuButtons.refresh();
  }
}
