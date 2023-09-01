// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_app/core/variables/standartMeasurementUnits.dart';
import 'package:to_do_app/core/widgets/buttons/customListTileButton.dart';

class CategoryGrill extends StatelessWidget {
  const CategoryGrill({super.key, required this.categoryButtons});
  final List<CustomListTileButton> categoryButtons;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < categoryButtons.length; i += 2) ...[
          (categoryButtons.length - i > 1)
              ? Row(
                  children: [
                    Expanded(child: categoryButtons[i]),
                    SizedBox(width: StandartMeasurementUnits.lowPadding),
                    Expanded(child: categoryButtons[i + 1]),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: categoryButtons[i]),
                  ],
                ),
          SizedBox(height: StandartMeasurementUnits.normalPadding)
        ],
      ],
    );
  }
}
