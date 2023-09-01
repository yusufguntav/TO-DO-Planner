// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../texts/customText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.buttonText, this.backgroundColor, this.onPress, this.elevation, this.visible});
  final String? buttonText;
  final double? elevation;
  final Color? backgroundColor;
  final bool? visible;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible ?? true,
      child: ElevatedButton(
        onPressed: onPress ?? () {},
        style: ElevatedButton.styleFrom(backgroundColor: backgroundColor, elevation: elevation),
        child: CustomText(buttonText ?? '', textColor: Colors.white),
      ),
    );
  }
}
