import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/widgets/risk_profile_q3_choices_label.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q3_save_income_provider.g.dart';

@Riverpod(keepAlive: true)
class RiskProfileSaveIncomeNotifier
    extends _$RiskProfileSaveIncomeNotifier {
  int selectedIndex = -1;

  List<Widget> ansChoices = [];

  @override
  int build() {
    ansChoices = [
      const SaveIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansOne,
      ),
      const SaveIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansTwo,
      ),
      const SaveIncomeBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansThree,
      ),
    ];
    return selectedIndex;
  }

  setSaveIncomeSelection(int position) {
    selectedIndex = position;
    state = selectedIndex;
  }
}
