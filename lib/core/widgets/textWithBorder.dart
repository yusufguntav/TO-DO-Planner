// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

import '../variables/standartMeasurementUnits.dart';

class TextWithBorder extends StatelessWidget {
  const TextWithBorder({super.key, this.color, this.text, this.bold, this.width});
  final Color? color;
  final String? text;
  final bool? bold;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: StandartMeasurementUnits.taskCardHeight),
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(color: color ?? Get.theme.primaryColor),
            borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius)),
        child: SizedBox(
          width: width,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: StandartMeasurementUnits.lowPadding),
              child: CustomText(
                text,
                centerText: true,
                textOverflow: TextOverflow.ellipsis,
                bold: bold ?? false,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
