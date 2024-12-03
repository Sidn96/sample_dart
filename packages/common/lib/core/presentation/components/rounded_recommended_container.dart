import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

import '../utils/app_string_constants.dart';

class RoundedRecommendedContainer extends StatelessWidget {
  const RoundedRecommendedContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 115,
      decoration: BoxDecoration(
        color: ColorUtils.recommendedYellowColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AssetUtils.starAnnual,
              package: "common", height: 12, width: 12),
          const SizedBox(width: 5), // Gap of 5 pixels
          const AppText(
              data: AppConstants.recommended,
              fontSize: Sizes.textSize10,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
              fontColor: ColorUtils.kDarkBlue),
        ],
      ),
    );
  }
}
