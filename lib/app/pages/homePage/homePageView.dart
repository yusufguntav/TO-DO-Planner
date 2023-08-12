// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import 'homeController.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomTitle(titleText: "TODAY", titleColor: MenuColors.home.getMenuTag),
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
      height: Get.height * .8,
      child: ListView.builder(
        itemBuilder: (context, i) => const Text('data'),
        itemCount: 100,
      ),
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
