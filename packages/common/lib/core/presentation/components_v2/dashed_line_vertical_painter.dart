import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class DashedLineVerticalPainter extends CustomPainter {
  final int dashSpace;
  final Color? dashColor;
  DashedLineVerticalPainter({this.dashSpace = 3, this.dashColor});
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    double dashHeight = 4, startY = 0;
    final paint = Paint()
      ..color = dashColor ?? ColorUtils.bluishblack
      ..strokeWidth = 1;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
