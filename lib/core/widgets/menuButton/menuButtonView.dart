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
      () => controller.showMenuButton
          ? Stack(
              children: [
                //TODO: NASIL YAPILABİLİR ?
                for (int i = 0; i < controller.menuButtons.length; i++) ...[
                  menuButton(controller.menuButtons[i]),
                ],
              ],
            )
          : const SizedBox(),
    );
  }

  AnimatedPositioned menuButton(MenuButtonModel menutButtonModel) {
    return AnimatedPositioned(
      bottom: !controller.centerMenuButton ? StandartMeasurementUnits.ultraPadding : menutButtonModel.bottomPosition,
      left: !controller.centerMenuButton ? StandartMeasurementUnits.normalPadding : menutButtonModel.leftPosition,
      duration: const Duration(milliseconds: 250),
      onEnd: () => controller.showOtherMenuButtons = !controller.showOtherMenuButtons,
      child: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          backgroundColor: menutButtonModel.color,
          heroTag: menutButtonModel.herotag,
          onPressed: () {
            controller.centerMenuButton ? Get.offAndToNamed(menutButtonModel.herotag) : null;
            controller.centerMenuButton = !controller.centerMenuButton;
            controller.selectedMenuTag = menutButtonModel.herotag;
            controller.sortMenuButtonModels();
          },
          child: Icon(menutButtonModel.icon),
        ),
      ),
    );
  }
}
