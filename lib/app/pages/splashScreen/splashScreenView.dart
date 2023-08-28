// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/splashScreen/splashScreenController.dart';

import '../../../core/variables/enums.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SpinKitFoldingCube(color: MainPages.today.getPageColor)),
    );
  }
}
