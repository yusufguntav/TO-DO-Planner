import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenBinding.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenView.dart';
import 'package:to_do_app/app/pages/welcomePage/welcomePageBinding.dart';
import 'package:to_do_app/app/pages/welcomePage/welcomePageView.dart';
import '../pages/home/homeBinding.dart';
import '../pages/home/homeView.dart';
import 'pageRoutes.dart';

class Pages {
  static final pages = [
    GetPage(
      binding: WelcomePageBinding(),
      name: PageRoutes.welcomePage,
      page: () => const WelcomePage(),
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
