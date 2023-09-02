// ignore_for_file: file_names, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTaskService.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/app/pages/allTasksPage/components/editCategoryFormDialog.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customListTileButton.dart';
import 'package:to_do_app/core/widgets/customTileButtonGrill.dart';
import 'package:to_do_app/core/widgets/customLine.dart';
import 'package:to_do_app/core/widgets/dateCircle.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import '../../../core/models/category.dart';
import 'components/addCategoryFormDialog.dart';

class AllTaskView extends StatefulWidget {
  const AllTaskView({super.key});

  @override
  State<AllTaskView> createState() => _AllTaskViewState();
}

class _AllTaskViewState extends State<AllTaskView> {
  late AllTaskController controller;

  @override
  void initState() {
    Get.put(AllTaskService());
    controller = Get.put(AllTaskController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<AllTaskService>();
    Get.delete<AllTaskController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTitle(titleText: 'ALL TASKS', titleColor: MainPages.allTasks.getPageColor),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            CustomText.high('Special Lists', textColor: MainPages.allTasks.getPageColor, bold: true),
            specialListItem(),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            CustomText.high('Categories', textColor: MainPages.allTasks.getPageColor, bold: true),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            Obx(() => CustomTileButtonGrill(customTileButtons: createButtons(controller.categories.value))),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            CustomText.high('DBTC!', textColor: MainPages.allTasks.getPageColor, bold: true),
            dbtcItems(),
          ],
        ),
      ),
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

  List<CustomListTileButton> createButtons(List<CategoryModel> categories) {
    List<CustomListTileButton> categoryButtons = [];
    for (var category in categories) {
      categoryButtons.add(
        CustomListTileButton(
          borderColor: MainPages.allTasks.getPageColor,
          title: category.name,
          onTapFunction: () => Get.dialog(EditCategoryFormDialog(title: category.name ?? '', description: category.description ?? '')),
        ),
      );
    }
    categoryButtons.add(
      CustomListTileButton(
        borderColor: MainPages.allTasks.getPageColor,
        onTapFunction: () {
          Get.dialog(const AddCategoryFormDialog());
        },
      ),
    );
    return categoryButtons;
  }

  CustomListTileButton specialListItem() =>
      CustomListTileButton(borderColor: MainPages.allTasks.getPageColor, topPadding: StandartMeasurementUnits.highPadding);
}
