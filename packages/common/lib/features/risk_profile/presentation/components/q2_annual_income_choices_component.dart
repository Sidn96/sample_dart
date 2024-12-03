import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/features/risk_profile/presentation/providers/q2_annual_income_provider.dart';
import 'package:common/features/risk_profile/presentation/widgets/answer_selection_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class RiskProfAnnualIncomeChoicesMolecule extends HookConsumerWidget {
  const RiskProfAnnualIncomeChoicesMolecule({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedAnnualChoice = ref.watch(riskProfileAnnualIncomeNotifierProvider);
    final annualIncomeChoices = ref.watch(riskProfileAnnualIncomeNotifierProvider.notifier).ansChoices;
        return Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 8),
          child: Row(
            children: ref.watch(riskProfileAnnualIncomeNotifierProvider.notifier).ansChoices.asMap()
                .map((index, value) => MapEntry(
                index,
                Expanded(
                  child: AnswerSelectionWidget(
                    index: index,
                    selectedOptionColor: selectedAnnualChoice == index
                        ? ColorUtils.kGreenLightColor
                        : ColorUtils.transparent,
                    labelWidget: annualIncomeChoices[index],
                    onTap: () {
                      ref
                          .read(
                          riskProfileAnnualIncomeNotifierProvider.notifier)
                          .setAnnualSelection(index);
                    },
                    isOptionSelected: selectedAnnualChoice == index,
                  ),
                )
            ))
                .values
                .toList(),
          ),
        );

  }
}
