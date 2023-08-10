import 'package:get/get.dart';

import '../pages/homePage/homePageBinding.dart';
import '../pages/homePage/homePageView.dart';
import 'pageRoutes.dart';

class Pages {
  static final pages = [
    GetPage(
      binding: HomePageBinding(),
      name: PageRoutes.homePage,
      page: () => const HomePageView(),
      transition: Transition.noTransition,
    ),
  ];
}
