// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../texts/customText.dart';

class CustomListTileButton extends StatelessWidget {
  const CustomListTileButton({super.key, required this.borderColor, this.title, this.topPadding, this.onTapFunction});
  final Color borderColor;
  final String? title;
  final double? topPadding;
  final Function()? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: ListTile(
        onTap: onTapFunction,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        title: Center(
          child: title != null ? CustomText(title) : const Icon(Icons.add, color: Colors.black87),
        ),
      ),
    );
  }
}
