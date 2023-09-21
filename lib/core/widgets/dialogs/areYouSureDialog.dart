// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../variables/colorTable.dart';
import '../../variables/standartMeasurementUnits.dart';
import '../buttons/customButton.dart';
import '../texts/customText.dart';
import 'customDialog.dart';

class AreYourSure extends StatelessWidget {
  const AreYourSure({super.key, required this.backgroundColor, required this.deleteFunc});
  final Function deleteFunc;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.high('Are you sure ?', bold: true),
          SizedBox(height: StandartMeasurementUnits.normalPadding),
          CustomText('desc.'),
        ],
      ),
      actions: [
        CustomButton(
          backgroundColor: ColorTable.getNegativeColor,
          buttonText: 'Cancel',
          onPress: () => Get.back(),
        ),
        SizedBox(width: StandartMeasurementUnits.normalPadding),
        CustomButton(
          backgroundColor: backgroundColor,
          buttonText: 'Delete',
          onPress: () {
            Get.back();
            return deleteFunc();
          },
        )
      ],
    );
  }
}
//  Get.back();
//             await Get.closeCurrentSnackbar();
//             await controller.deleteSpecialList(id);