// ignore_for_file: file_names

import 'package:get/get.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class AllTaskService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  Future<RequestResponse?> addCategory(String name, String token, Function onSuccessFunc) async =>
      await _networkService.sendPostRequest(Endpoints.addCategory, {"name": name}, {'Authorization': "Bearer $token"}, onSuccessFunc);

  Future<RequestResponse?> getCategory(String token) async =>
      await _networkService.sendGetRequest(Endpoints.getCategory, {'Authorization': "Bearer $token"}, null);
}
