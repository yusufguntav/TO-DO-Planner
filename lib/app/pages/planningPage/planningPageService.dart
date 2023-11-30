import 'package:get/get.dart';
import 'package:to_do_app/core/models/routines.dart';
import 'package:to_do_app/core/models/specialList.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class PlanningPageService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();
  // Requests for routine

  Future<RequestResponse?> getRoutines() async => await _networkService.sendGetRequest(Endpoints.getRoutines.path);

  Future<RequestResponse?> createRoutine(String routineName, List<int> days, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.createRoutine.path, {"name": routineName, "days": days}, onSuccessFunc: onSuccessFunc);

  // Future<RequestResponse?> getRoutineTasks(RoutineModel? routine, bool showLoad) async =>
  //     await _networkService.sendGetRequest(Endpoints.getTasksForRoutine.path + (routine?.day?.dayNumber ?? 0).toString(), showLoad: showLoad);

  // Requests for tasks
  Future<RequestResponse?> getTasks(SpecialListModel? listModel, bool showLoad) async =>
      await _networkService.sendGetRequest(Endpoints.getTasksForSpecialList.path + (listModel?.id ?? ''), showLoad: showLoad);

  Future<RequestResponse?> deleteTasks(String tasks, Function onSuccess) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteTask.path + tasks, onSuccessFunc: onSuccess);

  Future<RequestResponse?> updateTaskOrder(List<Map<String, dynamic>> tasks, String specialListId) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateTaskOrder.path, {"tasks": tasks, "specialListId": specialListId});

  Future<RequestResponse?> addTask(String task, SpecialListModel? specialList, RoutineModel? routine) async => await _networkService
      .sendPostRequest(Endpoints.addTask.path, {"task": task, "specialListId": specialList?.id, "routineId": routine?.id}, showLoad: false);

  // Requests for special lists
  Future<RequestResponse?> addSpecialList(String name, String endDate, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.addSpecialList.path, {'name': name, 'endDate': endDate}, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> getSpecialList() async => await _networkService.sendGetRequest(Endpoints.getSpeciaLists.path);

  Future<RequestResponse?> updateSpecialList(String name, String id, String endDate, Function onSuccessFunc) async => await _networkService
      .sendUpdateRequest(Endpoints.updateSpecialList.path, {'name': name, '_id': id, 'endDate': endDate}, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> deleteSpecialList(String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteSpecialList.path + id, onSuccessFunc: onSuccessFunc);
}
