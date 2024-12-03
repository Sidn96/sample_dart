import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/presentation/components/q2_annual_income_choices_component.dart';
import 'package:common/features/risk_profile/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RiskProfileStep2AnnualIncome extends StatelessWidget {
  const RiskProfileStep2AnnualIncome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleWidget(
          titleNumber: AppConstants.number2,
          titleName: AppConstants.whatIsAnnualIncome,
        ),
        SizedBox(height: 20),
        RiskProfAnnualIncomeChoicesMolecule()
        //AgeRangeChipWidget(),
      ],
    );
  }
}
