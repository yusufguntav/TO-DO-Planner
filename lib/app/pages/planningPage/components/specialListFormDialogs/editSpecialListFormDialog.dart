// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/utils/utils.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/dialogs/areYouSureDialog.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';
import '../../planningPageController.dart';

class EditSpecialListFormPage extends GetView<PlanningPageController> {
  const EditSpecialListFormPage({super.key, required this.specialListModel});
  final SpecialListModel specialListModel;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      closeButtonColor: MainPages.planning.getPageColor,
      showCloseButton: true,
      deleteButtonFunction: () {
        Get.dialog(AreYourSure(
          backgroundColor: MainPages.planning.getPageColor,
          deleteFunc: () async {
            await Get.closeCurrentSnackbar();
            await controller.deleteSpecialList(specialListModel.id!);
          },
        ));
      },
      content: Padding(
        padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
        child: Form(
          key: controller.formKeys[FormKeys.editSpecialList],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameField(),
              SizedBox(height: StandartMeasurementUnits.normalPadding),
              endDateField(),
              SizedBox(height: StandartMeasurementUnits.normalPadding),
              saveButton(),
            ],
          ),
        ),
      ),
    );
  }

  CustomTextFormField nameField() {
    return CustomTextFormField(
      controller: (controller.formControlers[FormFields.editSpecialListName] ?? TextEditingController())..text = specialListModel.name!,
      color: MainPages.planning.getPageColor,
      label: 'Special List Name',
      required: true,
    );
  }

  CustomButton saveButton() {
    return CustomButton(
      onPress: () async {
        if (controller.formKeys[FormKeys.editSpecialList]!.currentState!.validate()) {
          await controller.updateSpecialList((controller.formControlers[FormFields.editSpecialListName] ?? TextEditingController()).text,
              specialListModel.id!, controller.formControlers[FormFields.editSpecialListEndDate]?.text ?? formatDate(DateTime.now()));
        }
      },
      buttonText: 'Save',
      backgroundColor: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField endDateField() {
    return CustomTextFormField(
      isEnable: false,
      onTap: () {
        Future.delayed(Duration.zero).then(
          (value) => Get.dialog(
            Dialog(
              child: Padding(
                padding: EdgeInsets.all(StandartMeasurementUnits.extraHighPadding),
                child: SfDateRangePicker(
                  enablePastDates: false,
                  selectionColor: MainPages.planning.getPageColor,
                  todayHighlightColor: MainPages.planning.getPageColor,
                  rangeSelectionColor: MainPages.planning.getPageColor,
                  onCancel: () => Get.back(),
                  onSubmit: (val) {
                    controller.formControlers[FormFields.editSpecialListEndDate]?.text = val.toString().split(' ')[0];
                    Get.back();
                  },
                  showActionButtons: true,
                  view: DateRangePickerView.month,
                  monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                ),
              ),
            ),
          ),
        );
      },
      // isValidController: controller.isValidName,
      //TODO Düzenlemeyi unutma
      controller: controller.formControlers[FormFields.editSpecialListEndDate],
      color: MainPages.planning.getPageColor,
      label: 'End Date',
    );
  }
}
