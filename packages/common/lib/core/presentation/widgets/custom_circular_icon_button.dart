import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class CustomCircularIconButton extends StatelessWidget {
  final Function()? onTapCallback;
  final Color backgroundColor;
  final Color borderColor;
  final double? circleHeight;
  final double? circleWidth;
  final bool isRoundedBorder;
  final Widget childWidget;

  const CustomCircularIconButton({
    super.key,
    this.onTapCallback,
    this.backgroundColor = ColorUtilsV2.genericWhite,
    this.borderColor = ColorUtilsV2.specialNeutral300,
    this.circleHeight,
    this.circleWidth,
    this.isRoundedBorder = false,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTapCallback?.call(),
      child: Container(
        height: circleHeight ?? 30.w,
        width: circleWidth ?? 30.w,
        margin: const EdgeInsets.only(top: 5.0, right: 5.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: isRoundedBorder
              ? RDottedLineBorder.all(
            color: borderColor,
          )
              : Border.all(color: borderColor),
        ),
        child: childWidget,
      ),
    );
  }
}