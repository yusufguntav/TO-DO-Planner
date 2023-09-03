// ignore_for_file: file_names, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPage.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/app/pages/planningPage/components/categoryFormDialogs/editCategoryFormDialog.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialListFormDialogs/addSpecialListFormDialog.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialListFormDialogs/editSpecialListFormDialog.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customListTileButton.dart';
import 'package:to_do_app/core/widgets/customTileButtonGrill.dart';
import 'package:to_do_app/core/widgets/customLine.dart';
import 'package:to_do_app/core/widgets/dateCircle.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import '../../../core/models/category.dart';
import 'components/categoryFormDialogs/addCategoryFormDialog.dart';

class PlanningPageView extends StatefulWidget {
  const PlanningPageView({super.key});

  @override
  State<PlanningPageView> createState() => _PlanningPageViewState();
}

class _PlanningPageViewState extends State<PlanningPageView> {
  late PlanningPageController controller;

  @override
  void initState() {
    Get.put(PlanningPageService());
    controller = Get.put(PlanningPageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PlanningPageService>();
    Get.delete<PlanningPageController>();
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
            CustomTitle(titleText: 'PLANNING PAGE', titleColor: MainPages.planning.getPageColor),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            CustomText.high('Special Lists', textColor: MainPages.planning.getPageColor, bold: true),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            Obx(() => CustomTileButtonGrill(customTileButtons: createSpecialListButtons(controller.specialLists.value))),
            SizedBox(height: StandartMeasurementUnits.highPadding),
            CustomText.high('Categories', textColor: MainPages.planning.getPageColor, bold: true),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            Obx(() => CustomTileButtonGrill(customTileButtons: createCategoryButtons(controller.categories.value))),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            CustomText.high('DBTC!', textColor: MainPages.planning.getPageColor, bold: true),
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

  List<CustomListTileButton> createCategoryButtons(List<CategoryModel> categories) {
    List<CustomListTileButton> categoryButtons = [];
    for (var category in categories) {
      categoryButtons.add(CustomListTileButton(
          borderColor: MainPages.planning.getPageColor,
          title: category.name,
          onTapFunction: () =>
              Get.dialog(EditCategoryFormDialog(title: category.name ?? '', description: category.description ?? '', id: category.id ?? ''))));
    }
    categoryButtons.add(
      CustomListTileButton(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {
          Get.dialog(const AddCategoryFormDialog());
        },
      ),
    );
    return categoryButtons;
  }

  List<CustomListTileButton> createSpecialListButtons(List<SpecialListModel> specialLists) {
    List<CustomListTileButton> specialListButtons = [];
    for (var specialList in specialLists) {
      specialListButtons.add(CustomListTileButton(
          borderColor: MainPages.planning.getPageColor,
          title: specialList.name,
          onTapFunction: () => Get.dialog(EditSpecialListFormPage(id: specialList.id ?? '', name: specialList.name ?? ''))));
    }
    specialListButtons.add(
      CustomListTileButton(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {
          Get.dialog(const AddSpecialListFormPage());
        },
      ),
    );
    return specialListButtons;
  }
}
