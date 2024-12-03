import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/font_styles.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../utils/app_text.dart';
import '../utils/dialog_content_utils.dart';

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({Key? key}) : super(key: key);

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
                data: AppConstants.disclaimerText,
                textAlign: TextAlign.left,
                textDecoration: TextDecoration.underline,
                fontColor: ColorUtils.blackColor,
                fontWeight: FontWeight.w800,
                fontSize: Sizes.textSize16,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                height: 300.0,
                child: SingleChildScrollView(
                  child: Text(
                    TermsPrivacyDisclaimerConstant.truePalLegalDeclaimer,
                    textAlign: TextAlign.left,
                    style: FontStyles.interStyle(
                        textColor: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
