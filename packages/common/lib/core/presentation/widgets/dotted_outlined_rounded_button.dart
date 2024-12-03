import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/widgets/dash_border.dart';
import 'package:flutter/material.dart';

class DottedOutlinedRoundedButton extends StatelessWidget {
  final Function()? onTap;
  final String label;
  final Color? bgColor;
  final Color? dotColor;
  const DottedOutlinedRoundedButton(
      {super.key,
      this.bgColor,
      required this.label,
      this.onTap,
      this.dotColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          border: bgColor == null
              ? DashedBorder.all(
                  dashLength: 3, color: dotColor ?? ColorUtilsV2.hex_C3C4FE)
              : null,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: AppTextV2(
          data: label,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontColor: ColorUtilsV2.hex_5D5D70,
        ),
      ),
    );
  }
}
