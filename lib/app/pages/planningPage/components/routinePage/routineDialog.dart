// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/buttons/customButton.dart';
import '../../../../../core/widgets/dialogs/areYouSureDialog.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';
import '../../../../../core/widgets/texts/customTextFormField.dart';

class RoutineDialog extends GetView<PlanningPageController> {
  const RoutineDialog({super.key, this.isEditPage = false});
  final bool isEditPage;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      closeButtonColor: MainPages.planning.getPageColor,
      showCloseButton: true,
      deleteButtonFunction: isEditPage
          ? () {
              Get.dialog(
                AreYourSure(
                  backgroundColor: MainPages.planning.getPageColor,
                  deleteFunc: () {
                    controller.deleteRoutine(controller.selectedRoutine?.id ?? '');
                    controller.clearSelects();
                  },
                ),
              );
            }
          : null,
      closeButtonFunction: () => controller.clearSelects(),
      content: Padding(
        padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
        child: Form(
          key: controller.formKeys[FormKeys.addRoutine],
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                routineField(),
                SizedBox(height: StandartMeasurementUnits.normalPadding),
                Obx(() => customCheckTile(WeekDay.daily)),
                Divider(color: MainPages.planning.getPageColor, thickness: 0.7),
                checkBoxes(),
                addButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox checkBoxes() {
    return SizedBox(
      height: Get.height * .3,
      width: Get.width,
      child: ListView.builder(
        itemCount: controller.weekdays.length - 1,
        itemBuilder: (context, index) => Obx(
          () => customCheckTile(controller.weekdays[index]),
        ),
      ),
    );
  }

  CheckboxListTile customCheckTile(WeekDay weekDay) {
    return CheckboxListTile(
      activeColor: MainPages.planning.getPageColor,
      value: controller.weekdaySelectControl[weekDay]?.value,
      onChanged: (val) {
        //Change checkbox value
        controller.weekdaySelectControl[weekDay]?.value = val ?? false;

        // if a checkbox is false set the daily checkbox to false
        if (val == false) controller.weekdaySelectControl[WeekDay.daily]?.value = false;

        // Change other checkbox if clicked daily checkbox
        if (weekDay == WeekDay.daily) {
          for (var i = 0; i < controller.weekdays.length - 1; i++) {
            controller.weekdaySelectControl[controller.weekdays[i]]?.value = val ?? false;
          }
        }

        // Change daily checkbox if all other checkbox is same
        for (var i = 0; i < controller.weekdays.length - 1; i++) {
          if (controller.weekdaySelectControl[controller.weekdays[i]]?.value == false) break;
          if (i == controller.weekdays.length - 2) controller.weekdaySelectControl[WeekDay.daily]?.value = true;
        }
      },
      title: CustomText(weekDay.getDayAsString),
    );
  }

  CustomButton addButton() {
    return CustomButton(
      onPress: () {
        // Get selected days to variable
        List<int> selectedDays = [];
        // If not selected daily, scan all days
        if ((controller.weekdaySelectControl[WeekDay.daily]?.value ?? false) == false) {
          for (var i = 0; i < controller.weekdays.length - 1; i++) {
            if (controller.weekdaySelectControl[controller.weekdays[i]]?.value ?? false) selectedDays.add(controller.weekdays[i].dayNumber);
          }
        }
        // If daily is selected send just daily
        else {
          selectedDays.add(WeekDay.daily.dayNumber);
        }

        List<int> newSelectedDays = [];
        List<int> unselectedDays = [];
        if (isEditPage) {
          // Get unselected days to variable
          controller.selectedRoutine?.selectedDays?.forEach((element) {
            if (!selectedDays.contains(element.dayNumber)) unselectedDays.add(element.dayNumber);
          });

          // Get new days
          selectedDays.forEach((element) {
            if (!(controller.selectedRoutine?.selectedDays?.map((e) => e.dayNumber) ?? []).contains(element)) newSelectedDays.add(element);
          });
        }

        if (controller.formKeys[FormKeys.addRoutine]!.currentState!.validate()) {
          isEditPage
              ?
              //Save function
              controller.updateRoutine(controller.formControlers[FormFields.addRoutineName]?.text ?? '', controller.selectedRoutine?.id ?? '',
                  unselectedDays, newSelectedDays)
              : () {
                  controller.addRoutine(controller.formControlers[FormFields.addRoutineName]?.text ?? '', selectedDays);
                  controller.clearSelects();
                };
        }
      },
      buttonText: isEditPage ? 'Save' : 'Add Routine',
      backgroundColor: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField routineField() {
    return CustomTextFormField(
      isValidController: controller.isValidName,
      controller: controller.formControlers[FormFields.addRoutineName],
      color: MainPages.planning.getPageColor,
      required: true,
      label: 'Routine Name',
    );
  }
}
