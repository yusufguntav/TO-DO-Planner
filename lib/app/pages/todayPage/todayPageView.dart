// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../core/variables/standartMeasurementUnits.dart';
import '../../../core/widgets/taskCard.dart';
import '../../../core/widgets/texts/customTextFormField.dart';
import '../../../core/widgets/texts/title.dart';
import 'todayPageService.dart';

class TodayPageView extends StatefulWidget {
  const TodayPageView({super.key});

  @override
  State<TodayPageView> createState() => _TodayPageViewState();
}

class _TodayPageViewState extends State<TodayPageView> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  late TodayPageController controller;
  @override
  void initState() {
    super.initState();
    Get.put(TodayPageService());
    controller = Get.put(TodayPageController());
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Get.delete<TodayPageService>();
    Get.delete<TodayPageController>();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (_appLifecycleState != AppLifecycleState.resumed) {
      await controller.deleteTasksFromDB();
      await controller.updateTasksOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: StandartMeasurementUnits.highIconSize * 2,
          child: CustomTitle(titleText: 'TODAY', titleColor: MainPages.today.getPageColor),
        ),
        SizedBox(height: StandartMeasurementUnits.highPadding),
        content(),
        inputFieldAndKeyboardControl()
      ],
    );
  }

  SizedBox inputFieldAndKeyboardControl() {
    return SizedBox(
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
      controller: controller.addTaskinputField,
      color: MainPages.today.getPageColor,
      label: "I Will...",
    );
  }

  Visibility addTaskButton(bool keyboardVisibility) {
    return Visibility(
      visible: keyboardVisibility,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Get.theme.primaryColor),
        child: InkWell(
          onTap: () {
            if (controller.addTaskinputField.text.isNotEmpty) {
              controller.addTask(controller.addTaskinputField.text);
              controller.addTaskinputField.text = '';
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

  content() {
    return Expanded(
      child: CustomScrollView(
        controller: controller.scrollController,
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
                    child: ConstrainedBox(constraints: constraints, child: child),
                  ),
                );
              },
              controller: controller.scrollController,
              onReorder: (firstPosition, newPosition) {
                controller.onListReorder(firstPosition, newPosition);
              },
              delegate: ReorderableSliverChildBuilderDelegate(
                childCount: controller.tasks.length + 1,
                (context, index) => Column(children: [
                  controller.tasks.isNotEmpty
                      ? index + 1 == controller.tasks.length + 1
                          ? const SizedBox()
                          : TaskCard(
                              task: controller.tasks[index],
                              saveFunc: (task, text) {
                                task.task = text;
                                controller.refreshTask;
                              },
                              onTapFunc: controller.changeStatus,
                              deleteFunc: (task) {
                                controller.deletedTasks.add(task.id ?? '');
                                controller.deleteTaskFromLocale(task);
                                controller.tasks.remove(task);
                              },
                            )
                      : const SizedBox(),
                  SizedBox(height: StandartMeasurementUnits.normalPadding)
                ]),
                semanticIndexCallback: (widget, localIndex) {
                  debugPrint(localIndex.toString());
                  if (localIndex != controller.tasks.length - 1 && controller.addedNewTask) {
                    controller.scrollController.animateTo(
                      (((Get.height * 0.08) + StandartMeasurementUnits.highPadding) * (controller.tasks.length + 1)),
                      duration: const Duration(milliseconds: 5),
                      curve: Curves.easeInOut,
                    );
                    controller.addedNewTask = false;
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
