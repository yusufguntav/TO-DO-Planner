import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/circularProgressWhileProcess.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

class SignUpPage extends GetView<SignUpPageController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.find<WelcomeHomeController>().changeSelectedPageIndex(WelcomePages.welcomePage),
      child: Stack(alignment: Alignment.center, children: [
        SingleChildScrollView(
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
                      validator: (val) => controller.isValidDisplayName(val),
                      controller: controller.getControllers[SignUpFields.displayName],
                      decoration: InputDecoration(label: CustomText('Display Name'))),
                  SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                  TextFormField(
                      validator: (val) => controller.isValidEmail(val),
                      controller: controller.getControllers[SignUpFields.email],
                      decoration: InputDecoration(label: CustomText('E-mail'))),
                  SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                  TextFormField(
                      validator: (val) => controller.isValidPassword(val),
                      controller: controller.getControllers[SignUpFields.password],
                      decoration: InputDecoration(label: CustomText('Password'))),
                  SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                  signUpButton(),
                ],
              ),
            ),
          ),
        ),
        Obx(() => controller.showProgressIndicator.value ? const CircularProgressWhileProcess() : const SizedBox()),
      ]),
    );
  }

  CustomButton signUpButton() {
    return CustomButton(
      backgroundColor: MainPages.today.getPageColor,
      onPress: () {
        if (controller.getFormKey.currentState!.validate()) {
          controller.signUp(
              (controller.getControllers[SignUpFields.email] ?? TextEditingController(text: '')).text,
              (controller.getControllers[SignUpFields.password] ?? TextEditingController(text: '')).text,
              (controller.getControllers[SignUpFields.displayName] ?? TextEditingController(text: '')).text);
        }
      },
      buttonText: 'Sign Up',
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
