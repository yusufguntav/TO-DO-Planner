// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInController.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInService.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late SignInPageController controller;

  @override
  void initState() {
    Get.put(SignInService());
    controller = Get.put(SignInPageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<SignInService>();
    Get.delete<SignInPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.find<WelcomeHomeController>()
          .changeSelectedPageIndex(WelcomePages.welcomePage),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: StandartMeasurementUnits.highPadding),
          child: Form(
            key: controller.getFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                CustomTextFormField(
                  controller: controller.getControllers[SignInFields.email],
                  isValidController: controller.isValidEmail,
                  color: MainPages.today.getPageColor,
                  label: 'E-mail',
                ),
                SizedBox(height: StandartMeasurementUnits.extraHighPadding),
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            obscureText: controller.showPassword,
                            controller: controller
                                .getControllers[SignInFields.password],
                            isValidController: controller.isValidPassword,
                            color: MainPages.today.getPageColor,
                            label: 'Password',
                          ),
                        ),
                        IconButton(
                            onPressed: () => controller.showHidePassword(),
                            icon: controller.showPassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility))
                      ],
                    )),
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
      onPress: () async {
        if (controller.getFormKey.currentState!.validate()) {
          await controller.login(
            (controller.getControllers[SignInFields.email] ??
                    TextEditingController(text: ''))
                .text,
            (controller.getControllers[SignInFields.password] ??
                    TextEditingController(text: ''))
                .text,
          );
        }
      },
      buttonText: 'Sign In',
    );
  }
}
