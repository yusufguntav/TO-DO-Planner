// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/core/network/baseNetworkService.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../../../core/network/networkModels/requestResponse.dart';

class SignUpService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  Future<RequestResponse?> signUp(String email, String password, String displayName, Function onSuccessFunc) async => await _networkService
      .sendPostRequest(Endpoints.signUp, {"email": email, "password": password, "displayName": displayName}, null, onSuccessFunc);
}
