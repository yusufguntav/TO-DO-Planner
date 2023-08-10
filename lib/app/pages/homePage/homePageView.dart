// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/homePage/homePageController.dart';
import 'package:to_do_app/core/models/menuButton.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/scaffold/customScaffold.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScaffoldContentContainer(
        content: Stack(
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  title(),
                  content(),
                  inputTaskField(),
                ],
              ),
            ),
            backgroundBlur(),
            //TODO: NASIL YAPILABİLİR ?
            for (int i = 0; i < controller.getMenuButton.length; i++) ...[Obx(() => menuButton(controller.getMenuButton[i]))]
          ],
        ),
      ),
    );
  }

  Obx backgroundBlur() {
    return Obx(
      () => controller.getCenterMenuButton
          ? InkWell(
              onTap: () => controller.setCenterMenuButton = !controller.getCenterMenuButton,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  SizedBox inputTaskField() {
    return SizedBox(
      height: Get.height * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: (StandartMeasurementUnits.extraHighPadding * 1.5) + 56),
          Expanded(child: inputTask()),
          SizedBox(width: StandartMeasurementUnits.extraHighPadding),
        ],
      ),
    );
  }

  SizedBox content() {
    return SizedBox(
      height: Get.height * .8,
      child: ListView.builder(
        itemBuilder: (context, i) => const Text('data'),
        itemCount: 100,
      ),
    );
  }

  CustomText title() {
    return CustomText.extraHigh(
      "TODAY",
      textColor: ColorTable.getTitleColor,
      bold: true,
      letterSpacing: StandartMeasurementUnits.extraLowPadding,
    );
  }

  TextField inputTask() {
    return TextField(
      decoration: InputDecoration(
        hintText: "I Will...",
        hintStyle: TextStyle(color: ColorTable.getHintTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
        ),
      ),
    );
  }

  AnimatedPositioned menuButton(MenuButtonModel menutButtonModel) {
    return AnimatedPositioned(
      bottom: !controller.getCenterMenuButton ? StandartMeasurementUnits.highPadding : menutButtonModel.bottomPosition,
      left: !controller.getCenterMenuButton ? StandartMeasurementUnits.normalPadding : menutButtonModel.leftPosition,
      duration: const Duration(milliseconds: 250),
      onEnd: () => controller.setshowOtherMenuButtons = !controller.getshowOtherMenuButtons,
      child: SizedBox(
        height: 56,
        width: 56,
        child: FloatingActionButton(
          backgroundColor: menutButtonModel.color,
          heroTag: menutButtonModel.herotag,
          onPressed: () {
            controller.setCenterMenuButton = !controller.getCenterMenuButton;
            controller.setSelectedMenuTag = menutButtonModel.herotag;
            controller.sortMenuButtonModels();
          },
          child: Icon(menutButtonModel.icon),
        ),
      ),
    );
  }
}
