// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/models/menuButton.dart';
import 'package:to_do_app/core/variables/enums.dart';

class HomePageController extends GetxController {
  final Rx<bool> _centerMenuButton = false.obs;
  bool get getCenterMenuButton => _centerMenuButton.value;
  set setCenterMenuButton(bool newValue) => _centerMenuButton.value = newValue;

  final Rx<bool> _showOtherMenuButtons = false.obs;
  bool get getshowOtherMenuButtons => _showOtherMenuButtons.value;
  set setshowOtherMenuButtons(bool newValue) => _showOtherMenuButtons.value = newValue;

  //Selected menu
  final Rx<String> _selectedMenuTag = MenuTitles.home.getMenuHeroTag.obs;
  String get getSelectedMenuTag => _selectedMenuTag.value;
  set setSelectedMenuTag(String newValue) => _selectedMenuTag.value = newValue;

  //Create model for menu buttons
  final RxList<MenuButtonModel> _menuButtons = <MenuButtonModel>[
    MenuButtonModel(MenuTitles.settings.getMenuHeroTag, Icons.settings, Colors.red, (Get.height + 56) * .5, (Get.width + 56) * .5),
    MenuButtonModel(MenuTitles.calendar.getMenuHeroTag, Icons.weekend, Colors.purple, (Get.height - 56 * 3) * .5, (Get.width - 56 * 3) * .5),
    MenuButtonModel(MenuTitles.dbtc.getMenuHeroTag, Icons.line_axis, Colors.yellow, (Get.height - 56 * 3) * .5, (Get.width + 56) * .5),
    MenuButtonModel(MenuTitles.home.getMenuHeroTag, Icons.home, null, (Get.height - 56) * .5, (Get.width - 56) * .5),
    MenuButtonModel(MenuTitles.allTasks.getMenuHeroTag, Icons.task, Colors.green, (Get.height + 56) * .5, (Get.width - 56 * 3) * .5)
  ].obs;
  RxList<MenuButtonModel> get getMenuButton => _menuButtons;

  //Get list of menu button models
  sortMenuButtonModels() {
    MenuButtonModel selectedModel = _menuButtons.where((p0) => p0.herotag == getSelectedMenuTag).first;
    _menuButtons.remove(selectedModel);
    _menuButtons.add(selectedModel);
    _menuButtons.refresh();
  }
}
