// ignore_for_file: file_names

import 'package:get/get.dart';

import 'homeController.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
