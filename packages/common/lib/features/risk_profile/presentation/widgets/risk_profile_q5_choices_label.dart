import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/q5_loss_bearing_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LossBearingBarLabel extends HookConsumerWidget {
  final SelectedRiskProfileAns selectedAnsIndexEnum;

  const LossBearingBarLabel({super.key, required this.selectedAnsIndexEnum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionValue = ref.watch(riskProfileLossBearingNotifierProvider);

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansOne) {
      return label1("0%");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansTwo) {
      return label2(selectionValue, "0-20%");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansThree) {
      return label3(selectionValue, "More Than ", "20%");
    }
    return Container();
  }

  Widget label1(String boldText) {
    return AppTextWithoutAutoSize(
        data: boldText,
        fontColor: ColorUtilsV2.specialNeutral600,
        fontSize: Sizes.textSize12,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center);
  }

  Widget label2(int selectionVal, String boldText) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Between ",
              style: TextStyles.manropeStyle(
                Sizes.textSize12,
                color: ColorUtilsV2.specialNeutral600,
                fontWeight: FontWeight.w400,
                height: 1.3,
              ),
            ),
            TextSpan(
              text: boldText,
              style: TextStyles.manropeStyle(
                Sizes.textSize12,
                color: ColorUtilsV2.specialNeutral600,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget label3(int selectionVal, String normalText, String boldText) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextWithoutAutoSize(
              data: normalText,
              fontColor: ColorUtilsV2.specialNeutral600,
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start),
          AppTextWithoutAutoSize(
              data: boldText,
              fontColor: ColorUtilsV2.specialNeutral600,
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.start),
        ],
      ),
    );
  }
}
