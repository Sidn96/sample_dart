import 'package:common/features/risk_profile/domain/enum/risk_profile_ans_enum.dart';
import 'package:common/features/risk_profile/presentation/widgets/risk_profile_q5_choices_label.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'q5_loss_bearing_provider.g.dart';

@Riverpod(keepAlive: true)
class RiskProfileLossBearingNotifier extends _$RiskProfileLossBearingNotifier {
  int selectedIndex = -1;

  List<Widget> ansChoices = [];

  @override
  int build() {
    ansChoices = [
      const LossBearingBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansOne,
      ),
      const LossBearingBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansTwo,
      ),
      const LossBearingBarLabel(
        selectedAnsIndexEnum: SelectedRiskProfileAns.ansThree,
      ),
    ];
    return selectedIndex;
  }

  setLossBearingSelection(int position) {
    selectedIndex = position;
    state = selectedIndex;
  }
}
