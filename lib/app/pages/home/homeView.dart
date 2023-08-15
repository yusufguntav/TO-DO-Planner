// ignore_for_file: file_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/home/homeController.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/menuButton/menuButtonController.dart';

import '../../../core/widgets/menuButton/menuButtonView.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    MenuButtonController menuButtonController = Get.put(MenuButtonController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            StandartMeasurementUnits.normalPadding,
            StandartMeasurementUnits.normalPadding,
            StandartMeasurementUnits.normalPadding,
            0,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Obx(() => controller.pageViews[menuButtonController.selectedPage]),
              backgroundBlur(menuButtonController),
              const MenuButtonView(),
            ],
          ),
        ),
      ),
    );
  }

  Obx backgroundBlur(MenuButtonController controller) {
    return Obx(
      () => controller.centerMenuButton
          ? InkWell(
              highlightColor: Colors.white,
              onTap: () => controller.centerMenuButton = !controller.centerMenuButton,
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
}
