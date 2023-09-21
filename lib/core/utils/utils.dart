import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/texts/customText.dart';

Future<R?> errorHandler<R>({required Future<R?> Function() tryMethod, Future<R?> Function()? onErr}) async {
  try {
    return await tryMethod();
  } catch (exception) {
    return onErr != null ? onErr() : Get.dialog(AlertDialog(content: CustomText('Something went wrong')));
  }
}
