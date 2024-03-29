// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/core/network/baseNetworkService.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../../../core/network/networkModels/requestResponse.dart';

class SignInService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  Future<RequestResponse?> checkRoutine() async =>
      await _networkService.sendPostRequest(
        Endpoints.checkRoutine.path,
        {},
      );

  Future<RequestResponse?> login(String email, String password) async =>
      await _networkService.sendPostRequest(
          Endpoints.signIn.path, {"email": email, "password": password});
}
