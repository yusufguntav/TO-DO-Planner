// ignore_for_file: file_names

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageService.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import 'todayPageController.dart';

class TodayPageView extends StatefulWidget {
  const TodayPageView({super.key});

  @override
  State<TodayPageView> createState() => _TodayPageViewState();
}

class _TodayPageViewState extends State<TodayPageView> {
  late TodayPageController controller;

  @override
  void initState() {
    Get.put(TodayPageService());
    controller = Get.put(TodayPageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<TodayPageService>();
    Get.delete<TodayPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTitle(titleText: "TODAY", titleColor: MainPages.today.getPageColor),
        SizedBox(height: StandartMeasurementUnits.highPadding),
        content(),
        inputFieldAndKeyboardControl()
      ],
    );
  }

  SizedBox inputFieldAndKeyboardControl() {
    return SizedBox(
      height: Get.height * .12,
      child: KeyboardVisibilityBuilder(
        builder: (context, keyboardVisibility) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: keyboardVisibility ? 0 : Get.width * .2),
            Expanded(child: inputTask()),
            addTaskButton(keyboardVisibility),
          ],
        ),
      ),
    );
  }

  Visibility addTaskButton(bool keyboardVisibility) {
    return Visibility(
      visible: keyboardVisibility,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Get.theme.primaryColor),
        child: InkWell(
          onTap: () {},
          child: SizedBox(
            height: Get.height * .08,
            width: keyboardVisibility ? Get.width * .2 : 0,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Expanded content() {
    return Expanded(
      child: Obx(
        () => DragAndDropLists(
          children: controller.contents,
          onItemReorder: controller.onItemReorder,
          onListReorder: controller.onListReorder,
        ),
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
