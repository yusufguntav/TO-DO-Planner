// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/menuButton/menuButtonController.dart';

import '../../models/menuButton.dart';
import '../../variables/standartMeasurementUnits.dart';

class MenuButtonView extends GetView<MenuButtonController> {
  const MenuButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          for (int i = 0; i < controller.menuButtons.length; i++) ...[
            menuButton(controller.menuButtons[i]),
          ],
        ],
      ),
    );
  }

  AnimatedPositioned menuButton(MenuButtonModel menutButtonModel) {
    return AnimatedPositioned(
      bottom: controller.centerMenuButton ? menutButtonModel.bottomPosition : StandartMeasurementUnits.ultraPadding,
      left: controller.centerMenuButton ? menutButtonModel.leftPosition : StandartMeasurementUnits.lowPadding,
      duration: const Duration(milliseconds: 250),
      onEnd: () => controller.showOtherMenuButtons = !controller.showOtherMenuButtons,
      child: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          backgroundColor: menutButtonModel.color,
          heroTag: menutButtonModel.herotag,
          onPressed: () {
            Get.lazyPut(() => menutButtonModel.controller);
            controller.centerMenuButton = !controller.centerMenuButton;
            controller.selectedPage = menutButtonModel.selectedPageNumber;
            controller.sortMenuButtonModels();
          },
          child: Icon(menutButtonModel.icon),
        ),
      ),
    );
  }
}
