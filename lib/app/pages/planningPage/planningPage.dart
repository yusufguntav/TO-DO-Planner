// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class PlanningPageService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  // Requests for special lists
  Future<RequestResponse?> addSpecialList(String name, String token, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.addSpecialList, {'name': name}, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> getSpecialList(String token) async =>
      await _networkService.sendGetRequest(Endpoints.getSpeciaLists, {'Authorization': "Bearer $token"}, null);

  Future<RequestResponse?> updateSpecialList(String name, String id, String token, Function onSuccessFunc) async => await _networkService
      .sendUpdateRequest(Endpoints.updateSpecialList, {'name': name, '_id': id}, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> deleteSpecialList(String token, String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteSpecialList, id, {'Authorization': "Bearer $token"}, onSuccessFunc);

  // Requests for categories
  Future<RequestResponse?> addCategory(String name, String description, String token, Function onSuccessFunc) async => await _networkService
      .sendPostRequest(Endpoints.addCategory, {'name': name, 'description': description}, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> getCategory(String token) async =>
      await _networkService.sendGetRequest(Endpoints.getCategory, {'Authorization': "Bearer $token"}, null);

  Future<RequestResponse?> deleteCategory(String token, String id, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteCategory, id, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> updateCategory(String name, String id, String description, String token, Function onSuccessFunc) async =>
      await _networkService.sendUpdateRequest(
          Endpoints.updateCategory, {'name': name, '_id': id, 'description': description}, {'Authorization': "Bearer $token"}, onSuccessFunc);
}
