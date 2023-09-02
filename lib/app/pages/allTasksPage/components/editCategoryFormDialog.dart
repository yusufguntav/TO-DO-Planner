import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../core/variables/enums.dart';
import '../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../core/widgets/buttons/customButton.dart';
import '../../../../core/widgets/dialogs/customDialog.dart';
import '../../../../core/widgets/texts/customText.dart';

class EditCategoryFormDialog extends GetView<AllTaskController> {
  const EditCategoryFormDialog({super.key, required this.title, required this.description});
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      deleteButtonFunction: () async {
        Get.dialog(areYouSureDialog());
      },
      closeButtonColor: MainPages.allTasks.getPageColor,
      showCloseButton: true,
      actions: [
        CustomButton(
          buttonText: 'Save',
          backgroundColor: MainPages.allTasks.getPageColor,
          onPress: () {
            if (controller.getEditCategoryFormKey.currentState!.validate()) {
              controller.updateCategory(controller.getEditCategoryControllers[FormCategoryFields.name]!.text, title,
                  controller.getEditCategoryControllers[FormCategoryFields.description]!.text);
            }
          },
        )
      ],
      content: Form(
        key: controller.getEditCategoryFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CustomText.high('Name:', bold: true),
                SizedBox(width: StandartMeasurementUnits.normalPadding),
                Expanded(
                  child: CustomTextFormField(
                    required: true,
                    isValidController: controller.isValidCategoryName,
                    label: 'Category Name',
                    controller: controller.getEditCategoryControllers[FormCategoryFields.name]!..text = title,
                    color: MainPages.allTasks.getPageColor,
                  ),
                )
              ],
            ),
            SizedBox(height: StandartMeasurementUnits.normalPadding),
            Row(
              children: [
                CustomText.high('Description:', bold: true),
                SizedBox(width: StandartMeasurementUnits.normalPadding),
                Expanded(
                  child: CustomTextFormField(
                    label: 'Description',
                    controller: controller.getEditCategoryControllers[FormCategoryFields.description]!..text = description,
                    color: MainPages.allTasks.getPageColor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  CustomDialog areYouSureDialog() {
    return CustomDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.high('Are you sure', bold: true),
          SizedBox(height: StandartMeasurementUnits.normalPadding),
          CustomText('The category information of tasks belonging to this category will be deleted.'),
        ],
      ),
      actions: [
        CustomButton(
          backgroundColor: ColorTable.getNegativeColor,
          buttonText: 'Cancel',
          onPress: () => Get.back(),
        ),
        SizedBox(width: StandartMeasurementUnits.normalPadding),
        CustomButton(
          backgroundColor: MainPages.allTasks.getPageColor,
          buttonText: 'Delete',
          onPress: () async {
            Get.back();
            await Get.closeCurrentSnackbar();
            await controller.deleteCategory(title);
          },
        )
      ],
    );
  }
}
