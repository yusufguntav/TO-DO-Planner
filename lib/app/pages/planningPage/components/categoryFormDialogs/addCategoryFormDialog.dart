// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/dialogs/customDialog.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/standartMeasurementUnits.dart';

class AddCategoryFormDialog extends GetView<PlanningPageController> {
  const AddCategoryFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      closeButtonColor: MainPages.planning.getPageColor,
      showCloseButton: true,
      content: Form(
        key: controller.addCategoryFormKey,
        child: Padding(
          padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              categoryNameInput(),
              SizedBox(height: StandartMeasurementUnits.extraHighPadding),
              categoryDescriptionInput(),
              SizedBox(height: StandartMeasurementUnits.extraHighPadding),
              addCategoryButton()
            ],
          ),
        ),
      ),
    );
  }

  CustomButton addCategoryButton() {
    return CustomButton(
      buttonText: 'Add Category',
      backgroundColor: MainPages.planning.getPageColor,
      onPress: () async {
        if (controller.addCategoryFormKey.currentState!.validate()) {
          await controller.addCategory((controller.formControlers[FormFields.addCategoryName] ?? TextEditingController()).text,
              (controller.formControlers[FormFields.addCategoryDescription] ?? TextEditingController()).text);
        }
      },
    );
  }

  CustomTextFormField categoryDescriptionInput() {
    return CustomTextFormField(
      label: 'Description',
      controller: controller.formControlers[FormFields.addCategoryDescription],
      color: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField categoryNameInput() {
    return CustomTextFormField(
      required: true,
      isValidController: controller.isValidName,
      label: 'Category Name',
      controller: controller.formControlers[FormFields.addCategoryName],
      color: MainPages.planning.getPageColor,
    );
  }
}
