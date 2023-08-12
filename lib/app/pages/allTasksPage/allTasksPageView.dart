import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/allTasksPage/allTasksPageController.dart';
import 'package:to_do_app/core/variables/enums.dart';
import 'package:to_do_app/core/widgets/texts/title.dart';

class AllTaskView extends GetView<AllTaskController> {
  const AllTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTitle(
          titleText: 'ALL TASKS',
          titleColor: MenuColors.allTasks.getMenuTag,
        ),
      ],
    );
  }
}
