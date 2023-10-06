// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';

class TodayPageService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();
  Future<RequestResponse?> getTasksByDate(String taskDate, bool showLoad) async =>
      await _networkService.sendGetRequest(Endpoints.getTasksByDate.path + taskDate, showLoad: showLoad);

  Future<RequestResponse?> deleteTasks(String tasks, Function onSuccess) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteTask.path + tasks, onSuccessFunc: onSuccess);

  Future<RequestResponse?> updateTaskOrder(List<Map<String, dynamic>> tasks) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateTaskOrder.path, {"tasks": tasks});

  Future<RequestResponse?> addTask(String task) async =>
      await _networkService.sendPostRequest(Endpoints.addTaskToday.path, {"task": task}, showLoad: false);
}
