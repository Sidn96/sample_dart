import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/presentation/components/q4_portfolio_gain_choices_component.dart';
import 'package:common/features/risk_profile/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RiskProfileStep4PortfolioGain extends StatelessWidget {
  const RiskProfileStep4PortfolioGain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TitleWidget(
          titleNumber: AppConstants.number4,
          titleName: AppConstants.howMuchPortfolioGain,
        ),
        SizedBox(
          height: 20,
        ),
        RiskProfPortfolioGainChoicesMolecule()
        //AgeRangeChipWidget(),
      ],
    );
  }
}
