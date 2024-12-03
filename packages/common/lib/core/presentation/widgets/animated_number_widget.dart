import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:countup/countup.dart';
import 'package:flutter/material.dart';


class AnimatedNumberWidget extends StatelessWidget {
  final num endValue;
  final double fontSize;
  final Color textColor;

  const AnimatedNumberWidget({
    super.key,
    this.endValue = 0,
    this.fontSize = FontSizes.textSize12,
    this.textColor = ColorUtilsV2.hex_000000
  });

  @override
  Widget build(BuildContext context) {
    return Countup(
      begin: 0,
      end: endValue.toDouble(),
      suffix: '%',
      duration: const Duration(milliseconds: 3000),
      separator: ',',
      style: TextStyles.manropeStyle(
        fontSize,
        color: textColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}