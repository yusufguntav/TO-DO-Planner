// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';

class SplashScreenController extends GetxService {
  // checkRoutine() async {
  //   await Get.find<SplashScreenService>().checkRoutine();
  // }

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 1)).then((value) async {
      // TODO Add isRememberMe check
      // await checkRoutine();
      await Get.offAndToNamed(PageRoutes.welcomePage);
    });
    super.onReady();
  }
}
