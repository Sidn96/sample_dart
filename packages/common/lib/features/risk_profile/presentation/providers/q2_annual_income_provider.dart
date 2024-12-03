import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/widgets/risk_profile_q2_choices_label.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q2_annual_income_provider.g.dart';

@Riverpod(keepAlive: true)
class RiskProfileAnnualIncomeNotifier
    extends _$RiskProfileAnnualIncomeNotifier {
  int selectedIndex = -1;

  List<Widget> ansChoices = [];

  @override
  int build() {
    ansChoices = [
      const AnnualIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansOne,
      ),
      const AnnualIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansTwo,
      ),
      const AnnualIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansThree,
      ),
    ];
    return selectedIndex;
  }

  setAnnualSelection(int position) {
    selectedIndex = position;
    state = selectedIndex;
  }
}
