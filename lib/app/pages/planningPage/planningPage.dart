// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class PlanningPageService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  // Requests for special lists
  Future<RequestResponse?> addSpecialList(String name, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.addSpecialList.path, {'name': name}, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> getSpecialList() async => await _networkService.sendGetRequest(Endpoints.getSpeciaLists.path);

  Future<RequestResponse?> updateSpecialList(String name, String id, Function onSuccessFunc) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateSpecialList.path, {'name': name, '_id': id}, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> deleteSpecialList(String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteSpecialList.path + id, onSuccessFunc: onSuccessFunc);

  // Requests for categories
  Future<RequestResponse?> addCategory(String name, String description, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.addCategory.path, {'name': name, 'description': description}, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> getCategory() async => await _networkService.sendGetRequest(Endpoints.getCategory.path);

  Future<RequestResponse?> deleteCategory(String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteCategory.path + id, onSuccessFunc: onSuccessFunc);

  Future<RequestResponse?> updateCategory(String name, String id, String description, Function onSuccessFunc) async => await _networkService
      .sendUpdateRequest(Endpoints.updateCategory.path, {'name': name, '_id': id, 'description': description}, onSuccessFunc: onSuccessFunc);
}
