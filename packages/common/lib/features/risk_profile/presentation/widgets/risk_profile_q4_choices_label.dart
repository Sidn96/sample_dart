import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/q4_portfolio_gain_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PortfolioGainBarLabel extends HookConsumerWidget {
  final SelectedRiskProfileAns selectedAnsIndexEnum;

  const PortfolioGainBarLabel({super.key, required this.selectedAnsIndexEnum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionValue = ref.watch(riskProfilePortfolioGainNotifierProvider);

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansOne) {
      return label1(selectionValue, "Sell ");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansTwo) {
      return label2(selectionValue, "Hold");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansThree) {
      return label3(selectionValue, "Buy");
    }
    return Container();
  }

  Widget label1(int selectionVal, String boldText) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: "I Will\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: boldText,
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
            TextSpan(
              text: " My\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: "Portfolio",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget label2(int selectionVal, String boldText) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: "I Will\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: boldText,
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
            TextSpan(
              text: " My\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: "Portfolio",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget label3(int selectionVal, String boldText) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: "I Will\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: boldText,
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w600,
                  height: 1.3),
            ),
            TextSpan(
              text: " My\n",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
            TextSpan(
              text: "Portfolio",
              style: TextStyles.manropeStyle(Sizes.textSize12,
                  color: ColorUtilsV2.specialNeutral600,
                  fontWeight: FontWeight.w400,
                  height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}
