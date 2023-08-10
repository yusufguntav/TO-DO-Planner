import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../variables/standartMeasurementUnits.dart';

class ScaffoldContentContainer extends StatelessWidget {
  const ScaffoldContentContainer({super.key, this.content});
  final Widget? content;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          StandartMeasurementUnits.extraLowPadding,
          StandartMeasurementUnits.lowPadding,
          StandartMeasurementUnits.extraLowPadding,
          0,
        ),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: content,
        ),
      ),
    );
  }
}
