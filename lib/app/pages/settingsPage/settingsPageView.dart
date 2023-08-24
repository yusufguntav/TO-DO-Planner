import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/app/pages/settingsPage/settingsPageController.dart';

import '../../../core/variables/enums.dart';
import '../../../core/variables/standartMeasurementUnits.dart';
import '../../../core/widgets/texts/title.dart';

class SettingsPage extends GetView<SettingsPageController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTitle(titleText: "SETTINGS", titleColor: Pages.settings.getPageColor),
        SizedBox(height: StandartMeasurementUnits.highPadding),
      ],
    );
  }
}
