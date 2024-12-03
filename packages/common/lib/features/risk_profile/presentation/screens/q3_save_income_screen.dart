import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/presentation/components/q3_save_income_choices_component.dart';
import 'package:common/features/risk_profile/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RiskProfileStep3SaveIncome extends StatelessWidget {
  const RiskProfileStep3SaveIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleWidget(
          titleNumber: AppConstants.number3,
          titleName: AppConstants.howMuchSaveIncome,
        ),
        SizedBox(height: 20),
        RiskProfSaveIncomeChoicesMolecule()
        //AgeRangeChipWidget(),
      ],
    );
  }
}
