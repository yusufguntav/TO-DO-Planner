// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenController.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController());
    // Get.lazyPut(() => SplashScreenService());
  }
}
