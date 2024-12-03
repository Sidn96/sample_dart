import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

class UnderLineW extends StatelessWidget {
  final Widget? child;
  final Color? color;
  const UnderLineW({super.key, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: color ?? ColorUtilsV2.hex_2563EB,
        width: 1.0, // This would be the width of the underline
      ))),
      child: child,
    );
  }
}
