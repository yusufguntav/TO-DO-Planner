import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/textWithBorder.dart';

import '../variables/enums.dart';
import 'customLine.dart';

class RoutineDayCard extends StatelessWidget {
  const RoutineDayCard({super.key, required this.weekDay});
  final WeekDay weekDay;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextWithBorder(
          text: weekDay.getDayAsString,
          color: MainPages.planning.getPageColor,
          bold: true,
          width: Get.width * .2,
        ),
        const CustomLine(),
        Expanded(
          child: TextWithBorder(
            text: 'Routine',
            color: MainPages.planning.getPageColor,
          ),
        )
      ],
    );
  }
}
