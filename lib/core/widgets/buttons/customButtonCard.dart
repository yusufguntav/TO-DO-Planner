// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';

import '../texts/customText.dart';

class CustomButtonCard extends StatelessWidget {
  const CustomButtonCard({super.key, required this.borderColor, this.title, this.topPadding, this.onTapFunction, this.editButtonFunc});
  final Color borderColor;
  final String? title;
  final Function()? editButtonFunc;
  final double? topPadding;
  final Function()? onTapFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding ?? 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(StandartMeasurementUnits.extraHighRadius),
          border: Border.all(color: borderColor),
        ),
        child: SizedBox(
          height: StandartMeasurementUnits.taskCardHeight,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  borderRadius: editButtonFunc != null
                      ? const BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
                      : BorderRadius.circular(20),
                  onTap: onTapFunction,
                  child: Center(child: title != null ? CustomText(title) : const Icon(Icons.add, color: Colors.black87)),
                ),
              ),
              if (editButtonFunc != null)
                Expanded(
                  child: Center(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                      onTap: editButtonFunc,
                      child: Row(
                        children: [
                          VerticalDivider(thickness: 1, color: borderColor),
                          Icon(Icons.edit, color: borderColor),
                        ],
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
