// ignore_for_file: file_names

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/models/task.dart';
import 'package:to_do_app/core/variables/enums.dart';

import '../../../core/widgets/taskCard.dart';

class TodayPageController extends GetxController {
  @override
  void onInit() {
    contents = List.generate(
      tasks.length,
      (index) {
        return DragAndDropList(
          canDrag: true,
          verticalAlignment: CrossAxisAlignment.center,
          contentsWhenEmpty: const SizedBox(),
          header: Obx(
            () => TaskCard(
              task: tasks[index].value,
              onTapFunct: changeStatus,
            ),
          ),
          children: <DragAndDropItem>[],
        );
      },
    ).obs;
    super.onInit();
  }

  onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    var movedItem = contents[oldListIndex].children.removeAt(oldItemIndex);
    contents[newListIndex].children.insert(newItemIndex, movedItem);
    contents.refresh();
  }

  onListReorder(int oldListIndex, int newListIndex) {
    var movedList = contents.removeAt(oldListIndex);
    contents.insert(newListIndex, movedList);
    contents.refresh();
  }

  RxList<DragAndDropList> contents = <DragAndDropList>[].obs;
  RxList<Rx<TaskModel>> tasks = [
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!",
            SuccessStatus.successful)
        .obs,
    TaskModel(
            "Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur gBaldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!eçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!",
            SuccessStatus.neutral)
        .obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!", SuccessStatus.fail).obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!",
            SuccessStatus.successful)
        .obs,
    TaskModel(
            "Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur gBaldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!eçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!",
            SuccessStatus.neutral)
        .obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!", SuccessStatus.fail).obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!Alışveriş için dışarı çık. Şemşiyeni unutma!",
            SuccessStatus.successful)
        .obs,
    TaskModel(
            "Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur gBaldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!eçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!",
            SuccessStatus.neutral)
        .obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!", SuccessStatus.fail).obs,
    TaskModel(
            "Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!Baldur geçidine doğru yola çık. Büyülü asanı unutma!",
            SuccessStatus.successful)
        .obs,
    TaskModel("Alışveriş için dışarı çık. Şemşiyeni unutma!", SuccessStatus.neutral).obs,
  ].obs;

  changeStatus(TaskModel task) {
    task.successStatus = _getNewStatus(task.successStatus ?? SuccessStatus.neutral);
    tasks.refresh();
  }

  _getNewStatus(SuccessStatus status) {
    switch (status) {
      case SuccessStatus.neutral:
        return SuccessStatus.successful;
      case SuccessStatus.successful:
        return SuccessStatus.fail;
      case SuccessStatus.fail:
        return SuccessStatus.neutral;
      default:
        return SuccessStatus.neutral;
    }
  }
}
