// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';

class SplashScreenController extends GetxService {
  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      await Get.offAndToNamed(PageRoutes.welcomePage);
    });
    super.onReady();
  }
}
