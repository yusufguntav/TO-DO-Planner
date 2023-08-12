import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenBinding.dart';
import 'package:to_do_app/core/theme/appTheme.dart';
import 'package:to_do_app/core/widgets/menuButton/menuButtonController.dart';
import 'package:to_do_app/core/widgets/menuButton/menuButtonView.dart';
import 'package:to_do_app/core/widgets/scaffold/customScaffold.dart';

import 'app/routes/pageRoutes.dart';
import 'app/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
}

Future<void> initApp() async {
  Get.put(MenuButtonController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuButtonController>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: PageRoutes.splash,
      initialBinding: SplashScreenBinding(),
      theme: AppTheme.light,
      title: 'TO-DO App',
      routingCallback: (value) {
        if (value?.current == PageRoutes.splash) return;
        controller.showMenuButton = true;
      },
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(
              builder: (context) => Scaffold(
                body: ScaffoldContentContainer(
                  content: Stack(
                    alignment: Alignment.center,
                    children: [
                      child ?? const SizedBox(),
                      backgroundBlur(controller),
                      const MenuButtonView(),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Obx backgroundBlur(MenuButtonController controller) {
    return Obx(
      () => controller.centerMenuButton
          ? InkWell(
              onTap: () => controller.centerMenuButton = !controller.centerMenuButton,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
