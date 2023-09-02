import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../variables/enums.dart';
import '../../variables/standartMeasurementUnits.dart';
import '../texts/customText.dart';

class CustomSnackbar extends GetSnackBar {
  const CustomSnackbar({super.key, required this.snackbarText, this.textColor = Colors.white, required this.dialogType});
  final String snackbarText;
  final Color? textColor;
  final DialogType dialogType;
  // TODO Burası nasıl yapılır classlarrrrr bir yere override atılacak ama bulamaıdm
  getSnackbar() => GetSnackBar(
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        borderRadius: StandartMeasurementUnits.highRadius,
        backgroundColor: dialogType.getPageColor,
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
