import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../models/menuButton.dart';

class MenuButtonController extends GetxController {
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

  //Selected menu
  final Rx<String> _selectedMenuTag = PageRoutes.home.obs;
  String get selectedMenuTag => _selectedMenuTag.value;
  set selectedMenuTag(String newValue) => _selectedMenuTag.value = newValue;

  //Create model for menu buttons
  final RxList<MenuButtonModel> _menuButtons = <MenuButtonModel>[
    MenuButtonModel('settings', Icons.settings, MenuColors.settings.getMenuTag, (Get.height + 56) * .5, (Get.width + 56) * .5),
    MenuButtonModel('weekend', Icons.weekend, MenuColors.calendar.getMenuTag, (Get.height - 56 * 3) * .5, (Get.width - 56 * 3) * .5),
    MenuButtonModel('dbtc', Icons.line_axis, MenuColors.dbtc.getMenuTag, (Get.height - 56 * 3) * .5, (Get.width + 56) * .5),
    MenuButtonModel(PageRoutes.allTasks, Icons.task, MenuColors.allTasks.getMenuTag, (Get.height + 56) * .5, (Get.width - 56 * 3) * .5),
    MenuButtonModel(PageRoutes.home, Icons.home, MenuColors.home.getMenuTag, (Get.height - 56) * .5, (Get.width - 56) * .5),
  ].obs;
  RxList<MenuButtonModel> get menuButtons => _menuButtons;

  //Get list of menu button models
  sortMenuButtonModels() {
    MenuButtonModel selectedModel = _menuButtons.where((p0) => p0.herotag == selectedMenuTag).first;
    _menuButtons.remove(selectedModel);
    _menuButtons.add(selectedModel);
    _menuButtons.refresh();
  }
}
