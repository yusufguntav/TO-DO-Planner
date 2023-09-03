import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/colorTable.dart';
import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/dialogs/customDialog.dart';
import '../../../../../core/widgets/texts/customText.dart';
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
        Get.dialog(areYouSureDialog());
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

  CustomDialog areYouSureDialog() {
    return CustomDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText.high('Are you sure ?', bold: true),
          SizedBox(height: StandartMeasurementUnits.normalPadding),
          CustomText('desc.'),
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
          backgroundColor: MainPages.planning.getPageColor,
          buttonText: 'Delete',
          onPress: () async {
            Get.back();
            await Get.closeCurrentSnackbar();
            await controller.deleteSpecialList(id);
          },
        )
      ],
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
