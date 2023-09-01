// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';

class WelcomeHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeHomeController());
  }
}
