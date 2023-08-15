// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/enums.dart';

import 'texts/customText.dart';

class DateCircle extends StatelessWidget {
  const DateCircle({super.key, this.successStatus, required this.day});
  final SuccessStatus? successStatus;
  final int day;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: successStatus != null ? successStatus!.getSuccessStatusColor : SuccessStatus.neutral.getSuccessStatusColor, shape: BoxShape.circle),
      child: SizedBox(
        height: Get.height * .1,
        width: Get.width * .1,
        child: Center(
            child: CustomText(
          day.toString(),
          textColor: Colors.white,
        )),
      ),
    );
  }
}
