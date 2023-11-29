// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WelcomeHome extends GetView<WelcomeHomeController> {
  const WelcomeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Obx(() => Get.find<WelcomeHomeController>().selectedPage.value != 0 ? backButton() : const SizedBox()),
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              wave(),
              giveFeedback(),
              Obx(() => controller.getPage()),
            ],
          ),
        ),
      ),
    );
  }

  Padding backButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: StandartMeasurementUnits.normalPadding),
      child: FloatingActionButton(
        elevation: 4,
        backgroundColor: Colors.white,
        onPressed: () => Get.find<WelcomeHomeController>().changeSelectedPageIndex(WelcomePages.welcomePage),
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.theme.primaryColor,
        ),
      ),
    );
  }

  Positioned giveFeedback() {
    return Positioned(
      bottom: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          border: const Border(
            top: BorderSide(color: Colors.black),
          ),
        ),
        child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: EdgeInsets.all(StandartMeasurementUnits.lowPadding),
            child: Center(
              child: CustomText('Give us Feedback'),
            ),
          ),
        ),
      ),
    );
  }

  RotationTransition wave() {
    return RotationTransition(
      turns: const AlwaysStoppedAnimation(180 / 360),
      child: SizedBox(
        height: Get.height,
        child: WaveWidget(
          isLoop: true,
          config: CustomConfig(
            colors: [
              MainPages.today.getPageColor,
            ],
            durations: [
              28000,
            ],
            heightPercentages: [
              .7,
            ],
          ),
          size: const Size(double.infinity, double.infinity),
          waveAmplitude: 0,
        ),
      ),
    );
  }
}
