import 'package:common/core/presentation/components_v2/answer_chips_widget.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/question_chips_widget.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/features/risk_profile/presentation/providers/q1_current_age_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiskProfileAgeChip extends HookConsumerWidget {
  const RiskProfileAgeChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex =
        ref.watch(riskProfileQuestionOneAgeNotifierProvider.notifier);
    final selectedAgeIndex = ref.watch(riskProfileAnswerOneAgeNotifierProvider);
    final userProviderIndex = ref.watch(selectedUserAgeRPNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: selectedIndex.ageList
                .asMap()
                .map((index, value) => MapEntry(
                    index,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: QuestionChipsWidget(
                        labelText: '${selectedIndex.ageList[index]} yrs',
                        index: index,
                        disabledFontColor: ColorUtilsV2.hex_35354D,
                        borderColor: ColorUtilsV2.hex_C2C2C9,
                        indexChip: selectedIndex.selectedIndex,

                        onTap: () {
                          ref
                              .read(riskProfileAnswerOneAgeNotifierProvider
                                  .notifier)
                              .clearAllAnswers();
                          ref
                              .read(riskProfileQuestionOneAgeNotifierProvider
                                  .notifier)
                              .updateValue(index);
                          ref
                              .read(riskProfileAnswerOneAgeNotifierProvider
                                  .notifier)
                              .updateAgeValue(
                                AgeCalculation.ageList[index].lowerBound,
                                AgeCalculation.ageList[index].upperBound,
                                // int.parse(list[0]), int.parse(list[1])
                              );
                        },
                        selectedChipBgColor: selectedIndex.selectedIndex == index
                            ? ColorUtils.kGreenLightColor
                            : ColorUtils.white,
                      ),
                    )))
                .values
                .toList(),
          ),
          const SizedBox(
            height: 20,
          ),
          Wrap(
            spacing: 8,
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: selectedAgeIndex
                .asMap()
                .map((index, value) => MapEntry(
                    index,
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 8.0),
                      child: AnswerChipWidget(
                        label: selectedAgeIndex[index].toString(),
                        isSelected: userProviderIndex == index,
                        index: index,
                        onTap: () {
                          ref
                              .read(selectedUserAgeRPNotifierProvider.notifier)
                              .updateAgeValue(index);
                        },
                        selectedChipBgColor: userProviderIndex == index
                            ? ColorUtils.kGreenLightColor
                            : ColorUtils.midgray,
                      ),
                    )))
                .values
                .toList(),
          ),
        ],
      ),
    );
  }
}

class AgeCalculation {
  final int upperBound;
  final int lowerBound;
  final String displayAge;

  AgeCalculation(this.lowerBound, this.upperBound, this.displayAge);

  static List<AgeCalculation> ageList = [
    AgeCalculation(21, 30, "21-30"),
    AgeCalculation(31, 40, "31-40"),
    AgeCalculation(41, 50, "41-50"),
    AgeCalculation(51, 60, "51-60"),
    AgeCalculation(61, 70, "Above 60"),
  ];

  @override
  String toString() {
    return displayAge;
  }
}
