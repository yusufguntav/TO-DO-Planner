// ignore_for_file: file_names

import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';

class AllTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllTaskController());
  }
}
