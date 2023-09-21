// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/widgets/dialogs/areYouSureDialog.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/buttons/customButton.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';

class EditCategoryFormDialog extends GetView<PlanningPageController> {
  const EditCategoryFormDialog({super.key, required this.title, required this.description, required this.id});
  final String title;
  final String id;
  final String description;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      deleteButtonFunction: () async {
        Get.dialog(AreYourSure(
          backgroundColor: MainPages.planning.getPageColor,
          deleteFunc: () async {
            await Get.closeCurrentSnackbar();
            await controller.deleteCategory(id);
          },
        ));
      },
      closeButtonColor: MainPages.planning.getPageColor,
      showCloseButton: true,
      actions: [saveButton()],
      content: Form(
        key: controller.editCategoryFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            nameField(),
            SizedBox(height: StandartMeasurementUnits.normalPadding),
            descriptionField(),
          ],
        ),
      ),
    );
  }

  CustomTextFormField descriptionField() {
    return CustomTextFormField(
      label: 'Description',
      controller: (controller.formControlers[FormFields.editCategoryDescription] ?? TextEditingController())..text = description,
      color: MainPages.planning.getPageColor,
    );
  }

  CustomTextFormField nameField() {
    return CustomTextFormField(
      required: true,
      isValidController: controller.isValidName,
      label: 'Category Name',
      controller: (controller.formControlers[FormFields.editCategoryName] ?? TextEditingController())..text = title,
      color: MainPages.planning.getPageColor,
    );
  }

  CustomButton saveButton() {
    return CustomButton(
      buttonText: 'Save',
      backgroundColor: MainPages.planning.getPageColor,
      onPress: () {
        if (controller.editCategoryFormKey.currentState!.validate()) {
          controller.updateCategory((controller.formControlers[FormFields.editCategoryName] ?? TextEditingController()).text, id,
              (controller.formControlers[FormFields.editCategoryDescription] ?? TextEditingController()).text);
        }
      },
    );
  }
}
