import 'package:flutter/widgets.dart';

import '../../variables/colorTable.dart';
import '../../variables/standartMeasurementUnits.dart';
import 'customText.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.titleText, this.titleColor});
  final String titleText;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return CustomText.extraHigh(
      titleText,
      textColor: titleColor ?? ColorTable.getTitleColor,
      bold: true,
      letterSpacing: StandartMeasurementUnits.extraLowPadding,
    );
  }
}
