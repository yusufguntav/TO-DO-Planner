import 'package:get/get.dart';
import 'package:to_do_app/core/network/baseNetworkService.dart';
import 'package:to_do_app/core/variables/enums.dart';

class SignUpService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();

  Future<RequestResponse?> signUp(Rx<bool> progressIndicator, String email, String password, String displayName) async =>
      _networkService.sendPostRequest(progressIndicator, Endpoints.signUp, {"email": email, "password": password, "displayName": displayName}, null);
}
