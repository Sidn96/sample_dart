import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/models/app_chip_model.dart';
import 'package:flutter/material.dart';

class AppChipWidget extends StatelessWidget {
  final AppChipModel model;
  final VoidCallback onSelected;
  final Color activeChipBgColor;
  final Color disabledColor;

  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;
  final bool isSelected;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? borderColor;
  final TextStyle? textLabelStyle;

  const AppChipWidget({
    super.key,
    required this.model,
    required this.onSelected,
    this.activeChipBgColor = ColorUtilsV2.specialSuccess300,
    this.disabledColor = ColorUtilsV2.neutral100,
    this.width,
    this.height = 35,
    this.contentPadding = EdgeInsets.zero,
    this.isSelected = false,
    this.activeTextColor = ColorUtilsV2.specialNeutral700,
    this.inactiveTextColor = ColorUtilsV2.specialNeutral700,
    this.borderColor,
    this.textLabelStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        width: width,
        height: height,
        padding: (width == null) ? null : contentPadding,
        decoration: BoxDecoration(
            color: isSelected ? activeChipBgColor : disabledColor,
            border: isSelected
                ? null
                : Border.all(color: borderColor ?? disabledColor),
            // border: isSelected ? null : RDottedLineBorder.all(width: 1.0, color: ColorUtilsV2.specialBackground200),
            borderRadius: const BorderRadius.all(Radius.circular(30))),
        alignment: Alignment.center,
        child: AppTextV2(
          textStyle: textLabelStyle,
          data: model.label,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontColor: isSelected ? activeTextColor : inactiveTextColor,
        ),
      ),
    );
  }
}

class AppChipWidgetV2 extends StatelessWidget {
  final String textForDisplay;
  final Color chipColor;
  final Color textColor;
  final double textSize;
  final double textHeight;
  final EdgeInsets? padding;
  final double? borderRadius;

  const AppChipWidgetV2(
      {super.key,
      required this.textForDisplay,
      required this.chipColor,
      required this.textColor,
      this.textSize = 11.0,
      this.textHeight = 1.0,
      this.padding,this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:padding?? const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 24.0), color: chipColor),
      child: AppTextV2(
        height: textHeight,
        data: textForDisplay,
        fontSize: textSize,
        fontColor: textColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
