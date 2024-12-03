import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';

class TermAndConditionTextWidget extends StatelessWidget {
  const TermAndConditionTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppConstants.iAcceptThe,
            style: styleText(),
          ),
          TextSpan(
            text: AppConstants.termAndCond,
            style: styleText(
              fcolor: ColorUtils.kBlueColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
              },
          ),
          TextSpan(
            text: ",",
            style: styleText(),
          ),
          TextSpan(
            text: AppConstants.privacyPolicy,
            style: styleText(
              fcolor: ColorUtils.kBlueColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
              },
          ),
          TextSpan(
            text: " & \n",
            style: styleText(),
          ),
          TextSpan(
            text: AppConstants.legalDisclaimer,
            style: styleText(
              fcolor: ColorUtils.kBlueColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
              },
          ),
          TextSpan(
            text: " of 100",
            style: styleText(),
          ),
        ],
      ),
    ));
  }

  TextStyle styleText({Color? fcolor}) {
    return TextStyle(
      fontSize: Sizes.textSize10,
      fontWeight: FontWeight.w400,
      color: fcolor,
    );
  }
}
