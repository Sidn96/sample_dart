import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:common/core/presentation/styles/font_styles.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../utils/app_string_constants.dart';
import 'landing_footer_terms_con_privacy.dart';
import 'landing_header_logo.dart';

class LandingFooterPage extends StatelessWidget {
  final String? footerLogo;
  final bool? isLogoSvg;
  final bool? showCallUsWidget;
  final String? emailId;
  final String? phoneNumber;
  final double? width;
  final String? legalDisclaimer;
  final String? copyRightText;
  final bool showAboutUsLegalDisclaimerWidgets;
  final bool? showLegalDisclaimer;
  final bool showPalTermsAndCondition;
  final AlignmentGeometry? connectUsAlignment;
  final bool increaseHeight;
  const LandingFooterPage(
      {Key? key,
      this.showLegalDisclaimer,
      this.showAboutUsLegalDisclaimerWidgets = true,
      this.footerLogo,
      this.isLogoSvg,
      this.showCallUsWidget,
      this.emailId,
      this.width,
      this.legalDisclaimer,
      this.phoneNumber,
      this.showPalTermsAndCondition = true,
      this.copyRightText,
      this.connectUsAlignment,
      this.increaseHeight = false})
      : super(key: key);
  final double defaultPadding = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtils.kBlackDark,
      padding: EdgeInsets.symmetric(vertical: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: LandingFooterLogo(
                footerLogo: footerLogo,
                isLogoSvg: isLogoSvg,
                showCallUsWidget: showCallUsWidget,
                connectUsAlignment: connectUsAlignment,
                emailId: emailId,
                width: width ?? 100,
                phoneNumber: phoneNumber),
          ),
          //TODO: need faq from product
          if (showAboutUsLegalDisclaimerWidgets) ...[
            const SizedBox(height: 28),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: AppText(
                  data: "About Us",
                  fontSize: FontSizes.normalTextSize,
                  fontColor: ColorUtils.kOffWhiteColor,
                  fontWeight: FontStyles.fontWeightExtraBold),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 19.0),
              child: Container(height: 1, color: ColorUtils.kDarkBlue),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: AppText(
                  data: "FAQs",
                  fontSize: FontSizes.normalTextSize,
                  fontColor: ColorUtils.kOffWhiteColor,
                  fontWeight: FontStyles.fontWeightExtraBold),
            ),
          ],
          const SizedBox(
            height: 20,
          ),
          Container(height: 1, color: ColorUtils.kDarkBlue),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: LandingFooterTermsConPrivacy(
                legalDisclaimer: legalDisclaimer,
                showPalTermsAndConditions: showPalTermsAndCondition,
                showLegalDisclaimer: showLegalDisclaimer ?? true),
          ),
          const SizedBox(height: 13),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Text(
              copyRightText ?? AppConstants.copyright,
              textAlign: TextAlign.left,
              style: FontStyles.poppinsStyle(
                  textColor: ColorUtils.kGreyLightColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w500),
            ),
          ),
          if (increaseHeight) const SizedBox(height: 100),
        ],
      ),
    );
  }
}
