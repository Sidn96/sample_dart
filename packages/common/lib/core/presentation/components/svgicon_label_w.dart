import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_text.dart';

class SVGIconLabelW extends StatelessWidget {
  final String iconName;
  final String label;
  const SVGIconLabelW({super.key, required this.iconName, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconName),
        10.width,
        AppText(
          data: label,
          fontSize: Sizes.textSize12,
          fontColor: ColorUtils.greyTextColor,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
          height: 1.4,
        ),
      ],
    );
  }
}
