import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/alertDialog/customDialog.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';

import '../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../core/widgets/texts/customText.dart';

class AddCategoryFormDialog extends GetView<AllTaskController> {
  const AddCategoryFormDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
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
              CustomButton(
                buttonText: 'Add Category',
                backgroundColor: MainPages.allTasks.getPageColor,
                onPress: () async {
                  if (controller.getAddCategoryFormKey.currentState!.validate()) {
                    if (Get.isOverlaysOpen) Get.back();
                    await controller.addCategory(controller.getAddCategoryControllers[AddCategoryFields.name]!.text);

                    //TODO Neden son ekleneni getir miyor ?
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField categoryNameInput() {
    return TextFormField(
      //TODO Cursor altındaki bubble rengi nasıl değiştrilir
      cursorColor: MainPages.allTasks.getPageColor,
      controller: controller.getAddCategoryControllers[AddCategoryFields.name],
      validator: (val) => controller.isValidCategoryName(val),
      decoration: InputDecoration(
        label: CustomText('Category Name'),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: MainPages.allTasks.getPageColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: MainPages.allTasks.getPageColor,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
