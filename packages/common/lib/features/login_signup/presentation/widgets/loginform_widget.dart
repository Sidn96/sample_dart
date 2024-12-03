import 'dart:async';
import 'dart:io';

import 'package:common/core/presentation/components/new_phoneNo_textfield.dart';
import 'package:common/features/login_signup/presentation/providers/notifiers/new_login_notifiers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../profile/presentation/common_imports.dart';
import '../providers/active_form_provider.dart';

class LoginFormWidget extends HookConsumerWidget {
  final TextEditingController mobileNumberController;
  final TextEditingController otpController;
  final Function(String)? onResendSuccessHandler;
  final Color? getOTPMessage;
  final double? countryIndianCodeFontSize;
  final double? countryFlagHeight;
  final EdgeInsetsGeometry? countryIndianCodePadding;
  final StreamController<ErrorAnimationType>? errorController;
  final Function(String)? onCompleted;
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final bool isSignLoginText;
  final bool enableInteractiveSelection;
  const LoginFormWidget(
      {super.key,
      required this.mobileNumberController,
      required this.otpController,
      this.onResendSuccessHandler,
      this.getOTPMessage,
      this.countryFlagHeight,
      this.countryIndianCodePadding,
      this.countryIndianCodeFontSize,
      this.errorController,
      this.onCompleted,
      this.resendDisableColor,
      this.resendEnableColor,
      this.enableInteractiveSelection = false,
      required this.isSignLoginText});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showOtp = ref.watch(loginShowSendOtpProvider);
    final mobileNumChecker = ref.watch(mobileNumberCheckerProvider);
    final buttonText = ref.watch(loginEnableCtaButtonTextProvider);

    final showOptError = useState<bool>(false);

    final invalidOTPMessagae = ref.watch(sendOtpErrorNotifierProvider);
    final enableResend = useState<bool>(false);
    final counterTime = useState<int>(30);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: isSignLoginText,
          child: const Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: AppText(
                data: AppConstants.loginSignText,
                fontSize: 22,
                fontColor: ColorUtils.bluishblack,
                fontWeight: FontWeight.w800),
          ),
        ),
        NewPhoneNoTextField(
          countryIndianCodePadding: countryIndianCodePadding,
          countryIndianCodeFontSize: countryIndianCodeFontSize,
          countryFlagHeight: countryFlagHeight,
          headerValue: AppConstants.mobileNoHeader,
          enableBottomSpacing: false,
          phoneNoController: mobileNumberController,
          enableInteractiveSelection: enableInteractiveSelection,
          contentPadding: const EdgeInsets.only(right: 2, bottom: 8),
          onChanged: (value) {
            if (value.length == 10) {
              final result = ref
                  .read(mobileNumberCheckerProvider.notifier)
                  .mobileRegex(mobileNumberController.text);

              if (result) {
                ref
                    .read(loginEnableCtaButtonProvider.notifier)
                    .changeActiveState(true);
                ref
                    .read(loginEnableCtaButtonTextProvider.notifier)
                    .changeActiveState(AppConstants.sendOTP);
              }
            } else {
              if (otpController.text.isNotEmpty) {
                otpController.clear();
              }

              ref
                  .read(mobileNumberCheckerProvider.notifier)
                  .mobileRegex(mobileNumberController.text);

              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              ref
                  .read(loginEnableCtaButtonTextProvider.notifier)
                  .changeActiveState(AppConstants.next);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AppText(
            data: (buttonText == AppConstants.submit) ? "" : mobileNumChecker,
            fontSize: 12,
            fontColor: mobileNumChecker == AppConstants.getOtpOnNumMessage
                ? getOTPMessage ?? ColorUtils.kYellowColor
                : ColorUtils.errorColor,
          ),
        ),
        if (showOtp && buttonText == AppConstants.submit) ...[
          const SizedBox(height: 26),
          const AppText(
            data: AppConstants.enterOtpMessage,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            fontColor: ColorUtils.greyLight,
          ),
          PinCodeTextField(
            autoDisposeControllers: false,
            appContext: context,
            length: 4,
            cursorColor: Colors.black,
            animationDuration: Duration.zero,
            textStyle:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            cursorHeight: 18,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardType: !kIsWeb && Platform.isIOS
                ? const TextInputType.numberWithOptions(
                    signed: true, decimal: true)
                : TextInputType.number,
            textInputAction: TextInputAction.done,
            pinTheme: PinTheme(
                fieldWidth: Sizes.screenWidth() * 0.18,
                //fieldWidth: MediaQuery.sizeOf(context).width * 0.20,
                // fieldOuterPadding: const EdgeInsets.only(left:12,right: 12),
                inactiveColor: ColorUtils.kGreyLightColor,
                selectedColor: ColorUtils.kGreyLightColor,
                activeBorderWidth: 0.5,
                inactiveBorderWidth: 0.5,
                selectedBorderWidth: 0.5,
                shape: PinCodeFieldShape.underline,
                activeColor: ColorUtils.kGreyLightColor,
                errorBorderColor: ColorUtils.errorColor,
                errorBorderWidth: 1),
            errorAnimationController: errorController,
            controller: otpController,
            onCompleted: onCompleted,
            /*(pin) {
              otpController.text = pin;
              ref
                  .read(loginEnableCtaButtonProvider.notifier)
                  .changeActiveState(true);
              // Request focus on the last digit
            }*/
            // ,
            onChanged: (value) {
              if (value.length < 4) {
                ref
                    .read(loginEnableCtaButtonProvider.notifier)
                    .changeActiveState(false);
                final showOtpErrorMsg =
                    ref.read(sendOtpErrorNotifierProvider.notifier);
                showOtpErrorMsg.sendOtpErrorMessage("");
              }
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 7.5),
                  child: AppText(
                    data: invalidOTPMessagae ?? "",
                    fontSize: 12,
                    fontColor: ColorUtils.errorColor,
                    textAlign: TextAlign.left,
                    height: 1.2,
                  ),
                ),
              ),
              TweenAnimationBuilder<Duration>(
                key: ValueKey(counterTime.value),
                duration: const Duration(seconds: 30),
                tween: Tween(
                    begin: const Duration(seconds: 31), end: Duration.zero),
                onEnd: () {
                  enableResend.value = true;
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.4),
                    child: AppText(
                      data: value.inSeconds == 0
                          ? ""
                          : "${formatedTime(time: value.inSeconds)}",
                      fontSize: 14,
                    ),
                  );
                },
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 28,
                child: TextButton(
                  style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft),
                  onPressed: () async {
                    if (enableResend.value) {
                      counterTime.value = counterTime.value + 1;
                      enableResend.value = false;
                      otpController.clear();
                      final showOtpErrorMsg =
                          ref.read(sendOtpErrorNotifierProvider.notifier);
                      showOtpErrorMsg.sendOtpErrorMessage("");
                      ref
                          .read(loginEnableCtaButtonProvider.notifier)
                          .changeActiveState(false);
                      onResendSuccessHandler!("");
                    }
                  },
                  child: AppText(
                    data: AppConstants.resendOTP,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontColor: enableResend.value
                        ? resendEnableColor ?? ColorUtils.kBlueColor
                        : resendDisableColor ?? ColorUtils.disabledColor,
                    textAlign: TextAlign.right,
                  ),
                ),
              )
            ],
          ),
        ],
      ],
    );
  }

  formatedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }
}
