import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:reorderables/reorderables.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/core/widgets/texts/customTextFormField.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/taskCard.dart';
import '../../../../../core/widgets/texts/title.dart';

class SpecialListPage extends StatefulWidget {
  const SpecialListPage({super.key});

  @override
  State<SpecialListPage> createState() => _SpecialListPageState();
}

class _SpecialListPageState extends State<SpecialListPage> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  PlanningPageController controller = Get.find<PlanningPageController>();
  @override
  void initState() {
    super.initState();
    controller.getTasksToVariable();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Future.delayed(Duration.zero, () async {
      await controller.updateTasksOrder();
      await controller.deleteTasksFromDB();
    });
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
        Stack(children: [
          SizedBox(
            height: StandartMeasurementUnits.highIconSize * 2,
            child: CustomTitle(titleText: controller.selectedListModel.name?.toUpperCase() ?? '', titleColor: MainPages.planning.getPageColor),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: MainPages.planning.getPageColor,
                child: const Icon(Icons.arrow_back),
                onPressed: () {
                  controller.changeSelectedPageIndex(PlanningPages.planningPage);
                },
              ),
            ],
          ),
        ]),
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
      color: MainPages.planning.getPageColor,
      label: "I Will...",
    );
  }

  Visibility addTaskButton(bool keyboardVisibility) {
    return Visibility(
      visible: keyboardVisibility,
      child: DecoratedBox(
        decoration: BoxDecoration(shape: BoxShape.circle, color: MainPages.planning.getPageColor),
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
}
