import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/dialog_content_utils.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_tnc_pp_whats.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MemberPalTermConditonBody extends ConsumerWidget {
  const MemberPalTermConditonBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(memberSignUpLoginProvierProvider);
    return RichText(
      text: TextSpan(
        children: [
          const TextSpan(
            text: AppConstants.iAcceptThe,
            style: TextStyle(
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w400,
              color: ColorUtils.blackNeutralColor,
              letterSpacing: 0.24,
            ),
          ),
          TextSpan(
            text: AppConstants.termAndCond,
            style: styleText(
              fcolor: ColorUtilsV2.hex_2563EB,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
                showDialog(
                  context: context,
                  builder: (context) => CommonTermsAndConditionsDialog(
                    termAndConditionsContent: loginForm.source ==
                            LoginFormEnum.eldercare.value
                        ? TermsPrivacyDisclaimerConstant
                            .truePalMemberTermsAndCondition
                        : TermsPrivacyDisclaimerConstant.truePalTermsConditions,
                    termAndConditionsContentHeader:
                        loginForm.source == LoginFormEnum.eldercare.value
                            ? AppConstants.truePalTermsConditionsText
                            : AppConstants.truePalTermsConditionsText,
                  ),
                );
              },
          ),
          const TextSpan(
            text: " &",
            style: TextStyle(
              fontSize: Sizes.textSize12,
              fontWeight: FontWeight.w400,
              color: ColorUtils.blackNeutralColor,
              letterSpacing: 0.24,
            ),
          ),
          TextSpan(
            text: AppConstants.privacyPolicy,
            style: styleText(
              fcolor: ColorUtilsV2.hex_2563EB,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
                showDialog(
                  context: context,
                  builder: (context) => CommonTermsAndConditionsDialog(
                    termAndConditionsContent: loginForm.source ==
                            LoginFormEnum.eldercare.value
                        ? TermsPrivacyDisclaimerConstant.truePalPrivacyPolicy
                        : TermsPrivacyDisclaimerConstant.truePalPrivacyPolicy,
                    termAndConditionsContentHeader:
                        loginForm.source == LoginFormEnum.eldercare.value
                            ? AppConstants.truePalPrivacyPolicyText
                            : AppConstants.truePalPrivacyPolicyText,
                  ),
                );
              },
          ),
        ],
      ),
    );
  }

  TextStyle styleText({Color? fcolor}) {
    return TextStyle(
      fontSize: Sizes.textSize12,
      fontWeight: FontWeight.w600,
      color: fcolor ?? ColorUtils.blackNeutralColor,
      letterSpacing: 0.24,
    );
  }
}
