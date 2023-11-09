import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/texts/customText.dart';

//TODO Exception daha iyi bir hale getir
Future<R?> errorHandler<R>({required Future<R?> Function() tryMethod, Future<R>? Function()? onErr}) async {
  try {
    return await tryMethod();
  } catch (exception) {
    debugPrint("Error:$exception");
    return onErr != null ? onErr() : Get.dialog(AlertDialog(content: CustomText('Something went wrong')));
  }
}

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}
