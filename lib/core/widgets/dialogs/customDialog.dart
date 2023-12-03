// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/colorTable.dart';

import '../../variables/standartMeasurementUnits.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.content,
      this.showCloseButton = false,
      this.actions,
      this.closeButtonFunction,
      this.closeButtonColor,
      this.deleteButtonFunction});
  final List<Widget>? actions;
  final bool showCloseButton;
  final Function? deleteButtonFunction;
  final Function? closeButtonFunction;

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
                      onPressed: () {
                        if (deleteButtonFunction != null) deleteButtonFunction!();
                      },
                    ),
                    IconButton(
                      color: closeButtonColor ?? ColorTable.getNegativeColor,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        if (closeButtonFunction != null) closeButtonFunction!();
                        Get.back();
                      },
                    ),
                  ],
                ))
            : (showCloseButton)
                ? Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: closeButtonColor ?? ColorTable.getNegativeColor,
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        if (closeButtonFunction != null) closeButtonFunction!();
                        Get.back();
                      },
                    ),
                  )
                : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(StandartMeasurementUnits.lowRadius)),
        contentPadding: EdgeInsets.fromLTRB(StandartMeasurementUnits.normalPadding, StandartMeasurementUnits.normalPadding,
            StandartMeasurementUnits.normalPadding, StandartMeasurementUnits.normalPadding),
        content: content,
      );
}
