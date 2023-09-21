// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/colorTable.dart';

import '../../utils/customColorSelectionHandle.dart';
import 'customText.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.isValidController, required this.controller, required this.color, this.label = '', this.required = false});
  final Function? isValidController;
  final TextEditingController? controller;
  final bool required;
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: color,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorTable.getNegativeColor,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorTable.getNegativeColor,
            width: 2.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: color,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
