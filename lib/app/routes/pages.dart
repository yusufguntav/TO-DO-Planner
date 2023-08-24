import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenBinding.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenView.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeBinding.dart';
import 'package:to_do_app/app/pages/welcomeScreens/welcomeHomeView.dart';
import '../pages/home/homeBinding.dart';
import '../pages/home/homeView.dart';
import 'pageRoutes.dart';

class Pages {
  static final pages = [
    GetPage(
      binding: WelcomeHomeBinding(),
      name: PageRoutes.welcomePage,
      page: () => const WelcomeHome(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      binding: HomeBinding(),
      name: PageRoutes.today,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      binding: SplashScreenBinding(),
      name: PageRoutes.splash,
      page: () => const SplashScreenView(),
      transition: Transition.noTransition,
    ),
  ];
}
