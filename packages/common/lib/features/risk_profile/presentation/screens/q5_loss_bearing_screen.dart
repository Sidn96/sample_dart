import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/presentation/components/q5_loss_bearing_choices_component.dart';
import 'package:common/features/risk_profile/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RiskProfileStep5LossBearing extends StatelessWidget {
  const RiskProfileStep5LossBearing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleWidget(
          titleNumber: AppConstants.number5,
          titleName: AppConstants.howMuchLossBearing,
        ),
        SizedBox(
          height: 20,
        ),
        RiskProfLossBearingChoicesMolecule()
        //AgeRangeChipWidget(),
      ],
    );
  }
}
