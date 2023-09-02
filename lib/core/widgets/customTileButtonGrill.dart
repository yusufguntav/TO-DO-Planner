// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customListTileButton.dart';

class CustomTileButtonGrill extends StatelessWidget {
  const CustomTileButtonGrill({super.key, required this.customTileButtons});
  final List<CustomListTileButton> customTileButtons;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < customTileButtons.length; i += 2) ...[
          (customTileButtons.length - i > 1)
              ? Row(
                  children: [
                    Expanded(child: customTileButtons[i]),
                    SizedBox(width: StandartMeasurementUnits.lowPadding),
                    Expanded(child: customTileButtons[i + 1]),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: customTileButtons[i]),
                  ],
                ),
          SizedBox(height: StandartMeasurementUnits.normalPadding)
        ],
      ],
    );
  }
}
