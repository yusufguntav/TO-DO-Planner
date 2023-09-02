// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpService.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';

import '../../../../../core/widgets/texts/customTextFormField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late SignUpPageController controller;

  @override
  void initState() {
    Get.put(SignUpService());
    controller = Get.put(SignUpPageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SignUpService>();
    Get.delete<SignUpPageController>();
    super.dispose();
  }

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
                CustomTextFormField(
                  isValidController: controller.isValidDisplayName,
                  controller: controller.getControllers[SignUpFields.displayName],
                  color: MainPages.today.getPageColor,
                  label: 'Display Name',
                ),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                CustomTextFormField(
                  isValidController: controller.isValidEmail,
                  controller: controller.getControllers[SignUpFields.email],
                  color: MainPages.today.getPageColor,
                  label: 'E-mail',
                ),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                CustomTextFormField(
                  controller: controller.getControllers[SignUpFields.password],
                  isValidController: controller.isValidPassword,
                  color: MainPages.today.getPageColor,
                  label: 'Password',
                ),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                signUpButton(),
              ],
            ),
          ),
        ),
      ),
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
