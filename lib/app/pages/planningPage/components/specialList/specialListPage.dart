import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';

import '../../../../../core/variables/enums.dart';
import '../../../../../core/variables/standartMeasurementUnits.dart';
import '../../../../../core/widgets/taskPage/taskPage.dart';
import '../../../../../core/widgets/texts/title.dart';

class SpecialListPage extends StatefulWidget {
  const SpecialListPage({super.key});

  @override
  State<SpecialListPage> createState() => _SpecialListPageState();
}

class _SpecialListPageState extends State<SpecialListPage>
    with WidgetsBindingObserver {
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
      await controller.deleteTasksFromDB();
      await controller.updateTasksOrder();

      controller.selectedListModel = null;
    });
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
    return PopScope(
        canPop: false,
        onPopInvoked: (_) =>
            controller.changeSelectedPageIndex(PlanningPages.planningPage),
        child: TaskPage(
          scrollController: controller.scrollController,
          tasks: controller.tasks,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(children: [
                SizedBox(
                  height: StandartMeasurementUnits.highIconSize * 2,
                  child: CustomTitle(
                      titleText:
                          controller.selectedListModel?.name?.toUpperCase() ??
                              '',
                      titleColor: MainPages.planning.getPageColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton(
                      elevation: 2,
                      backgroundColor: MainPages.planning.getPageColor,
                      child: const Icon(Icons.arrow_back),
                      onPressed: () {
                        controller.changeSelectedPageIndex(
                            PlanningPages.planningPage);
                      },
                    ),
                  ],
                ),
              ]),
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
