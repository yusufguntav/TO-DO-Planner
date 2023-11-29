// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../variables/standartMeasurementUnits.dart';

class dateDialog extends StatelessWidget {
  const dateDialog({super.key, this.onSubmit, this.onCancel, this.color});
  final Function(Object?)? onSubmit;
  final Function? onCancel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Get.height * .6,
              child: Padding(
                padding: EdgeInsets.all(StandartMeasurementUnits.extraHighPadding),
                child: SfDateRangePicker(
                  enablePastDates: false,
                  selectionColor: color,
                  todayHighlightColor: color,
                  rangeSelectionColor: color,
                  onCancel: () => onCancel != null ? onCancel!() : null,
                  onSubmit: (p0) => onSubmit != null ? onSubmit!(p0) : null,
                  showActionButtons: true,
                  view: DateRangePickerView.month,
                  monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
