import 'package:get/get.dart';
import 'package:to_do_app/core/models/routines.dart';
import 'package:to_do_app/core/models/specialList.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class PlanningPageService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();
  // Requests for routine
  Future<RequestResponse?> deleteRoutine(
          String routineId, Function onSuccess) async =>
      await _networkService.sendDeleteRequest(
          Endpoints.deleteRoutine.path + routineId,
          onSuccessFunc: onSuccess);

  Future<RequestResponse?> updateRoutine(
          String name,
          String routineId,
          List<int> deletedDays,
          List<int> newDays,
          Function onSuccessFunc) async =>
      await _networkService.sendUpdateRequest(
          Endpoints.updateRoutine.path,
          {
            'name': name,
            'routineId': routineId,
            'removedDays': deletedDays,
            'newDays': newDays
          },
          onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> getRoutines() async =>
      await _networkService.sendGetRequest(Endpoints.getRoutines.path);

  Future<RequestResponse?> createRoutine(
          String routineName, List<int> days, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(
          Endpoints.createRoutine.path, {"name": routineName, "days": days},
          onSuccessFunc: onSuccessFunc);

  // Requests for tasks
  Future<RequestResponse?> getTasksForSpecialList(
          SpecialListModel? listModel, bool showLoad) async =>
      await _networkService.sendGetRequest(
          Endpoints.getTasksForSpecialList.path + (listModel?.id ?? ''),
          showLoad: showLoad);

  Future<RequestResponse?> getTasksForRoutine(
          RoutineModel? routine, bool showLoad) async =>
      await _networkService.sendGetRequest(
          Endpoints.getTasksForRoutine.path + (routine?.id ?? ''),
          showLoad: showLoad);

  Future<RequestResponse?> deleteTasks(
          String tasks, Function onSuccess) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteTask.path + tasks,
          onSuccessFunc: onSuccess);

  Future<RequestResponse?> updateTaskOrder(
          List<Map<String, dynamic>> tasks) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateTaskOrder.path, {
        "tasks": tasks,
      });

  Future<RequestResponse?> addTask(String task, SpecialListModel? specialList,
          RoutineModel? routine) async =>
      await _networkService.sendPostRequest(
          Endpoints.addTask.path,
          {
            "task": task,
            "specialListId": specialList?.id,
            "routineId": routine?.id
          },
          showLoad: false);

  // Requests for special lists
  Future<RequestResponse?> addSpecialList(
          String name, String? endDate, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(
          Endpoints.addSpecialList.path, {'name': name, 'endDate': endDate},
          onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> getSpecialList() async =>
      await _networkService.sendGetRequest(Endpoints.getSpeciaLists.path);

  Future<RequestResponse?> updateSpecialList(String name, String id,
          String? endDate, Function onSuccessFunc) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateSpecialList.path,
          {'name': name, '_id': id, 'endDate': endDate},
          onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> deleteSpecialList(
          String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(
          Endpoints.deleteSpecialList.path + id,
          onSuccessFunc: onSuccessFunc);
}
