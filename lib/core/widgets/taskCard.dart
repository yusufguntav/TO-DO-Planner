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
import 'dialogs/customSnackbar.dart';
import 'texts/customText.dart';

class TaskCard extends StatelessWidget {
  const TaskCard(
      {super.key,
      required this.task,
      required this.onTapFunc,
      required this.deleteFunc,
      required this.saveFunc,
      required this.color,
      this.size});
  final TaskModel task;
  final double? size;
  final Color color;
  final Function onTapFunc;
  final Function(TaskModel, String) saveFunc;
  final Function(TaskModel) deleteFunc;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => deleteFunc(task),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(
                  StandartMeasurementUnits.extraHighRadius),
              onTap: () => Get.dialog(taskEditDialog()),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight:
                        size ?? StandartMeasurementUnits.taskCardHighHeight),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: task.successStatus!.getSuccessStatusColor),
                      borderRadius: BorderRadius.circular(
                          StandartMeasurementUnits.extraHighRadius)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: StandartMeasurementUnits.lowPadding),
                      child: CustomText(
                        task.task,
                        centerText: true,
                        textOverflow: TextOverflow.ellipsis,
                        lineThrough:
                            task.successStatus == SuccessStatus.successful
                                ? true
                                : false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomLine(
              successStatus: task.successStatus,
              lineBoxHeight: Get.height * .08,
              lineBoxWidth: Get.width * .08),
          InkWell(
            customBorder: const CircleBorder(),
            onTap: () => onTapFunc(task),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.successStatus == SuccessStatus.neutral
                    ? null
                    : task.successStatus!.getSuccessStatusColor,
                border: Border.all(
                    color: task.successStatus!.getSuccessStatusColor),
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
    TextEditingController taskController =
        TextEditingController(text: task.task);

    return CustomDialog(
      content: Column(
        children: [
          SizedBox(
            height: Get.height * .5,
            child: TextField(
              maxLines: 30,
              controller: taskController,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: color.withOpacity(.9)),
                  onPressed: () {
                    saveFunc(task, taskController.text);
                    Get.back();
                    Get.showSnackbar(CustomSnackbar.getSnackBar(
                        snackbarText: 'Task Saved',
                        backgrundColor: color.withOpacity(.9),
                        showFromTop: false));
                  },
                  child: const Text('Save'),
                ),
              ),
              SizedBox(width: StandartMeasurementUnits.normalPadding),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorTable.getNegativeColor),
                  onPressed: () => Get.dialog(
                    AreYourSure(
                      backgroundColor: MainPages.today.getPageColor,
                      deleteFunc: () {
                        Get.back();
                        deleteFunc(task);
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
