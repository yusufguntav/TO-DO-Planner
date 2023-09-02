import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/dialogs/customDialog.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../core/variables/standartMeasurementUnits.dart';

class AddCategoryFormDialog extends GetView<AllTaskController> {
  const AddCategoryFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      closeButtonColor: MainPages.allTasks.getPageColor,
      showCloseButton: true,
      content: Form(
        key: controller.getAddCategoryFormKey,
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
              CustomButton(
                buttonText: 'Add Category',
                backgroundColor: MainPages.allTasks.getPageColor,
                onPress: () async {
                  if (controller.getAddCategoryFormKey.currentState!.validate()) {
                    await controller.addCategory(controller.getAddCategoryControllers[FormCategoryFields.name]!.text,
                        controller.getAddCategoryControllers[FormCategoryFields.description]!.text);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  CustomTextFormField categoryDescriptionInput() {
    return CustomTextFormField(
      label: 'Description',
      controller: controller.getAddCategoryControllers[FormCategoryFields.description],
      color: MainPages.allTasks.getPageColor,
    );
  }

  CustomTextFormField categoryNameInput() {
    return CustomTextFormField(
      required: true,
      isValidController: controller.isValidCategoryName,
      label: 'Category Name',
      controller: controller.getAddCategoryControllers[FormCategoryFields.name],
      color: MainPages.allTasks.getPageColor,
    );
  }
}
