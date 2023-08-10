// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../variables/colorTable.dart';
import '../../variables/standartMeasurementUnits.dart';

class CustomText extends StatelessWidget {
  final String? text;
  double? textSize;
  final Color? textColor;
  final bool underlined;
  final bool lineThrough;
  final bool bold;
  final bool centerText;
  final TextOverflow? textOverflow;
  final double? wordSpacing;
  final double? letterSpacing;
  final int? maxlines;
  CustomText(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key) {
    textSize = StandartMeasurementUnits.normalTextSize;
  }
  CustomText.extraLow(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key) {
    textSize = StandartMeasurementUnits.extraLowTextSize;
  }
  CustomText.low(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key) {
    textSize = StandartMeasurementUnits.lowTextSize;
  }
  CustomText.high(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key) {
    textSize = StandartMeasurementUnits.highTextSize;
  }
  CustomText.extraHigh(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key) {
    textSize = StandartMeasurementUnits.extraHighTextSize;
  }
  CustomText.custom(
    this.text, {
    Key? key,
    this.textColor,
    this.underlined = false,
    this.bold = false,
    this.centerText = false,
    this.textOverflow,
    this.textSize,
    this.maxlines,
    this.lineThrough = false,
    this.wordSpacing,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Text(
        text ?? '',
        style: TextStyle(
          letterSpacing: letterSpacing ?? 0,
          wordSpacing: wordSpacing ?? 0,
          fontSize: textSize ?? StandartMeasurementUnits.normalTextSize,
          color: textColor ?? ColorTable.getTextColor,
          decoration: underlined
              ? TextDecoration.underline
              : lineThrough
                  ? TextDecoration.lineThrough
                  : null,
          fontWeight: bold ? FontWeight.bold : null,
        ),
        textAlign: centerText ? TextAlign.center : null,
        overflow: textOverflow,
        maxLines: maxlines,
      );
}
