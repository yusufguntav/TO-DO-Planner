// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

class SignInPage extends GetView<SignInPageController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.find<WelcomeHomeController>().changeSelectedPageIndex(WelcomePages.welcomePage),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: StandartMeasurementUnits.highPadding),
          child: Form(
            key: controller.getFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                backButton(),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                TextFormField(
                    controller: controller.getControllers[SignInFields.email],
                    validator: (val) => controller.isValidEmail(val),
                    decoration: InputDecoration(label: CustomText('E-mail'))),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                TextFormField(
                    controller: controller.getControllers[SignInFields.password],
                    validator: (val) => controller.isValidPassword(val),
                    decoration: InputDecoration(label: CustomText('Password'))),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                signInButton(),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                CustomText('forgot your password?'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CustomButton signInButton() {
    return CustomButton(
      backgroundColor: MainPages.today.getPageColor,
      onPress: () {
        if (controller.getFormKey.currentState!.validate()) {
          controller.login(
            (controller.getControllers[SignInFields.email] ?? TextEditingController(text: '')).text,
            (controller.getControllers[SignInFields.password] ?? TextEditingController(text: '')).text,
          );
          // Get.offAndToNamed(PageRoutes.today);
        }
      },
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
