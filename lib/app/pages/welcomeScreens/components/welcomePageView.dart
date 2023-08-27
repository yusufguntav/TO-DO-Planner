import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpService.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';

import '../../../../core/variables/enums.dart';
import '../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../core/widgets/texts/customText.dart';
import 'signInPage/signInController.dart';
import 'signInPage/signInService.dart';

class WelcomPageView extends StatelessWidget {
  const WelcomPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WelcomeHomeController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image(),
        CustomButton(
          buttonText: 'Sign In',
          backgroundColor: MainPages.today.getPageColor,
          onPress: () {
            Get.put(SignInService());
            Get.put(SignInPageController());
            controller.changeSelectedPageIndex(WelcomePages.signIn);
          },
        ),
        SizedBox(height: StandartMeasurementUnits.lowPadding),
        InkWell(
            onTap: () {
              Get.put(SignUpService());
              Get.put(SignUpPageController());
              controller.changeSelectedPageIndex(WelcomePages.signUp);
            },
            child: CustomText('or sign up')),
      ],
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
}
