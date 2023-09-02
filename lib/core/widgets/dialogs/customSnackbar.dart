import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../variables/standartMeasurementUnits.dart';
import '../texts/customText.dart';

class CustomSnackbar extends GetSnackBar {
  const CustomSnackbar({super.key, required this.snackbarText, this.textColor = Colors.white, required this.backgrundColor, this.showFromTop = true});
  final String snackbarText;
  final Color? textColor;
  final bool showFromTop;
  final Color backgrundColor;
  // TODO Burası nasıl yapılır classlarrrrr bir yere override atılacak ama bulamaıdm
  getSnackbar() => GetSnackBar(
        snackPosition: showFromTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: StandartMeasurementUnits.highRadius,
        backgroundColor: backgrundColor,
        maxWidth: Get.width * .8,
        duration: const Duration(seconds: 1),
        margin: EdgeInsets.symmetric(vertical: StandartMeasurementUnits.highPadding),
        messageText: CustomText(
          snackbarText,
          textColor: textColor,
          centerText: true,
        ),
      );
}
