// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class AllTaskService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  Future<RequestResponse?> addCategory(String name, String description, String token, Function onSuccessFunc) async => await _networkService
      .sendPostRequest(Endpoints.addCategory, {'name': name, 'description': description}, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> getCategory(String token) async =>
      await _networkService.sendGetRequest(Endpoints.getCategory, {'Authorization': "Bearer $token"}, null);

  Future<RequestResponse?> deleteCategory(String token, String categoryName, Function onSuccessFunc) async =>
      await _networkService.sendDeleteRequest(Endpoints.deleteCategory, categoryName, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> updateCategory(String name, String oldName, String description, String token, Function onSuccessFunc) async =>
      await _networkService.sendUpdateRequest(Endpoints.updateCategory, {'name': name, 'oldName': oldName, 'description': description},
          {'Authorization': "Bearer $token"}, onSuccessFunc);
}
