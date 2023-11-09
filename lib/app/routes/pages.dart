import 'package:get/get.dart';
import '../pages/splashScreen/splashScreenBinding.dart';
import '../pages/splashScreen/splashScreenView.dart';
import '../pages/welcomeScreens/welcomeHomeBinding.dart';
import '../pages/welcomeScreens/welcomeHomeView.dart';
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
      name: PageRoutes.home,
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
