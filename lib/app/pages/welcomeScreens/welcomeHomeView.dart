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
