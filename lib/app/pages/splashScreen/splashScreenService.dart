import 'package:get/get.dart';

import '../../../core/network/baseNetworkService.dart';
import '../../../core/network/networkModels/requestResponse.dart';
import '../../../core/variables/enums.dart';

class SplashScreenService extends GetxService {
  final _networkService = Get.find<BaseNetworkService>();
  Future<RequestResponse?> checkRoutine() async =>
      await _networkService.sendPostRequest(
        Endpoints.checkRoutine.path,
        {},
      );
}
