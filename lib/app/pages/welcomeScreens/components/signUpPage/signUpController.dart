// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpService.dart';

import '../../../../../core/network/networkModels/requestResponse.dart';
import '../../../../../core/variables/enums.dart';
import '../../../../../core/widgets/dialogs/customSnackbar.dart';
import '../../welcomeHomeController.dart';

enum SignUpFields {
  email,
  password,
  displayName,
}

class SignUpPageController extends GetxController {
  // Form Key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get getFormKey => _formKey;

  // Show password
  final RxBool _showPassword = true.obs;
  bool get showPassword => _showPassword.value;

  showHidePassword() {
    _showPassword.value = !_showPassword.value;
  }

  // Validation control
  isValidPassword(String? val) {
    if ((val ?? '').length < 6) {
      return 'Password must be longer than 6 characters';
    }
  }

  isValidDisplayName(String? val) {
    if ((val ?? '').isEmpty) {
      return 'This field can\'t be empty';
    }
  }

  isValidEmail(String? val) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val ?? '');
    if (!emailValid) {
      return 'Invalid email';
    }
  }

  final Map<SignUpFields, TextEditingController> _controllerList = {
    SignUpFields.email: TextEditingController(text: 'test@gmail.com'),
    SignUpFields.password: TextEditingController(text: '123456'),
    SignUpFields.displayName: TextEditingController(text: 'TestDisplayName'),
  };
  Map<SignUpFields, TextEditingController> get getControllers =>
      _controllerList;

  // Network services
  final _signUpPageService = Get.find<SignUpService>();

  signUp(String email, String password, String displayName) async {
    RequestResponse? requestResponse = await _signUpPageService.signUp(
        email,
        password,
        displayName,
        () => Get.showSnackbar(CustomSnackbar.getSnackBar(
            snackbarText: 'Account created',
            backgrundColor: MainPages.today.getPageColor.withOpacity(.9),
            showFromTop: false)));
    if (requestResponse != null) {
      if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
        Get.find<WelcomeHomeController>()
            .changeSelectedPageIndex(WelcomePages.signIn);
      }
      debugPrint(
          'body: ${requestResponse.body}\n status:${requestResponse.status}');
    }
  }
}
