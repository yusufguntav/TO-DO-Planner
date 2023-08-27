import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/enums.dart';

class CircularProgressWhileProcess extends StatelessWidget {
  const CircularProgressWhileProcess({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white60),
      child: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Center(child: SpinKitFoldingCube(color: MainPages.today.getPageColor)),
      ),
    );
  }
}
