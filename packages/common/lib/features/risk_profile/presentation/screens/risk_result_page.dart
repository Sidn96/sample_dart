import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RiskProfileResultPage extends StatelessWidget {
  final String riskType;
  final String imagePath;
  final String subtext;

  const RiskProfileResultPage({
    super.key,
    required this.riskType,
    required this.imagePath,
    required this.subtext,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Sizes.screenHeight * .1,
        ),
        SvgPicture.asset(
          imagePath,
          height: 180,
          package: 'common',
        ),
        const SizedBox(height: 50),
        AppTextV2(
          data: riskType,
          fontSize: Sizes.textSize26,
          fontWeight: FontWeight.w500,
          fontColor: ColorUtilsV2.specialNeutral700,
        ),
        const SizedBox(height: 18),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppTextV2(
            data: subtext,
            fontSize: Sizes.textSize12,
            height: 1.3,
            fontWeight: FontWeight.w400,
            fontColor: ColorUtilsV2.specialNeutral600,
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
