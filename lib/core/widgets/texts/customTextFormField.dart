// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';

import '../../utils/customColorSelectionHandle.dart';
import 'customText.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.isValidController,
      required this.controller,
      required this.color,
      this.label = '',
      this.required = false,
      this.isEnable,
      this.obscureText,
      this.onTap});
  final Function? isValidController;
  final TextEditingController? controller;
  final bool required;
  final Function()? onTap;
  final bool? isEnable;
  final String label;
  final Color color;
  final bool? obscureText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        obscureText: obscureText ?? false,
        enabled: isEnable,
        selectionControls: CustomColorSelectionHandle(color),
        cursorColor: color,
        controller: controller,
        validator: isValidController != null
            ? (val) => isValidController!(val)
            : (val) {
                return null;
              },
        decoration: InputDecoration(
          label: CustomText(required ? '$label*' : label),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: ColorTable.getNegativeColor,
              width: 2.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: ColorTable.getNegativeColor,
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(StandartMeasurementUnits.normalRadius),
            borderSide: BorderSide(
              color: color,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
