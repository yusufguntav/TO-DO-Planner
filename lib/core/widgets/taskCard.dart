// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/models/task.dart';

import '../variables/enums.dart';
import '../variables/standartMeasurementUnits.dart';
import 'customLine.dart';
import 'texts/customText.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, this.onTapFunct});
  final TaskModel task;
  final Function? onTapFunct;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: Get.height * .11, minHeight: Get.height * .1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: task.successStatus!.getSuccessStatusColor),
                    borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius)),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
                    child: SingleChildScrollView(
                      child: CustomText(task.task, centerText: true),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        CustomLine(successStatus: task.successStatus),
        InkWell(
          onTap: onTapFunct != null ? () => onTapFunct!(task) : () {},
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: task.successStatus == SuccessStatus.neutral ? null : task.successStatus!.getSuccessStatusColor,
              border: Border.all(color: task.successStatus!.getSuccessStatusColor),
            ),
            child: SizedBox(
              height: Get.height * .1,
              width: Get.width * .15,
              child: Icon(task.successStatus!.getIcon, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
