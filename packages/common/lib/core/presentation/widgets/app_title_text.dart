import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

/// Widget for Main titles
/// size 16
/// FontWeight.w500
/// specialNeutral700 35354D
class AppTitleText extends StatelessWidget {
  final String title;
  Color? textColor;
  double? fontSize;
  FontWeight? fontWeight;
  double? height;
  TextAlign? textAlign;
  AppTitleText(
      {super.key,
      required this.title,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return AppTextV2(
      data: title,
      fontColor: textColor ?? ColorUtilsV2.hex_35354D,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.w300,
      height: height ?? 1.2,
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
