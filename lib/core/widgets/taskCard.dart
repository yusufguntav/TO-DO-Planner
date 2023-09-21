// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/models/task.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/widgets/dialogs/areYouSureDialog.dart';
import 'package:to_do_app/core/widgets/dialogs/customDialog.dart';

import '../variables/enums.dart';
import '../variables/standartMeasurementUnits.dart';
import 'customLine.dart';
import 'texts/customText.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.onTapFunc, required this.deleteFunc});
  final TaskModel task;
  final Function onTapFunc;
  final Function deleteFunc;

  @override
  Widget build(BuildContext context) {
    //TODO Hata var kontrol edilecek
    return Dismissible(
      key: const Key('task'),
      onDismissed: (_) => deleteFunc(task),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
              onTap: () => Get.dialog(taskEditDialog()),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: Get.height * .08),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(color: task.successStatus!.getSuccessStatusColor),
                      borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: StandartMeasurementUnits.lowPadding),
                      child: CustomText(task.task, centerText: true, textOverflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomLine(successStatus: task.successStatus, lineBoxHeight: Get.height * .08, lineBoxWidth: Get.width * .08),
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onTapFunc(task),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.successStatus == SuccessStatus.neutral ? null : task.successStatus!.getSuccessStatusColor,
                border: Border.all(color: task.successStatus!.getSuccessStatusColor),
              ),
              child: SizedBox(
                height: Get.height * .08,
                width: Get.width * .12,
                child: Icon(task.successStatus!.getIcon, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomDialog taskEditDialog() {
    return CustomDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: TextField(
              maxLines: 30,
              controller: TextEditingController(text: task.task),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save'),
                ),
              ),
              SizedBox(width: StandartMeasurementUnits.normalPadding),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: ColorTable.getNegativeColor),
                  onPressed: () => Get.dialog(
                    AreYourSure(
                      backgroundColor: MainPages.today.getPageColor,
                      deleteFunc: () {
                        Get.back();
                        return deleteFunc(task);
                      },
                    ),
                  ),
                  child: const Icon(Icons.delete),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
