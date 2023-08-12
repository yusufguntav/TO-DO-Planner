import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageBinding.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageView.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenBinding.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenView.dart';
import '../pages/homePage/homeBinding.dart';
import '../pages/homePage/homePageView.dart';
import 'pageRoutes.dart';

class Pages {
  static final pages = [
    GetPage(
      binding: HomePageBinding(),
      name: PageRoutes.home,
      page: () => const HomePageView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      binding: SplashScreenBinding(),
      name: PageRoutes.splash,
      page: () => const SplashScreenView(),
      transition: Transition.noTransition,
    ),
    GetPage(
      binding: AllTaskBinding(),
      name: PageRoutes.allTasks,
      page: () => const AllTaskView(),
      transition: Transition.fadeIn,
    ),
  ];
}
