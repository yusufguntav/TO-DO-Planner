// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/todayPage/todayPageService.dart';
import 'package:to_do_app/core/models/task.dart';
import 'package:to_do_app/core/utils/utils.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../core/network/networkModels/requestResponse.dart';

class TodayPageController extends GetxController {
  //ScrollController for task list
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  bool addedNewTask = false;

  //AddTask Field Controller
  final TextEditingController _addTaskinputField = TextEditingController();
  TextEditingController get addTaskinputField => _addTaskinputField;

  //Task List control
  final RxList<TaskModel> _tasks = <TaskModel>[].obs;
  List<TaskModel> get tasks => _tasks;

  //Deleted Tasks
  final RxList<String> _deletedTasks = <String>[].obs;
  List<String> get deletedTasks => _deletedTasks;

  //New Tasks
  final RxList<TaskModel> _newTasks = <TaskModel>[].obs;
  List<TaskModel> get newTasks => _newTasks;

  //Refresh Task
  get refreshTask => _tasks.refresh();

  @override
  void onClose() async {
    // delete, update tasks from Database
    await deleteTasksFromDB();
    await updateTasksOrder();
    super.onClose();
  }

  @override
  void onInit() async {
    _todayPageService = Get.find<TodayPageService>();
    super.onInit();
  }

  @override
  void onReady() async {
    await getTasksToVariable();
    super.onReady();
  }

  // Network services
  late TodayPageService _todayPageService;

  Future addTask(String task) async {
    errorHandler(tryMethod: () async {
      TaskModel newTask = TaskModel.fromJson((await _todayPageService.addTask(task))!.body['task']);
      TaskModel.addTaskForLocale(tasks, TaskModel(id: newTask.id, task: newTask.task, successStatus: SuccessStatus.neutral));
      addedNewTask = true;
      _tasks.refresh();
    });
  }

  Future updateTasksOrder() async {
    errorHandler(tryMethod: () async {
      List<Map<String, dynamic>> updateTaskOrderList = [];
      for (TaskModel task in tasks) {
        updateTaskOrderList.add(task.toJson());
      }
      await _todayPageService.updateTaskOrder(updateTaskOrderList);
    });
  }

  // Delete task from database
  Future deleteTasksFromDB() async {
    errorHandler(
      tryMethod: () async {
        if (deletedTasks.isNotEmpty) {
          String tasks = '';
          for (var task in deletedTasks) {
            tasks += '$task,';
          }
          await _todayPageService.deleteTasks(tasks, () => Get.back());
        }
      },
    );
  }

  //Delete task
  deleteTaskFromLocale(TaskModel task) {
    TaskModel.deleteTaskForLocale(tasks, task);
    _tasks.refresh();
  }

  Future<RequestResponse?> getTasks({
    bool showLoad = true,
  }) async {
    return await errorHandler(tryMethod: () async {
      {
        RequestResponse? requestResponse = await _todayPageService.getTasksByDate((DateTime.now()).toString().split(' ')[0], showLoad);
        if (requestResponse != null) {
          if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
            return requestResponse;
          }
        }
      }
      return null;
    });
  }

  Future getTasksToVariable({showLoad = true}) async {
    await errorHandler(tryMethod: () async {
      if (await getTasks(showLoad: showLoad) != null) {
        dynamic json = jsonDecode((await getTasks(showLoad: showLoad))!.body)['tasks'];
        for (var i = 0; i < json.length; i++) {
          tasks.add(TaskModel.fromJson(json[i]));
        }
        _tasks.refresh();
      }
    });
  }

  onListReorder(int oldListIndex, int newListIndex) {
    if (oldListIndex != newListIndex) TaskModel.updateTaskOrderForLocale(tasks, oldListIndex, newListIndex);
    var movedList = tasks.removeAt(oldListIndex);
    tasks.insert(newListIndex, movedList);
    _tasks.refresh();
  }

  changeStatus(TaskModel task) {
    task.successStatus = _getNewStatus(task.successStatus ?? SuccessStatus.neutral);
    _tasks.refresh();
  }

  _getNewStatus(SuccessStatus status) {
    switch (status) {
      case SuccessStatus.neutral:
        return SuccessStatus.successful;
      case SuccessStatus.successful:
        return SuccessStatus.fail;
      case SuccessStatus.fail:
        return SuccessStatus.neutral;
      default:
        return SuccessStatus.neutral;
    }
  }
}
