import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeController.dart';

class WelcomeHomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeHomeController());
  }
}
