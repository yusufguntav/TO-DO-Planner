import 'package:get/get.dart';
import 'package:to_do_app/core/network/baseNetworkService.dart';
import 'package:to_do_app/core/variables/enums.dart';

class SignInService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();
  Future<RequestResponse?> login(Rx<bool> progressIndicator, String email, String password) async =>
      _networkService.sendPostRequest(progressIndicator, Endpoints.signIn, {"email": email, "password": password}, null);
}
