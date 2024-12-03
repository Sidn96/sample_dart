import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:custom_dotted_border/custom_dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

class AppRoundChipWidget extends StatelessWidget {
  final dynamic  model;
  final VoidCallback onSelected;
  final Color activeColor;
  final Color disabledColor;
  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;
  final bool isSelected;
  final Color? activeTextColor;
  final Color? inactiveTextColor;

  const AppRoundChipWidget({
    super.key,
    required this.model,
    required this.onSelected,
    required this.activeColor,
    required this.disabledColor,
    this.width,
    this.height = 35,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 17),
    this.isSelected = false,
    this.activeTextColor = ColorUtilsV2.specialNeutral700,
    this.inactiveTextColor = ColorUtilsV2.specialNeutral700,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: CustomDottedBorder(
        borderPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        dashPattern: const [3,3],
        strokeWidth: 1,
        color:isSelected ? Colors.transparent: ColorUtils.disabledColor,
        strokeCap: StrokeCap.round,
        borderType: BorderType.Circle,
        radius: const Radius.circular(0),
        child: Container(
          width: width,
          height: height,
          padding: (width != null) ? null : contentPadding,
          decoration: BoxDecoration(
              color: isSelected ? activeColor : disabledColor,
          /*    border: isSelected ? null : RDottedLineBorder.all(width: 1.0, color: ColorUtils.disabledColor,dottedSpace: 2,dottedLength: 3),*/
              shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: AppTextV2(
            data: model.displayName,
            fontSize: FontSizes.textSize12,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontColor: isSelected ? activeTextColor : inactiveTextColor,
          ),
        ),
      ),
    );
  }
}
