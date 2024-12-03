import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/q2_annual_income_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AnnualIncomeBarLabel extends HookConsumerWidget {
  final SelectedRiskProfileAns selectedAnsIndexEnum;

  const AnnualIncomeBarLabel({super.key, required this.selectedAnsIndexEnum});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectionValue = ref.watch(riskProfileAnnualIncomeNotifierProvider);

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansOne) {
      return label1(selectionValue, "Less Than ", "10L");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansTwo) {
      return label2(selectionValue, "Between ", "10-25L");
    }

    if (selectedAnsIndexEnum == SelectedRiskProfileAns.ansThree) {
      return label3(selectionValue, "More Than ", "25L");
    }
    return const SizedBox.shrink();
  }

  Widget label1(int selectionVal, String normalText, String boldText) {
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
            textAlign: TextAlign.start,
          ),
          AppTextWithoutAutoSize(
            textAlign: TextAlign.start,
            fontColor: selectionVal == 0
                ? ColorUtilsV2.specialNeutral600
                : ColorUtilsV2.specialNeutral600,
            fontWeight: FontWeight.w600,
            data: "${AppConstants.rupeesSymbol}$boldText",
            fontSize: Sizes.textSize12,
          ),
        ],
      ),
    );
  }

  Widget label2(int selectionVal, String normalText, String boldText) {
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
            textAlign: TextAlign.start,
          ),
          AppTextWithoutAutoSize(
            data: "${AppConstants.rupeesSymbol}$boldText",
            fontColor: ColorUtilsV2.specialNeutral600,
            fontSize: Sizes.textSize12,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
          ),
        ],
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
            textAlign: TextAlign.start,
          ),
          AppTextWithoutAutoSize(
            data: "${AppConstants.rupeesSymbol}$boldText",
            fontColor: ColorUtilsV2.specialNeutral600,
            fontSize: Sizes.textSize12,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
