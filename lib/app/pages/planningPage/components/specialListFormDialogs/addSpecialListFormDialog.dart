import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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
          key: controller.addSpecialListFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameField(),
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
        if (controller.addSpecialListFormKey.currentState!.validate()) {
          controller.addSpecialList((controller.formControlers[FormFields.addSpecialListName] ?? TextEditingController()).text);
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
}
