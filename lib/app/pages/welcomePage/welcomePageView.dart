import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomePage/welcomePageController.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../core/variables/enums.dart';

class WelcomePage extends GetView<WelcomePageController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            wave(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                image(),
                signInButton(),
                SizedBox(height: StandartMeasurementUnits.lowPadding),
                CustomText('or sign up'),
              ],
            ),
            giveFeedback(),
          ],
        )),
      ),
    );
  }

  Positioned giveFeedback() {
    return Positioned(
            bottom: 0,
            child: DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black),
                  ),
                ),
                child: SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: EdgeInsets.all(StandartMeasurementUnits.lowPadding),
                      child: Center(
                        child: CustomText('Give Feedback!'),
                      ),
                    ))),
          );
  }

  ElevatedButton signInButton() {
    return ElevatedButton(
      onPressed: () {
        Get.offAndToNamed(PageRoutes.today);
      },
      style: ElevatedButton.styleFrom(backgroundColor: Pages.today.getPageColor),
      child: CustomText('Sign In', textColor: Colors.white),
    );
  }

  DecoratedBox image() {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(StandartMeasurementUnits.normalRadius),
      ),
      child: SizedBox(
        height: Get.height * .4,
        child: Image.asset(
          'assets/welcomePageImages/image1.png',
          fit: BoxFit.fill,
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
              Pages.today.getPageColor,
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
