import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/colorTable.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/buttons/customButton.dart';
import 'package:to_do_app/core/widgets/texts/customText.dart';

class RequestResponse {
  dynamic body;
  String status;
  RequestResponse(this.body, this.status);
}

class BaseNetworkService extends GetxService {
  final GetConnect _connect = GetConnect();

  final _protocolAndIp = 'http://10.0.2.2:3000';

  Future<RequestResponse?> sendPostRequest(
      // TODO RX li veri alıyoruz başka nasıl olabilir ?
      Rx<bool> progressIndicator,
      Endpoints endpoint,
      Map<String, String> body,
      Map<String, String>? header) async {
    // showProgressIndicator ?
    progressIndicator.value = true;
    final response = await _connect
        .post(
          _protocolAndIp + endpoint.path,
          body,
          headers: header,
        )
        .whenComplete(() => progressIndicator.value = false);
    RequestResponse requestResponse = RequestResponse(response.body, response.statusCode.toString());
    // Error control
    if (response.statusCode == null) {
      Get.dialog(
        unexpectedErrorDialog(),
      );
      return null;
    } else if (response.hasError) {
      Get.dialog(AlertDialog(
        title: CustomText('Error'),
        content: CustomText.high(response.body['message']),
      ));
      return requestResponse;
    }
    return requestResponse;
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
}
