import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppTextButtonWithNextArrow extends StatelessWidget {
  final String label;
  final Function() onTap;
  final FontWeight fontWeight;
  final double textSize;
  final Color textColor;
  final bool showSuffixIcon;
  final MainAxisAlignment rowMainAlignment;

  const AppTextButtonWithNextArrow({
    super.key,
    required this.label,
    required this.onTap,
    this.fontWeight = FontWeight.normal,
    this.textSize = Sizes.defaultTextSize,
    this.textColor = ColorUtilsV2.hex_000000,
    this.showSuffixIcon = false,
    this.rowMainAlignment = MainAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: rowMainAlignment,
        children: [
          AppTextV2(
            data: label,
            fontSize: textSize,
            fontWeight: fontWeight,
            fontColor: textColor,
          ),
          Visibility(
            visible: showSuffixIcon,
            child: const SizedBox(width: 5.0),
          ),
          Visibility(
            visible: showSuffixIcon,
            child: SvgPicture.asset(
              AssetUtils.nextArrowIcon,
              package: "common",
              width: 10.0,
              height: 10.0,
              colorFilter: const ColorFilter.mode(
                ColorUtilsV2.specialBackground500,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
