import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/widgets/risk_profile_q4_choices_label.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q4_portfolio_gain_provider.g.dart';

@Riverpod(keepAlive: true)
class RiskProfilePortfolioGainNotifier
    extends _$RiskProfilePortfolioGainNotifier {
  int selectedIndex = -1;

  List<Widget> ansChoices = [];

  @override
  int build() {
    ansChoices = [
      const PortfolioGainBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansOne,
      ),
      const PortfolioGainBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansTwo,
      ),
      const PortfolioGainBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansThree,
      ),
    ];
    return selectedIndex;
  }

  setPortfolioGainSelection(int position) {
    selectedIndex = position;
    state = selectedIndex;
  }
}
