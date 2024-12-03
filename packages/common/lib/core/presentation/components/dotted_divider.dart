import 'package:flutter/material.dart';

import 'dotted_line.dart';

class DottedDivider extends StatelessWidget {
  final double? dashLength;
  final double? lineThickness;
  final Color? color;
  const DottedDivider(
      {super.key, this.dashLength, this.lineThickness, this.color});

  @override
  Widget build(BuildContext context) => DottedLine(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      lineLength: double.infinity,
      dashLength: dashLength ?? 3.0,
      lineThickness: lineThickness ?? 1.0,
      dashColor: color ?? const Color(0x809CA3AF));
}
