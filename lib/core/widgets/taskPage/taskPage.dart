// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';

import '../../models/task.dart';
import '../../variables/standartMeasurementUnits.dart';
import '../taskCard.dart';
import '../texts/customTextFormField.dart';

class TaskPage extends StatelessWidget {
  TaskPage({
    super.key,
    required this.scrollController,
    required this.tasks,
    required this.content,
    required this.addTaskinputField,
    required this.color,
    required this.onReorder,
    required this.saveFunc,
    required this.deleteFunc,
    required this.onTapFunc,
    required this.addTaskFunction,
  });
  final Widget content;
  final Color color;
  final TextEditingController addTaskinputField;
  final ScrollController scrollController;
  final Function? addTaskFunction;
  final Function(int, int) onReorder;
  final Function(TaskModel, String) saveFunc;
  final Function(TaskModel) deleteFunc;
  final Function onTapFunc;
  bool addedNewTask = false;
  final List<TaskModel> tasks;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        content,
        SizedBox(height: StandartMeasurementUnits.extraLowPadding),
        tasksList(),
        inputFieldAndKeyboardControl(),
      ],
    );
  }

  SizedBox inputFieldAndKeyboardControl() {
    return SizedBox(
      width: Get.width -
          (StandartMeasurementUnits.normalPadding +
              (StandartMeasurementUnits.menuButtonSize * .5)),
      height: Get.height * .12,
      child: KeyboardVisibilityBuilder(
        builder: (context, keyboardVisibility) => Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: keyboardVisibility ? 0 : Get.width * .2),
            Expanded(child: inputTask()),
            addTaskButton(keyboardVisibility),
          ],
        ),
      ),
    );
  }

  CustomTextFormField inputTask() {
    return CustomTextFormField(
      controller: addTaskinputField,
      color: color,
      label: "I Will...",
    );
  }

  Visibility addTaskButton(bool keyboardVisibility) {
    return Visibility(
      visible: keyboardVisibility,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: () {
            if (addTaskinputField.text.isNotEmpty) {
              (addTaskFunction ?? () {}).call();
              addedNewTask = true;
            }
          },
          child: SizedBox(
            height: Get.height * .08,
            width: keyboardVisibility ? Get.width * .2 : 0,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  tasksList() {
    return Expanded(
      child: CustomScrollView(
        physics: ClampingScrollPhysics(),
        controller: scrollController,
        slivers: [
          Obx(
            () => ReorderableSliverList(
              buildDraggableFeedback: (context, constraints, child) {
                return Transform(
                  transform: Matrix4.rotationZ(0),
                  alignment: FractionalOffset.topLeft,
                  child: Material(
                    type: MaterialType.transparency,
                    elevation: 6.0,
                    color: Colors.white,
                    borderRadius: BorderRadius.zero,
                    child:
                        ConstrainedBox(constraints: constraints, child: child),
                  ),
                );
              },
              controller: scrollController,
              onReorder: (first, second) {
                onReorder(first, second);
              },
              delegate: ReorderableSliverChildBuilderDelegate(
                childCount: tasks.length + 1,
                (context, index) => Column(children: [
                  tasks.isNotEmpty
                      ? index + 1 == tasks.length + 1
                          ? const SizedBox()
                          : TaskCard(
                              size: StandartMeasurementUnits.taskCardHeight,
                              task: tasks[index],
                              saveFunc: saveFunc,
                              onTapFunc: onTapFunc,
                              deleteFunc: deleteFunc,
                            )
                      : const SizedBox(),
                  SizedBox(height: StandartMeasurementUnits.normalPadding)
                ]),
                semanticIndexCallback: (widget, localIndex) {
                  if (localIndex != tasks.length - 1 && addedNewTask) {
                    scrollController.animateTo(
                      (((Get.height * 0.08) +
                              StandartMeasurementUnits.highPadding) *
                          (tasks.length + 1)),
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    );
                    addedNewTask = false;
                  }
                  return null;
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
