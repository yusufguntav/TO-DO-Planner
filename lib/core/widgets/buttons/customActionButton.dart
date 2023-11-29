// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../variables/standartMeasurementUnits.dart';
import '../textWithBorder.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({super.key, this.color, this.text, this.onTap});
  final String? text;
  final Color? color;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
      onTap: onTap,
      child: TextWithBorder(
        text: text,
        color: color,
        bold: true,
      ),
    );
  }
}
