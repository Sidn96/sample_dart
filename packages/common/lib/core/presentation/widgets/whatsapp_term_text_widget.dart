import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';

class WhatsAppTermTextWidget extends StatelessWidget {
  const WhatsAppTermTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: AppConstants.whatsAppDisclaim,
            style: styleText(),
          ),
          TextSpan(
            text: "What’sApp",
            style: styleText(
              fcolor: ColorUtils.kBlueColor,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Single tapped.
              },
          ),
        ],
      ),
    );
  }

  TextStyle styleText({Color? fcolor}) {
    return TextStyle(
      fontSize: Sizes.textSize10,
      fontWeight: FontWeight.w400,
      color: fcolor,
    );
  }
}