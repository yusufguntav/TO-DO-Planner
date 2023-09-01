import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenBinding.dart';
import 'package:to_do_app/core/theme/appTheme.dart';
import 'app/routes/pageRoutes.dart';
import 'app/routes/pages.dart';
import 'core/network/baseNetworkService.dart';

//TODO: Proje sonunda fix all import at
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
}

Future<void> initApp() async {
  Get.put(BaseNetworkService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: PageRoutes.splash,
      initialBinding: SplashScreenBinding(),
      theme: AppTheme.light,
      title: 'TO-DO App',
    );
  }
}
