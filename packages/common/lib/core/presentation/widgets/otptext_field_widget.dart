import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../styles/font_styles.dart';
import '../styles/sizes.dart';

class OtpTextFieldWidget extends StatelessWidget {
  final OnCodeEnteredCompletion? onCodeChanged;
  final OnCodeEnteredCompletion? onSubmit;
  const OtpTextFieldWidget({
    this.onSubmit,
    this.onCodeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: OtpTextField(
        numberOfFields: 4,
        borderColor: ColorUtils.kGreyLightColor,
        focusedBorderColor: ColorUtils.kBlueLightColor,
        showFieldAsBox: false,
        borderWidth: 2.0,
        fieldWidth: 52,
        fillColor: ColorUtils.kBlueLightColor,
        styles: [otpStyle(), otpStyle(), otpStyle(), otpStyle()],
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
        ],
        onCodeChanged: onCodeChanged,
        onSubmit: onSubmit,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
  TextStyle otpStyle() => FontStyles.interStyle(
    fontSize: Sizes.textSize16,
    fontWeight: FontWeight.w700,
  );
}