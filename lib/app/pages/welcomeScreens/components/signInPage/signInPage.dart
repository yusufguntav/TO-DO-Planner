import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

class SignInPage extends GetView<SignInPageController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignInPageController());
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          backButton(),
          SizedBox(height: StandartMeasurementUnits.extraHighPadding),
          TextField(decoration: InputDecoration(label: CustomText('E-mail'))),
          SizedBox(height: StandartMeasurementUnits.extraHighPadding),
          TextField(decoration: InputDecoration(label: CustomText('Password'))),
          SizedBox(height: StandartMeasurementUnits.extraHighPadding),
          signInButton(),
          SizedBox(height: StandartMeasurementUnits.extraHighPadding),
          CustomText('forgot your password?'),
        ],
      ),
    );
  }

  CustomButton signInButton() {
    return CustomButton(
      backgroundColor: MainPages.today.getPageColor,
      onPress: () => Get.offAndToNamed(PageRoutes.today),
      buttonText: 'Sign In',
    );
  }

  Row backButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: () => Get.find<WelcomeHomeController>().changeSelectedPageIndex(WelcomePages.welcomePage),
          child: const Icon(Icons.arrow_back),
        ),
      ],
    );
  }
}
