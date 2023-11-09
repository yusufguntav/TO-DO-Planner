// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/colorTable.dart';

import '../../variables/standartMeasurementUnits.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key, required this.content, this.showCloseButton = false, this.actions, this.closeButtonColor, this.deleteButtonFunction});
  final List<Widget>? actions;
  final bool showCloseButton;
  final Function? deleteButtonFunction;
  final Color? closeButtonColor;
  final Widget? content;
  @override
  Widget build(BuildContext context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        scrollable: true,
        titlePadding: EdgeInsets.zero,
        actions: actions,
        title: (showCloseButton && deleteButtonFunction != null)
            ? Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      color: ColorTable.getNegativeColor,
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteButtonFunction!.call(),
                    ),
                    IconButton(
                      color: closeButtonColor ?? ColorTable.getNegativeColor,
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ))
            : (showCloseButton)
                ? Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: closeButtonColor ?? ColorTable.getNegativeColor,
                      icon: const Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                  )
                : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(StandartMeasurementUnits.lowRadius)),
        contentPadding: EdgeInsets.fromLTRB(StandartMeasurementUnits.normalPadding, StandartMeasurementUnits.normalPadding,
            StandartMeasurementUnits.normalPadding, StandartMeasurementUnits.normalPadding),
        content: content,
      );
}
