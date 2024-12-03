import 'package:common/core/presentation/widgets/member_app_button.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../utils/app_text.dart';
import '../utils/dialog_content_utils.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({Key? key}) : super(key: key);

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
                data: AppConstants.privacyText,
                textAlign: TextAlign.left,
                fontSize: Sizes.textSize16,
                fontWeight: FontWeight.w800,
                fontColor: ColorUtils.blackColor,
                textDecoration: TextDecoration.underline,
                // decoration: TextDecoration.underline,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                    TermsPrivacyDisclaimerConstant.truePalPrivacyPolicy,
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
