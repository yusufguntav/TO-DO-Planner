import 'package:get/get.dart';
import 'package:to_do_app/app/routes/pageRoutes.dart';

class SplashScreenController extends GetxService {
  @override
  void onReady() {
    Future.delayed(Duration(seconds: 1)).then((value) => Get.offAndToNamed(PageRoutes.home));
    super.onReady();
  }
}
