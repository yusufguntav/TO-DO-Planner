// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';

import '../../models/menuButton.dart';

class MenuButtonController extends GetxController {
  @override
  void onReady() {
    menuButtons = <MenuButtonModel>[
      MenuButtonModel('settings', MainPages.settings.getPageNumber, Icons.settings, MainPages.settings.getPageColor,
          (Get.height + StandartMeasurementUnits.menuButtonSize) * .5, (Get.width + StandartMeasurementUnits.menuButtonSize) * .5),
      MenuButtonModel('calendar', MainPages.calendar.getPageNumber, Icons.weekend, MainPages.calendar.getPageColor,
          (Get.height - StandartMeasurementUnits.menuButtonSize * 3) * .5, (Get.width - StandartMeasurementUnits.menuButtonSize * 3) * .5),
      MenuButtonModel('dbtc', MainPages.dbtc.getPageNumber, Icons.line_axis, MainPages.dbtc.getPageColor,
          (Get.height - StandartMeasurementUnits.menuButtonSize * 3) * .5, (Get.width + StandartMeasurementUnits.menuButtonSize) * .5),
      MenuButtonModel('planning', MainPages.planning.getPageNumber, Icons.task, MainPages.planning.getPageColor,
          (Get.height + StandartMeasurementUnits.menuButtonSize) * .5, (Get.width - StandartMeasurementUnits.menuButtonSize * 3) * .5),
      MenuButtonModel('today', MainPages.today.getPageNumber, Icons.today, MainPages.today.getPageColor,
          (Get.height - StandartMeasurementUnits.menuButtonSize) * .5, (Get.width - StandartMeasurementUnits.menuButtonSize) * .5),
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
  final Rx<int> _selectedPage = MainPages.today.getPageNumber.obs;
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
