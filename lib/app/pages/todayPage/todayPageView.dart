// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/taskPage/taskPage.dart';

import '../../../core/variables/standartMeasurementUnits.dart';
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
    return TaskPage(
      scrollController: controller.scrollController,
      tasks: controller.tasks,
      content: Column(
        children: [
          SizedBox(
            height: StandartMeasurementUnits.highIconSize * 2,
            child: CustomTitle(titleText: 'TODAY', titleColor: MainPages.today.getPageColor),
          ),
          SizedBox(height: StandartMeasurementUnits.highPadding),
        ],
      ),
      addTaskFunction: () {
        if (controller.addTaskinputField.text.isNotEmpty) {
          controller.addTask(controller.addTaskinputField.text);
          controller.addTaskinputField.text = '';
        }
      },
      addTaskinputField: controller.addTaskinputField,
      color: MainPages.today.getPageColor,
      onReorder: controller.onListReorder,
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
    );
  }
}
