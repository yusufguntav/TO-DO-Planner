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
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(StandartMeasurementUnits.normalRadius),
      child: Padding(
        padding: EdgeInsets.only(top: topPadding ?? 0),
        child: SizedBox(
          height: StandartMeasurementUnits.taskCardHeight,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  borderRadius: editButtonFunc != null
                      ? BorderRadius.only(
                          topLeft: Radius.circular(StandartMeasurementUnits.normalRadius),
                          bottomLeft: Radius.circular(StandartMeasurementUnits.normalRadius))
                      : BorderRadius.circular(StandartMeasurementUnits.normalRadius),
                  onTap: onTapFunction,
                  child: Center(
                      child: title != null
                          ? Padding(
                              padding: EdgeInsets.all(StandartMeasurementUnits.lowPadding),
                              child: CustomText(
                                title,
                                centerText: true,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            )
                          : const Icon(Icons.add, color: Colors.black87)),
                ),
              ),
              if (editButtonFunc != null)
                Expanded(
                  child: Center(
                    child: InkWell(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(StandartMeasurementUnits.normalRadius),
                          topRight: Radius.circular(StandartMeasurementUnits.normalRadius)),
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
