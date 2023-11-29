// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/textWithBorder.dart';

import '../variables/enums.dart';
import 'customLine.dart';

class RoutineDayCard extends StatelessWidget {
  const RoutineDayCard({super.key, required this.weekDay, this.routine, required this.onTap});
  final WeekDay weekDay;
  final String? routine;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWithBorder(
          text: weekDay.getDayAsString,
          color: MainPages.planning.getPageColor,
          bold: true,
          width: Get.width * .25,
        ),
        const CustomLine(),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
            onTap: () => onTap(),
            child: TextWithBorder(
              text: routine,
              color: MainPages.planning.getPageColor,
            ),
          ),
        )
      ],
    );
  }
}
