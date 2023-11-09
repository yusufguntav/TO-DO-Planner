// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/menuButton/menuButtonController.dart';

import '../../models/menuButton.dart';
import '../../variables/standartMeasurementUnits.dart';

class MenuButtonView extends GetView<MenuButtonController> {
  const MenuButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, keyboardVisibility) {
        return !keyboardVisibility
            ? Obx(
                () => Stack(
                  fit: StackFit.expand,
                  children: [
                    for (int i = 0; i < controller.menuButtons.length; i++) ...[
                      menuButton(controller.menuButtons[i]),
                    ],
                  ],
                ),
              )
            : const SizedBox();
      },
    );
  }

  AnimatedPositioned menuButton(MenuButtonModel menutButtonModel) {
    return AnimatedPositioned(
      bottom: controller.centerMenuButton ? menutButtonModel.bottomPosition : StandartMeasurementUnits.ultraPadding,
      left: controller.centerMenuButton ? menutButtonModel.leftPosition : StandartMeasurementUnits.ultraPadding,
      duration: const Duration(milliseconds: 250),
      onEnd: () => controller.showOtherMenuButtons = !controller.showOtherMenuButtons,
      child: SizedBox(
        height: StandartMeasurementUnits.menuButtonSize,
        width: StandartMeasurementUnits.menuButtonSize,
        child: FloatingActionButton(
          backgroundColor: menutButtonModel.color,
          heroTag: menutButtonModel.herotag,
          onPressed: () {
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
