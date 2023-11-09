// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/dialogs/customDialog.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';

class AddSpecialListFormPage extends GetView<PlanningPageController> {
  const AddSpecialListFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      closeButtonColor: MainPages.planning.getPageColor,
      showCloseButton: true,
      content: Padding(
        padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
        child: Form(
          key: controller.formKeys[FormKeys.addSpecialList],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameField(),
              SizedBox(height: StandartMeasurementUnits.normalPadding),
              endDateField(),
              SizedBox(height: StandartMeasurementUnits.normalPadding),
              addButton(),
            ],
          ),
        ),
      ),
    );
  }

  CustomButton addButton() {
    return CustomButton(
      onPress: () {
        if (controller.formKeys[FormKeys.addSpecialList]!.currentState!.validate()) {
          controller.addSpecialList((controller.formControlers[FormFields.addSpecialListName] ?? TextEditingController()).text,
              controller.formControlers[FormFields.addSpecialListEndDate]?.text ?? DateTime.now().toString().split(' ')[0]);
        }
      },
      buttonText: 'Add Special List',
      backgroundColor: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField nameField() {
    return CustomTextFormField(
      isValidController: controller.isValidName,
      controller: controller.formControlers[FormFields.addSpecialListName],
      color: MainPages.planning.getPageColor,
      required: true,
      label: 'List Name',
    );
  }

  CustomTextFormField endDateField() {
    return CustomTextFormField(
      isEnable: false,
      onTap: () {
        Future.delayed(Duration.zero).then((value) => Get.dialog(Dialog(
                child: Padding(
              padding: EdgeInsets.all(StandartMeasurementUnits.extraHighPadding),
              child: SfDateRangePicker(
                enablePastDates: false,
                //TODO Seçili gün renk değiştirme
                selectionColor: MainPages.planning.getPageColor,
                todayHighlightColor: MainPages.planning.getPageColor,
                rangeSelectionColor: MainPages.planning.getPageColor,
                onCancel: () => Get.back(),
                onSubmit: (val) {
                  controller.formControlers[FormFields.addSpecialListEndDate]?.text = val.toString().split(' ')[0];
                  Get.back();
                },
                showActionButtons: true,
                view: DateRangePickerView.month,
                monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              ),
            ))));
      },
      // isValidController: controller.isValidName,
      //TODO Düzenlemeyi unutma
      controller: controller.formControlers[FormFields.addSpecialListEndDate],
      color: MainPages.planning.getPageColor,
      label: 'End Date',
    );
  }
}
