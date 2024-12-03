import 'dart:async';

import 'package:common/core/presentation/components/app_button.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/new_login_notifiers.dart';
import 'package:flutter/material.dart';

import '../../../profile/presentation/common_imports.dart';
import '../providers/active_form_provider.dart';

class LoginFormBTN extends HookConsumerWidget {
  final ValueNotifier<bool> iAcceptTC;
  final ValueNotifier<bool>? isAdult;
  final ValueNotifier<bool>? isWhatApp;
  final bool? isAdultCheckbox;
  final TextEditingController mobileNumberController;
  final TextEditingController? otpController;
  final VoidCallback onGetOtpPressed;
  final VoidCallback onSubmitSuccessHandler;
  final Color? lightColor;
  final Color? darkColor;
  final Color? textLightColor;
  final Color? textDarkColor;
  final Color? borderColor;
  final Color? textColor;
  final FontWeight? buttonFontWeight;
  final double? buttonHeight;
  const LoginFormBTN(
      {super.key,
      this.buttonFontWeight,
      this.buttonHeight,
      this.textLightColor,
      this.textDarkColor,
      this.lightColor,
      this.darkColor,
      this.borderColor,
      this.textColor,
      required this.onSubmitSuccessHandler,
      required this.onGetOtpPressed,
      required this.iAcceptTC,
      this.isAdult,
      this.isWhatApp,
      this.isAdultCheckbox,
      required this.mobileNumberController,
      this.otpController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonText = ref.watch(loginEnableCtaButtonTextProvider);
    final enableCta = ref.watch(loginEnableCtaButtonProvider);
    Timer? debounce;
    return AppButton(
      buttonHeight: buttonHeight ?? 40,
      fontWeight: buttonFontWeight ?? FontWeight.w500,
      textColor: (isAdultCheckbox == true)
          ? (isAdult!.value && iAcceptTC.value && isWhatApp!.value && enableCta)
              ? textDarkColor ?? ColorUtils.white
              : textLightColor ?? ColorUtils.white
          : (iAcceptTC.value && enableCta && isWhatApp!.value)
              ? textDarkColor ?? ColorUtils.white
              : textLightColor ?? ColorUtils.white,
      borderColor: borderColor ?? ColorUtils.kBlueLightColor,
      label: buttonText,
      buttonBgColor: (isAdultCheckbox == true)
          ? (isAdult!.value && iAcceptTC.value && enableCta && isWhatApp!.value)
              ? darkColor ?? ColorUtils.kBlueColor
              : lightColor ?? ColorUtils.kBlueLightColor
          : (iAcceptTC.value && enableCta && isWhatApp!.value)
              ? darkColor ?? ColorUtils.kBlueColor
              : lightColor ?? ColorUtils.kBlueLightColor,
      buttonWidth: Sizes.screenWidth() * 0.9,
      onPressed: () async {
        if (debounce?.isActive ?? false) debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 300), () {
          if (isAdultCheckbox == true) {
            if (isAdult!.value &&
                iAcceptTC.value &&
                isWhatApp!.value &&
                enableCta &&
                buttonText == AppConstants.next) {
              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(false);
            }
            if (isAdult!.value &&
                iAcceptTC.value &&
                enableCta &&
                isWhatApp!.value &&
                buttonText == AppConstants.sendOTP) {
              ///use this provider when you successfully get the otp
              //  ref.read(loginShowSendOtpProvider.notifier).changeActiveState(true);
              ref
                  .read(loginEnableCtaButtonTextProvider.notifier)
                  .changeActiveState(AppConstants.submit);
              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              ref
                  .read(sendOtpErrorNotifierProvider.notifier)
                  .sendOtpErrorMessage("");
              onGetOtpPressed();
              //send otp call
            }

            if (isAdult!.value &&
                iAcceptTC.value &&
                enableCta &&
                isWhatApp!.value &&
                buttonText == AppConstants.submit) {
              //submit otp
              onSubmitSuccessHandler();
            }
          } else {
            if (iAcceptTC.value &&
                enableCta &&
                isWhatApp!.value &&
                buttonText == AppConstants.next) {
              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(false);
            }
            if (iAcceptTC.value &&
                enableCta &&
                isWhatApp!.value &&
                buttonText == AppConstants.sendOTP) {
              ///use this provider when you successfully get the otp
              //  ref.read(loginShowSendOtpProvider.notifier).changeActiveState(true);
              ref
                  .read(loginEnableCtaButtonTextProvider.notifier)
                  .changeActiveState(AppConstants.submit);
              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              ref
                  .read(sendOtpErrorNotifierProvider.notifier)
                  .sendOtpErrorMessage("");
              onGetOtpPressed();
              //send otp call
            }
            if (iAcceptTC.value &&
                enableCta &&
                isWhatApp!.value &&
                buttonText == AppConstants.submit) {
              //submit otp
              onSubmitSuccessHandler();
            }
          }
        });
        // await Future.delayed(const Duration(seconds: 1));
      },
    );
  }
}
