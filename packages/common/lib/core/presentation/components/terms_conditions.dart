import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../utils/app_text.dart';
import '../utils/dialog_content_utils.dart';

class TermsAndConditionsDialog extends StatelessWidget {
  final bool showPalTermsAndConditions;

  const TermsAndConditionsDialog(
      {Key? key, this.showPalTermsAndConditions = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                data: AppConstants.truePalTermsConditionsText,
                textAlign: TextAlign.left,
                fontColor: ColorUtils.blackColor,
                fontWeight: FontWeight.w800,
                fontSize: Sizes.textSize16,
                textDecoration: TextDecoration.underline,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  child: Text(
                    showPalTermsAndConditions
                        ? TermsPrivacyDisclaimerConstant.truePalTermsConditions
                        : TermsPrivacyDisclaimerConstant
                            .truePalMemberTermsAndCondition,
                    textAlign: TextAlign.left,
                    style: FontStyles.interStyle(
                        textColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MemberAngelAppButton(
                    buttonWidth: 120,
                    buttonHeight: 40,
                    label: AppConstants.close,
                    onSuccessHandler: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
