// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageController.dart';
import 'package:to_do_app/app/pages/planningPage/planningPageService.dart';

class PlanningPageHome extends StatefulWidget {
  const PlanningPageHome({super.key});

  @override
  State<PlanningPageHome> createState() => _PlanningPageHomeState();
}

class _PlanningPageHomeState extends State<PlanningPageHome> {
  late PlanningPageController controller;

  @override
  void initState() {
    Get.put(PlanningPageService());
    controller = Get.put(PlanningPageController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<PlanningPageService>();
    Get.delete<PlanningPageController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.getPage());
  }
}
