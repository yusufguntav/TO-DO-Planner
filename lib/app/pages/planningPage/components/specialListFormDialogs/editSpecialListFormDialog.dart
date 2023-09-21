// ignore_for_file: file_names

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/dialogs/areYouSureDialog.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';
import '../../planningPageController.dart';

class EditSpecialListFormPage extends GetView<PlanningPageController> {
  const EditSpecialListFormPage({super.key, required this.id, required this.name});
  final String id;
  final String name;
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
            await controller.deleteSpecialList(id);
          },
        ));
      },
      content: Padding(
        padding: EdgeInsets.all(StandartMeasurementUnits.normalPadding),
        child: Form(
          key: controller.editSpecialListFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              nameField(),
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
      controller: (controller.formControlers[FormFields.editSpecialListName] ?? TextEditingController())..text = name,
      color: MainPages.planning.getPageColor,
      label: 'Special List Name',
      required: true,
    );
  }

  CustomButton saveButton() {
    return CustomButton(
      onPress: () async {
        if (controller.editSpecialListFormKey.currentState!.validate()) {
          await controller.updateSpecialList((controller.formControlers[FormFields.editSpecialListName] ?? TextEditingController()).text, id);
        }
      },
      buttonText: 'Save',
      backgroundColor: MainPages.planning.getPageColor,
    );
  }
}
