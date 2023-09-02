import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

import '../widgets/circularProgressWhileProcess.dart';
import 'networkModels/requestResponse.dart';

class BaseNetworkService extends GetxService {
  // Page state control
  final Rx<PageStates> _state = PageStates.loaded.obs;
  PageStates get state => _state.value;
  set state(PageStates val) => _state.value = val;

  @override
  void onInit() {
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

  final _protocolAndIp = 'http://10.0.2.2:3000';

  Future<RequestResponse?> sendPostRequest(Endpoints endpoint, Map<String, String> body, Map<String, String>? header, Function? onSuccessFunc) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.post(
      _protocolAndIp + endpoint.path,
      body,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.body, response.statusCode.toString());
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendGetRequest(Endpoints endpoint, Map<String, String>? header, Function? onSuccessFunc) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.get(
      _protocolAndIp + endpoint.path,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode.toString());
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendDeleteRequest(Endpoints endpoint, String idForPath, Map<String, String>? header, Function? onSuccessFunc) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.delete(
      // TODO Burayı sor idForPath sona eklemek mantıklı mı ?
      _protocolAndIp + endpoint.path + idForPath,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode.toString());
    return errorControlAndOnSuccessFunc(response, requestResponse, onSuccessFunc);
  }

  Future<RequestResponse?> sendUpdateRequest(
      Endpoints endpoint, Map<String, String>? body, Map<String, String>? header, Function? onSuccessFunc) async {
    await Get.closeCurrentSnackbar();
    state = PageStates.busy;
    final response = await _connect.patch(
      _protocolAndIp + endpoint.path,
      body,
      headers: header,
    );
    state = PageStates.loaded;
    RequestResponse requestResponse = RequestResponse(response.bodyString, response.statusCode.toString());
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
