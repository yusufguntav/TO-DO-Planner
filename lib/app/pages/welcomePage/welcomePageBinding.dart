import 'package:get/get.dart';
import 'package:to_do_app/app/pages/welcomePage/welcomePageController.dart';

class WelcomePageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomePageController());
  }
}
