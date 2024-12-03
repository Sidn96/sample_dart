import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/features/risk_profile/presentation/providers/q5_loss_bearing_provider.dart';
import 'package:common/features/risk_profile/presentation/widgets/answer_selection_item.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiskProfLossBearingChoicesMolecule extends HookConsumerWidget {
  const RiskProfLossBearingChoicesMolecule({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedSaveIncomeChoice =
        ref.watch(riskProfileLossBearingNotifierProvider);
    final annualIncomeMultipleChoices =
        ref.watch(riskProfileLossBearingNotifierProvider.notifier).ansChoices;

    return Padding(
      padding: const EdgeInsets.only(left: 24.0,right: 8),
      child: Row(
        children: ref
            .watch(riskProfileLossBearingNotifierProvider.notifier)
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
                          .read(riskProfileLossBearingNotifierProvider.notifier)
                          .setLossBearingSelection(index);
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
