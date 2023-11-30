// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/models/specialList.dart';
import 'package:to_do_app/core/utils/utils.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/dialogs/areYouSureDialog.dart';
import 'package:to_do_app/core/widgets/dialogs/dateDialog.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';
import '../../planningPageController.dart';

class SpecialListFormPage extends GetView<PlanningPageController> {
  const SpecialListFormPage({super.key, this.specialListModel, this.isEditPage = false});
  final SpecialListModel? specialListModel;
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
                  deleteFunc: () async {
                    await Get.closeCurrentSnackbar();
                    await controller.deleteSpecialList(specialListModel?.id ?? '');
                  },
                ),
              );
            }
          : null,
      content: Padding(
        padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
        child: Form(
          key: controller.formKeys[FormKeys.specialList],
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
      controller: (controller.formControlers[FormFields.specialListName] ?? TextEditingController())..text = specialListModel?.name ?? '',
      color: MainPages.planning.getPageColor,
      label: 'Special List Name',
      isValidController: controller.isValidName,
      required: true,
    );
  }

  CustomButton saveButton() {
    return CustomButton(
      onPress: () async {
        if (controller.formKeys[FormKeys.specialList]!.currentState!.validate()) {
          isEditPage
              ? await controller.updateSpecialList((controller.formControlers[FormFields.specialListName] ?? TextEditingController()).text,
                  specialListModel?.id ?? '', controller.formControlers[FormFields.specialListEndDate]?.text ?? formatDate(DateTime.now()))
              : controller.addSpecialList((controller.formControlers[FormFields.specialListName] ?? TextEditingController()).text,
                  controller.formControlers[FormFields.specialListEndDate]?.text ?? DateTime.now().toString().split(' ')[0]);
        }
      },
      buttonText: isEditPage ? 'Save' : 'Add Special List',
      backgroundColor: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField endDateField() {
    return CustomTextFormField(
      isEnable: false,
      onTap: () {
        Future.delayed(Duration.zero).then(
          (value) => Get.dialog(
            dateDialog(
              color: MainPages.planning.getPageColor,
              onCancel: () => Get.back(),
              onSubmit: (val) {
                if (val != null) controller.formControlers[FormFields.specialListEndDate]?.text = val.toString().split(' ')[0];
                Get.back();
              },
            ),
          ),
        );
      },
      controller: controller.formControlers[FormFields.specialListEndDate],
      color: MainPages.planning.getPageColor,
      label: 'End Date',
    );
  }
}
