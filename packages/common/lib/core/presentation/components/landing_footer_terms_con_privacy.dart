import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../utils/app_string_constants.dart';
import 'disclaimer.dart';
import 'privacy_policy.dart';
import 'terms_conditions.dart';

class LandingFooterTermsConPrivacy extends StatelessWidget {
  final double defaultPadding = 20;
  final String? legalDisclaimer;
  final bool showLegalDisclaimer;
  final bool showPalTermsAndConditions;
  const LandingFooterTermsConPrivacy(
      {Key? key,
      this.legalDisclaimer,
      this.showLegalDisclaimer = true,
      this.showPalTermsAndConditions = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => showDialog(
              useRootNavigator: false,
              context: context,
              builder: (context) => TermsAndConditionsDialog(
                    showPalTermsAndConditions: showPalTermsAndConditions,
                  )),
          child: Text(
            AppConstants.termsConditions,
            textAlign: TextAlign.left,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kGreyLightColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 5),
        const SizedBox(
          height: 10,
          child: VerticalDivider(color: ColorUtils.kGreyBorderColor, width: 10),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () => showDialog(
             useRootNavigator: false,
              context: context,
              builder: (context) => const PrivacyPolicyDialog()),
          child: Text(
            AppConstants.privacy,
            textAlign: TextAlign.left,
            style: FontStyles.interStyle(
              textColor: ColorUtils.kGreyLightColor,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 5),
        if (showLegalDisclaimer) ...[
          const SizedBox(
            height: 10,
            child:
                VerticalDivider(color: ColorUtils.kGreyBorderColor, width: 10),
          ),
          const SizedBox(width: 5),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () => showDialog(
                  useRootNavigator: false,
                  context: context,
                  builder: (context) => const DisclaimerDialog()),
              child: Text(
                legalDisclaimer ?? AppConstants.legalDisclaimer1,
                textAlign: TextAlign.left,
                style: FontStyles.interStyle(
                  textColor: ColorUtils.kGreyLightColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
