import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class DashedLineHorizontalPainter extends CustomPainter {
  final Color? dotColor;
  DashedLineHorizontalPainter({
    this.dotColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4, dashSpace = 2, startX = 0;
    final paint = Paint()
      ..color = dotColor ?? ColorUtils.kTabDisabledTextColor
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
