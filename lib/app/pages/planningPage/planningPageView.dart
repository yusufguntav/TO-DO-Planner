// ignore_for_file: file_names, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialListFormDialogs/addSpecialListFormDialog.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialListFormDialogs/editSpecialListFormDialog.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButtonCard.dart';
import 'package:to_do_app/core/widgets/customLine.dart';
import 'package:to_do_app/core/widgets/customTileButtonGrill.dart';
import 'package:to_do_app/core/widgets/dateCircle.dart';
import 'package:to_do_app/core/widgets/routineDayCard.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import '../../../core/models/routines.dart';

class PlanningPageView extends StatefulWidget {
  const PlanningPageView({super.key});

  @override
  State<PlanningPageView> createState() => _PlanningPageViewState();
}

class _PlanningPageViewState extends State<PlanningPageView> {
  late PlanningPageController controller;

  @override
  void initState() {
    controller = Get.find<PlanningPageController>();
    super.initState();
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
            CustomText.high('Routines', textColor: MainPages.planning.getPageColor, bold: true),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            const RoutineDayCard(weekDay: WeekDay.monday),
            const RoutineDayCard(weekDay: WeekDay.tuesday),
            const RoutineDayCard(weekDay: WeekDay.wednesday),
            const RoutineDayCard(weekDay: WeekDay.thursday),
            const RoutineDayCard(weekDay: WeekDay.friday),
            const RoutineDayCard(weekDay: WeekDay.saturday),
            const RoutineDayCard(weekDay: WeekDay.sunday),
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

  List<CustomButtonCard> createCategoryButtons(List<RoutineModel> categories) {
    List<CustomButtonCard> categoryButtons = [];
    for (var category in categories) {
      categoryButtons.add(CustomButtonCard(borderColor: MainPages.planning.getPageColor, title: category.name, onTapFunction: () {}));
    }
    categoryButtons.add(
      CustomButtonCard(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {},
      ),
    );
    return categoryButtons;
  }

  List<CustomButtonCard> createSpecialListButtons(List<SpecialListModel> specialLists) {
    List<CustomButtonCard> specialListButtons = [];
    for (var specialList in specialLists) {
      specialListButtons.add(
        CustomButtonCard(
          borderColor: MainPages.planning.getPageColor,
          title: specialList.name,
          onTapFunction: () {
            controller.selectedListModel = specialList;
            controller.changeSelectedPageIndex(PlanningPages.specialListPage);
          },
          editButtonFunc: () {
            controller.formControlers[FormFields.editSpecialListEndDate]!.text = specialList.date ?? '';
            Get.dialog(EditSpecialListFormPage(specialListModel: specialList));
          },
        ),
      );
    }
    specialListButtons.add(
      CustomButtonCard(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {
          Get.dialog(const AddSpecialListFormPage());
        },
      ),
    );
    return specialListButtons;
  }
}
