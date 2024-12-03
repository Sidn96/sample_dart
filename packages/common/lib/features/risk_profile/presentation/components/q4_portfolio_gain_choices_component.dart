import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/features/risk_profile/presentation/providers/q4_portfolio_gain_provider.dart';
import 'package:common/features/risk_profile/presentation/widgets/answer_selection_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiskProfPortfolioGainChoicesMolecule extends HookConsumerWidget {
  const RiskProfPortfolioGainChoicesMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSaveIncomeChoice =
        ref.watch(riskProfilePortfolioGainNotifierProvider);
    final annualIncomeMultipleChoices =
        ref.watch(riskProfilePortfolioGainNotifierProvider.notifier).ansChoices;

    return Padding(
      padding: const EdgeInsets.only(left: 24.0,right: 8),
      child: Row(
        children: ref.watch(riskProfilePortfolioGainNotifierProvider.notifier)
            .ansChoices
            .asMap()
            .map((index, value) => MapEntry(
                index,
                Expanded(
                  child: AnswerSelectionWidget(
                    index: index,
                    selectedOptionColor: selectedSaveIncomeChoice == index
                        ? ColorUtils.kGreenLightColor
                        : ColorUtils.transparent,
                    labelWidget: annualIncomeMultipleChoices[index],
                    onTap: () {
                      ref
                          .read(riskProfilePortfolioGainNotifierProvider.notifier)
                          .setPortfolioGainSelection(index);
                    },
                    isOptionSelected: selectedSaveIncomeChoice == index,
                  ),
                )))
            .values
            .toList(),
      ),
    );
  }
}
