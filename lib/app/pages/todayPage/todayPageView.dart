// ignore_for_file: file_names

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageController.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

class TodayPageView extends GetView<TodayPageController> {
  const TodayPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTitle(titleText: "TODAY", titleColor: Pages.today.getPageColor),
          SizedBox(height: StandartMeasurementUnits.highPadding),
          content(),
          inputTaskField(),
        ],
      ),
    );
  }

  SizedBox inputTaskField() {
    return SizedBox(
      height: Get.height * .1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: (StandartMeasurementUnits.extraHighPadding * 1.5) + 56),
          Expanded(child: inputTask()),
          SizedBox(width: StandartMeasurementUnits.extraHighPadding),
        ],
      ),
    );
  }

  SizedBox content() {
    return SizedBox(
      height: Get.height * .75,
      //  TODO Obx i daha iyi bir yere koyabilir miyiz ?
      child: Obx(() => DragAndDropLists(
            children: controller.contents,
            onItemReorder: controller.onItemReorder,
            onListReorder: controller.onListReorder,
          )),
    );
  }

  TextField inputTask() {
    return TextField(
      decoration: InputDecoration(
        hintText: "I Will...",
        hintStyle: TextStyle(color: ColorTable.getHintTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
        ),
      ),
    );
  }
}
