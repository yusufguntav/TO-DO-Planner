import 'package:flutter/material.dart';

import '../texts/customText.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.buttonText, this.backgroundColor, this.onPress});
  final String? buttonText;
  final Color? backgroundColor;
  final Function()? onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress ?? () {},
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      child: CustomText(buttonText ?? '', textColor: Colors.white),
    );
  }
}
