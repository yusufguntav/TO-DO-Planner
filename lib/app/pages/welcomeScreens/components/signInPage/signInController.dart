// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInService.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';
import 'package:to_do_app/core/network/baseNetworkService.dart';
import 'package:to_do_app/core/services/secure_storage.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../../../core/network/networkModels/requestResponse.dart';

enum SignInFields {
  email,
  password,
}

class SignInPageController extends GetxController {
  // Form Key
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get getFormKey => _formKey;

  // Validation control
  isValidPassword(String? val) {
    if ((val ?? '').length < 6) {
      return 'Password must be longer than 6 characters';
    }
  }

  isValidEmail(String? val) {
    final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val ?? '');
    if (!emailValid) {
      return 'Invalid email';
    }
  }

  // Email and Password Controller
  final Map<SignInFields, TextEditingController> _controllerList = {
    SignInFields.email: TextEditingController(text: 'test@gmail.com'),
    SignInFields.password: TextEditingController(text: '123456'),
  };
  Map<SignInFields, TextEditingController> get getControllers => _controllerList;

  // Network services
  final _signInPageService = Get.find<SignInService>();

  login(String email, String password) async {
    RequestResponse? requestResponse = await _signInPageService.login(email, password);
    if (requestResponse != null) {
      if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
        //Token storage
        await SecureStorage().writeSecureData('token', requestResponse.body['token']);
        BaseNetworkService().header = {"Authorization": "Bearer ${await SecureStorage().readSecureData('token')}"};
        Get.offAndToNamed(PageRoutes.home);
      }
      debugPrint('body: ${requestResponse.body}\n status:${requestResponse.status}');
    }
  }
}
