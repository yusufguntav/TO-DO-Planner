// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/widgets/taskPage/taskPage.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/texts/title.dart';
import '../../planningPageController.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> with WidgetsBindingObserver {
  AppLifecycleState? _appLifecycleState;
  PlanningPageController controller = Get.find<PlanningPageController>();
  @override
  void initState() {
    super.initState();
    // controller.getTasksToVariable(isForRoutine: true);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Future.delayed(Duration.zero, () async {
      // await controller.updateTasksOrder();
      // await controller.deleteTasksFromDB();
      controller.selectedRoutine = null;
    });
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (_appLifecycleState != AppLifecycleState.resumed) {
      // await controller.deleteTasksFromDB();
      // await controller.updateTasksOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => controller.changeSelectedPageIndex(PlanningPages.planningPage),
        child: TaskPage(
          scrollController: controller.scrollController,
          tasks: controller.tasks,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                SizedBox(
                  height: StandartMeasurementUnits.highIconSize * 2,
                  child: CustomTitle(titleText: controller.selectedRoutine?.name?.toUpperCase() ?? '', titleColor: MainPages.planning.getPageColor),
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
            ],
          ),
          addTaskinputField: controller.addTaskinputField,
          color: MainPages.planning.getPageColor,
          onReorder: (firstPosition, newPosition) {
            controller.onListReorder(firstPosition, newPosition);
          },
          saveFunc: (task, text) {
            task.task = text;
            controller.refreshTask;
          },
          deleteFunc: (task) {
            controller.deletedTasks.add(task.id ?? '');
            controller.deleteTaskFromLocale(task);
            controller.tasks.remove(task);
          },
          onTapFunc: controller.changeStatus,
          addTaskFunction: () {
            if (controller.addTaskinputField.text.isNotEmpty) {
              controller.addTask(controller.addTaskinputField.text);
              controller.addTaskinputField.text = '';
            }
          },
        ));
  }
}
