import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/components/specialList/specialListFormDialog.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customButtonCard.dart';
import 'package:to_do_app/core/widgets/customLine.dart';
import 'package:to_do_app/core/widgets/customTileButtonGrill.dart';
import 'package:to_do_app/core/widgets/dateCircle.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import 'components/routinePage/routineDialog.dart';

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
            //Special List
            Obx(() => CustomTileButtonGrill(customTileButtons: createSpecialListButtons())),
            SizedBox(height: StandartMeasurementUnits.highPadding),
            CustomText.high('Routines', textColor: MainPages.planning.getPageColor, bold: true),
            SizedBox(height: StandartMeasurementUnits.extraHighPadding),
            // Routines
            Obx(() => CustomTileButtonGrill(customTileButtons: createRoutineCard())),
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

  List<CustomButtonCard> createRoutineCard() {
    List<CustomButtonCard> routineButtons = [];
    for (var routine in controller.routines) {
      routineButtons.add(
        CustomButtonCard(
          borderColor: MainPages.planning.getPageColor,
          title: routine.name,
          onTapFunction: () {
            controller.selectedRoutine = routine;
            controller.changeSelectedPageIndex(PlanningPages.routinePage);
          },
          editButtonFunc: () {
            controller.selectedRoutine = routine;
            controller.formControlers[FormFields.addRoutineName]!.text = routine.name ?? '';
            // If selectedDay contain daily check all checkbox
            if ((routine.selectedDays?.map((e) => e.dayNumber) ?? []).contains(WeekDay.daily.dayNumber)) {
              for (var i = 0; i < controller.weekdays.length - 1; i++) {
                controller.weekdaySelectControl[controller.weekdays[i]]?.value = true;
              }
            }
            Get.dialog(RoutineDialog(isEditPage: true));
          },
        ),
      );
    }
    routineButtons.add(
      CustomButtonCard(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {
          Get.dialog(const RoutineDialog());
        },
      ),
    );
    return routineButtons;
  }

  List<CustomButtonCard> createSpecialListButtons() {
    List<CustomButtonCard> specialListButtons = [];
    for (var specialList in controller.specialLists) {
      specialListButtons.add(
        CustomButtonCard(
          borderColor: MainPages.planning.getPageColor,
          title: specialList.name,
          onTapFunction: () {
            controller.selectedListModel = specialList;
            controller.changeSelectedPageIndex(PlanningPages.specialListPage);
          },
          editButtonFunc: () {
            controller.selectedListModel = specialList;
            controller.formControlers[FormFields.specialListEndDate]!.text = specialList.date ?? '';
            Get.dialog(SpecialListFormPage(isEditPage: true));
          },
        ),
      );
    }
    specialListButtons.add(
      CustomButtonCard(
        borderColor: MainPages.planning.getPageColor,
        onTapFunction: () {
          Get.dialog(SpecialListFormPage());
        },
      ),
    );
    return specialListButtons;
  }
}
