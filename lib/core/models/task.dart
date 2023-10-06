import 'package:to_do_app/core/models/category.dart';
import 'package:to_do_app/core/utils/abstacts.dart';
import 'package:to_do_app/core/variables/enums.dart';

class TaskModel extends BaseModel {
  String? id;
  String? task;
  SuccessStatus? successStatus;
  DateTime? date;
  CategoryModel? category;
  String? nextTaskId;
  String? previousTaskId;
  TaskModel({this.task, this.successStatus, this.category, this.date, this.id, this.nextTaskId, this.previousTaskId});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['task'] = task;
    data['taskStatus'] = reverseTaskStatus(successStatus ?? SuccessStatus.neutral);
    data['date'] = date;
    data['category'] = category;
    data['nextTaskId'] = nextTaskId;
    data['previousTaskId'] = previousTaskId;

    return data;
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

  int reverseTaskStatus(SuccessStatus successStatus) {
    switch (successStatus) {
      case SuccessStatus.neutral:
        return 0;
      case SuccessStatus.successful:
        return 1;
      case SuccessStatus.fail:
        return 2;
      default:
        return 0;
    }
  }

  @override
  TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel.fromJson(json);
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    task = json['task'];
    successStatus = getTaskStatus(json['taskStatus'] ?? 0);
    date = json['date'];
    category = json['category'];
    nextTaskId = json['nextTaskId'];
    previousTaskId = json['previousTaskId'];
  }

  static addTaskForLocale(List<TaskModel> tasks, TaskModel task) {
    TaskModel? lastTask = tasks.where((element) => element.nextTaskId == null).firstOrNull;
    if (lastTask != null) {
      lastTask.nextTaskId = task.id;
      task.previousTaskId = lastTask.id;
    }
    tasks.add(task);
  }

  static deleteTaskForLocale(List<TaskModel> tasks, TaskModel task) {
    TaskModel? nextTask = tasks.where((element) => element.previousTaskId == task.id).firstOrNull;
    TaskModel? previousTask = tasks.where((element) => element.nextTaskId == task.id).firstOrNull;

    if (nextTask != null) nextTask.previousTaskId = previousTask?.id;
    if (previousTask != null) previousTask.nextTaskId = nextTask?.id;
  }

  static updateTaskOrderForLocale(List<TaskModel> tasks, int oldListIndex, int newListIndex) {
    int firstTaskIndex = oldListIndex;
    int secondTaskIndex = newListIndex;
    if (oldListIndex++ == newListIndex || oldListIndex-- == newListIndex) {
      firstTaskIndex = oldListIndex > newListIndex ? newListIndex : oldListIndex;
      secondTaskIndex = oldListIndex > newListIndex ? oldListIndex : newListIndex;
    }
    TaskModel task = tasks[firstTaskIndex];
    TaskModel secondTask = tasks[secondTaskIndex];

    TaskModel? taskPreviousTask = tasks.where((element) => element.id == task.previousTaskId).firstOrNull;
    TaskModel? taskNextTask = tasks.where((element) => element.id == task.nextTaskId).firstOrNull;

    TaskModel? secondTaskPreviousTask = tasks.where((element) => element.id == secondTask.previousTaskId).firstOrNull;
    TaskModel? secondTaskNextTask = tasks.where((element) => element.id == secondTask.nextTaskId).firstOrNull;

    if (task.nextTaskId == secondTask.id) {
      // Next
      if (taskPreviousTask != null) taskPreviousTask.nextTaskId = secondTask.id;
      task.nextTaskId = secondTask.nextTaskId;
      secondTask.nextTaskId = task.id;
      // Previous
      if (secondTaskNextTask != null) secondTaskNextTask.previousTaskId = task.id;
      secondTask.previousTaskId = task.previousTaskId;
      task.previousTaskId = secondTask.id;
    } else if (firstTaskIndex < secondTaskIndex) {
      // Next
      if (taskPreviousTask != null) taskPreviousTask.nextTaskId = task.nextTaskId;
      task.nextTaskId = secondTask.nextTaskId;
      secondTask.nextTaskId = task.id;
      // Previous
      if (secondTaskNextTask != null) secondTaskNextTask.previousTaskId = task.id;
      if (taskNextTask != null) taskNextTask.previousTaskId = task.previousTaskId;
      task.previousTaskId = secondTask.id;
    } else {
      // Next
      if (secondTaskPreviousTask != null) secondTaskPreviousTask.nextTaskId = task.id;
      if (taskPreviousTask != null) taskPreviousTask.nextTaskId = task.nextTaskId;
      task.nextTaskId = secondTask.id;
      // Previous
      if (taskNextTask != null) taskNextTask.previousTaskId = task.previousTaskId;
      task.previousTaskId = secondTask.previousTaskId;
      secondTask.previousTaskId = task.id;
    }
  }
}
