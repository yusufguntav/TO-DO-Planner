// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customListTileButton.dart';
import 'package:to_do_app/core/widgets/customLine.dart';
import 'package:to_do_app/core/widgets/dateCircle.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

class AllTaskView extends GetView<AllTaskController> {
  const AllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomTitle(titleText: 'ALL TASKS', titleColor: Pages.allTasks.getPageColor),
        SizedBox(height: StandartMeasurementUnits.extraHighPadding),
        CustomText.high('Special Lists', textColor: Pages.allTasks.getPageColor, bold: true),
        specialListItem(),
        SizedBox(height: StandartMeasurementUnits.extraHighPadding),
        CustomText.high('Categories', textColor: Pages.allTasks.getPageColor, bold: true),
        categoryItems(),
        categoryItems2(),
        SizedBox(height: StandartMeasurementUnits.extraHighPadding),
        CustomText.high('DBTC!', textColor: Pages.allTasks.getPageColor, bold: true),
        dbtcItems()
      ],
    );
  }

  SizedBox dbtcItems() {
    return SizedBox(
      height: Get.height * .1,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (int i = 0; i < 20; i++) ...[
            DateCircle(
              day: i + 1,
              successStatus: i == 15
                  ? SuccessStatus.today
                  : i > 14
                      ? SuccessStatus.neutral
                      : SuccessStatus.successful,
            ),
            CustomLine(
              successStatus: i == 14 || i == 15
                  ? SuccessStatus.today
                  : i > 14
                      ? SuccessStatus.neutral
                      : SuccessStatus.successful,
            ),
          ]
        ],
      ),
    );
  }

  CustomListTileButton specialListItem() =>
      CustomListTileButton(borderColor: Pages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding);

  Row categoryItems2() {
    return Row(
      children: [
        Expanded(
          child:
              CustomListTileButton(borderColor: Pages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding, title: 'Side Project'),
        ),
        SizedBox(width: StandartMeasurementUnits.highPadding),
        Expanded(
          child: CustomListTileButton(borderColor: Pages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding),
        ),
      ],
    );
  }

  Row categoryItems() {
    return Row(
      children: [
        Expanded(
          child: CustomListTileButton(borderColor: Pages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding, title: 'Housework'),
        ),
        SizedBox(width: StandartMeasurementUnits.highPadding),
        Expanded(
          child: CustomListTileButton(borderColor: Pages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding, title: 'Work'),
        ),
      ],
    );
  }
}
