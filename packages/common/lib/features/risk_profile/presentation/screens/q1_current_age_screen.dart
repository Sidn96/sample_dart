
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/presentation/components/q1_current_age_chips_component.dart';
import 'package:common/features/risk_profile/presentation/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class RiskProfileStepOneAge extends StatelessWidget {
  const RiskProfileStepOneAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              titleNumber: AppConstants.number1,
              titleName: AppConstants.whatsYourCurrentAge,
            ),
            SizedBox(height: 20),
            RiskProfileAgeChip(),
          ],
          //   ),
        ),
      ),
    );
  }
}
