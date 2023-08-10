import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/homePage/homePageBinding.dart';
import 'package:to_do_app/core/theme/appTheme.dart';

import 'app/routes/pageRoutes.dart';
import 'app/routes/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pages.pages,
      initialRoute: PageRoutes.homePage,
      initialBinding: HomePageBinding(),
      theme: AppTheme.light,
      title: 'TO-DO App',
    );
  }
}
