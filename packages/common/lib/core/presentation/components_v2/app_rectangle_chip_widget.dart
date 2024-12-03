import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:flutter/material.dart';

class AppRectangleChipWidget extends StatelessWidget {
  final dynamic model;
  final VoidCallback onSelected;
  final Color activeColor;
  final Color disabledColor;

  final double? width;
  final double? height;
  final EdgeInsets? contentPadding;
  final EdgeInsets? contentMargin;
  final bool isSelected;
  final Color? activeTextColor;
  final Color? inactiveTextColor;

  const AppRectangleChipWidget({
    super.key,
    required this.model,
    required this.onSelected,
    required this.activeColor,
    required this.disabledColor,
    this.width,
    this.height = 35,
    this.contentPadding = const EdgeInsets.symmetric(vertical: 17),
    required this.contentMargin,
    this.isSelected = false,
    this.activeTextColor = ColorUtilsV2.specialNeutral700,
    this.inactiveTextColor = ColorUtilsV2.specialNeutral700,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: contentMargin,
            width: width,
            height: height,
            padding: contentPadding,
            decoration: !isSelected ? BoxDecoration(
                color: isSelected ? activeColor : disabledColor,
                border: Border.all(style: BorderStyle.solid, color: ColorUtils.disabledColor),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ) : BoxDecoration(
              color: isSelected ? activeColor : disabledColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            //alignment: Alignment.center,
            child: AppTextV2(
              data: model.prequoteDisplayName,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              fontColor: isSelected ? activeTextColor : inactiveTextColor,
            ),
          ),

          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: const BoxDecoration(
                color: ColorUtils.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              alignment: Alignment.center,
              child: AppTextV2(
                data: model.prequoteDisplayYears,
                fontSize: FontSizes.textSize11,
                fontWeight: FontWeight.w400,
                fontColor: ColorUtils.greyTextColor,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
