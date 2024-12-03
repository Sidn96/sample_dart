import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:flutter/material.dart';

class AnswerChipWidget extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final int index;
  final Color selectedChipBgColor;
  final double maxWidth;
  final double minHeight;
  final bool isSelected;

  const AnswerChipWidget({
    super.key,
    required this.index,
    required this.selectedChipBgColor,
    this.onTap,
    this.minHeight = 35,
    this.maxWidth = 70,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: selectedChipBgColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppTextV2(
              data: label,
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w600,
              fontColor: ColorUtilsV2.specialNeutral600,
            ),
            const AppTextV2(
              data: AppConstants.yrs,
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w400,
              fontColor: ColorUtilsV2.specialNeutral600,
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
