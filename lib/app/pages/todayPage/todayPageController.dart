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
  //AddTask Field Controller
  final TextEditingController _addTaskinputField = TextEditingController();
  TextEditingController get addTaskinputField => _addTaskinputField;

  //Task List control
  final RxList<TaskModel> _tasks = <TaskModel>[].obs;
  List<TaskModel> get tasks => _tasks;

  //Deleted Tasks
  final RxList<String> _deletedTasks = <String>[].obs;
  List<String> get deletedTasks => _deletedTasks;

  @override
  void onClose() async {
    // delete tasks from Database
    await deleteTasksFromDB();
    await updateTasksOrder();
    super.onClose();
  }

  @override
  void onInit() {
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
    if (deletedTasks.isNotEmpty) {
      String tasks = '';
      for (var task in deletedTasks) {
        tasks += '$task,';
      }
      await _todayPageService.deleteTasks(tasks, () => Get.back());
    }
  }

  Future addTask(String task) async {
    //TODO Sadece tek sefer dispose da istek atacağız
    errorHandler(tryMethod: () async => await _todayPageService.addTask(task));
  }

  Future<RequestResponse?> getTasks() async {
    errorHandler(tryMethod: () async {
      RequestResponse? requestResponse = await _todayPageService.getTasksByDate((DateTime.now()).toString().split(' ')[0]);
      if (requestResponse != null) {
        if (StatusCodes.successful.checkStatusCode(requestResponse.status)) {
          return requestResponse;
        }
      }
    });
    return null;
  }

  Future getTasksToVariable() async {
    errorHandler(tryMethod: () async {
      if (await getTasks() != null) {
        tasks.clear();
        dynamic json = jsonDecode((await getTasks())!.body)['tasks'];
        for (var i = 0; i < json.length; i++) {
          tasks.add(TaskModel.fromJson(json));
        }
        _tasks.refresh();
      }
    });
  }

  SuccessStatus getTaskStatus(int successStatus) {
    switch (successStatus) {
      case 0:
        return SuccessStatus.neutral;
      case 1:
        return SuccessStatus.successful;
      case 2:
        return SuccessStatus.fail;
      default:
        return SuccessStatus.neutral;
    }
  }

  onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {}

  onListReorder(int oldListIndex, int newListIndex) {
    if (oldListIndex != newListIndex) TaskModel.updateTaskOrder(tasks, oldListIndex, newListIndex);
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
