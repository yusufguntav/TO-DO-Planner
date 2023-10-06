// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageService.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

import '../../../core/widgets/taskCard.dart';
import 'todayPageController.dart';

class TodayPageView extends StatefulWidget {
  const TodayPageView({super.key});

  @override
  State<TodayPageView> createState() => _TodayPageViewState();
}

class _TodayPageViewState extends State<TodayPageView> with WidgetsBindingObserver {
  late TodayPageController controller;
  AppLifecycleState? _appLifecycleState;
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
    //TODO Çalışır mı dene server açılınca
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
        CustomTitle(titleText: "TODAY", titleColor: MainPages.today.getPageColor),
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

  Visibility addTaskButton(bool keyboardVisibility) {
    return Visibility(
      visible: keyboardVisibility,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Get.theme.primaryColor),
        child: InkWell(
          onTap: () {
            if (controller.addTaskinputField.text.isNotEmpty) {
              controller.addTask(controller.addTaskinputField.text).then((value) async => {});
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
                  SizedBox(height: StandartMeasurementUnits.highPadding)
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

  TextField inputTask() {
    return TextField(
      controller: controller.addTaskinputField,
      decoration: InputDecoration(
        hintText: "I Will...",
        hintStyle: TextStyle(color: ColorTable.getHintTextColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius)),
      ),
    );
  }
}
