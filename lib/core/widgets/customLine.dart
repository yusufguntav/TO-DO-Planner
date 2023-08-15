// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/core/variables/enums.dart';

class CustomLine extends StatelessWidget {
  const CustomLine({super.key, this.successStatus, this.lineBoxHeight, this.lineBoxWidth});
  final SuccessStatus? successStatus;
  final double? lineBoxHeight;
  final double? lineBoxWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: lineBoxHeight ?? Get.height * .1,
      width: lineBoxWidth ?? Get.width * .08,
      child: CustomPaint(
        foregroundPainter: LinePainter(successStatus != null ? successStatus!.getSuccessStatusColor : SuccessStatus.neutral.getSuccessStatusColor),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  final Color lineColor;

  LinePainter(this.lineColor);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 1.5
      ..color = lineColor;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
