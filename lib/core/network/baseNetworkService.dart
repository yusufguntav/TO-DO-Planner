// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/utils/utils.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

import '../services/secure_storage.dart';
import '../widgets/circularProgressWhileProcess.dart';
import 'networkModels/requestResponse.dart';

class BaseNetworkService extends GetxService {
  // Page state control
  final Rx<PageStates> _state = PageStates.loaded.obs;
  PageStates get state => _state.value;
  set state(PageStates val) => _state.value = val;
  Map<String, String>? header;
  @override
  void onInit() async {
    _connect.baseUrl = _protocolAndIp;
    errorHandler(tryMethod: () async {
      header = {"Authorization": "Bearer ${await SecureStorage().readSecureData('token')}"};
    }, onErr: () {
      return null;
    });
    ever(
      _state,
      (PageStates value) {
        switch (value) {
          case PageStates.busy:
            Get.dialog(const CircularProgressWhileProcess(), barrierColor: Colors.white.withOpacity(0.6));
            break;
          case PageStates.loaded:
            if (Get.isOverlaysOpen) Get.back();
            break;
          case PageStates.error:
            if (Get.isOverlaysOpen) Get.back();
            break;
          case PageStates.initial:
            if (Get.isOverlaysOpen) Get.back();
            break;
        }
      },
    );
    super.onInit();
  }

  final GetConnect _connect = GetConnect();

  final _protocolAndIp = 'http://154.62.109.18:3000';
  // final _protocolAndIp = 'http://10.0.2.2:3000';

  Future<RequestResponse?> sendPostRequest(String endpoint, Map<dynamic, dynamic> body, {Function? onSuccessFunc, bool showLoad = true}) async {
    await Get.closeCurrentSnackbar();
    if (showLoad) state = PageStates.busy;
    final response = await _connect.post(
      endpoint,
      body,
      headers: header,
    );
    if (showLoad) state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.body, response.statusCode ?? 404);
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendGetRequest(String endpoint, {Function? onSuccessFunc, bool showLoad = true}) async {
    await Get.closeCurrentSnackbar();
    if (showLoad) state = PageStates.busy;
    final response = await _connect.get(
      endpoint,
      headers: header,
    );
    if (showLoad) state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode ?? 404);
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendDeleteRequest(String endpoint, {Function? onSuccessFunc}) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.delete(
      endpoint,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode ?? 404);
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendUpdateRequest(String endpoint, Map<dynamic, dynamic>? body, {Function? onSuccessFunc}) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.patch(
      endpoint,
      body,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode ?? 404);
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  AlertDialog unexpectedErrorDialog() {
    return AlertDialog(
      title: CustomText.extraHigh('Error'),
      // TODO: Email yönlendirme linki
      content: RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                text: 'Unexpected error! please contact with us. For contact please click here ', style: TextStyle(color: ColorTable.getTextColor)),
            TextSpan(
              text: 'click here',
              style: TextStyle(fontWeight: FontWeight.bold, color: ColorTable.getTextColor, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),

      actions: [
        CustomButton(buttonText: 'Ok', onPress: () => Get.back()),
      ],
    );
  }

  RequestResponse? errorControlAndOnSuccessFunc(Response response, RequestResponse requestResponse, Function? onSuccessFunc) {
    // Error control
    if (response.statusCode == null) {
      Get.dialog(
        unexpectedErrorDialog(),
      );
      return null;
    } else if (response.hasError) {
      Get.dialog(
        AlertDialog(
          title: CustomText('Error'),
          content: CustomText.high(response.body['error'].toString()),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            CustomButton(buttonText: 'Ok', onPress: () => Get.back()),
          ],
        ),
      );
      return requestResponse;
    }
    if (StatusCodes.successful.checkStatusCode(response.statusCode ?? 404)) {
      onSuccessFunc != null ? onSuccessFunc() : () {};
    }
    return requestResponse;
  }
}
