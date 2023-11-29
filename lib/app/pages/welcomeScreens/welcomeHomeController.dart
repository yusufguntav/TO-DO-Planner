// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInPage.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpPage.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/welcomePageView.dart';

enum WelcomePages {
  welcomePage,
  signIn,
  signUp;

  int get getPageNumber {
    switch (this) {
      case WelcomePages.welcomePage:
        return 0;
      case WelcomePages.signIn:
        return 1;
      case WelcomePages.signUp:
        return 2;
    }
  }
}

class WelcomeHomeController extends GetxController {
  final Rx<int> selectedPage = WelcomePages.welcomePage.getPageNumber.obs;
  final dynamic _pageViews = [
    const WelcomPageView(),
    const SignInPage(),
    const SignUpPage(),
  ];

  Widget getPage() {
    return _pageViews[selectedPage.value];
  }

  changeSelectedPageIndex(WelcomePages page) {
    selectedPage.value = page.getPageNumber;
  }
}
