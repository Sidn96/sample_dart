import 'package:flutter/material.dart';

import '../components/app_button.dart';
import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';

class OtpButtonWidget extends StatelessWidget {
  const OtpButtonWidget({
    super.key,
    required this.isLoading,
    required this.otpOnboardingEntered,
    required this.continueOnPressed,
    required this.iAcceptOnboardTc,
  });

  final ValueNotifier<bool> isLoading;
  final ValueNotifier<bool> otpOnboardingEntered;
  final VoidCallback continueOnPressed;
  final ValueNotifier<bool> iAcceptOnboardTc;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25, top: 10),
        child: isLoading.value
            ? const CircularProgressIndicator(
          color: ColorUtils.kBlueColorDark,
        )
            : AppButton(
          label: AppConstants.continueLabel,
          buttonWidth: Sizes.screenWidth() * 0.9,
          buttonBgColor: (otpOnboardingEntered.value && iAcceptOnboardTc.value)
              ? ColorUtils.kBlueColor
              : ColorUtils.disabledColor,
          onPressed: (otpOnboardingEntered.value && iAcceptOnboardTc.value)
              ? continueOnPressed
              : () {},
        ));
  }
}