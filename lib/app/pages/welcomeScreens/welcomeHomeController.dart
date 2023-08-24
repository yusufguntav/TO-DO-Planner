import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signInPage/signInPage.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/signUpPage/signUpPage.dart';
import 'package:to_do_app/app/pages/welcomeScreens/components/welcomePageView.dart';
import 'package:to_do_app/core/variables/enums.dart';

class WelcomeHomeController extends GetxController {
  final Rx<int> _selectedPage = WelcomePages.welcomePage.getPageNumber.obs;
  final dynamic _pageViews = [
    const WelcomPageView(),
    const SignInPage(),
    const SignUpPage(),
  ];

  Widget getPage() {
    return _pageViews[_selectedPage.value];
  }

  changeSelectedPageIndex(WelcomePages page) {
    _selectedPage.value = page.getPageNumber;
  }
}
