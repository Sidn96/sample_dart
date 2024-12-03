import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/features/new_login_register/domain/enums.dart';
import 'package:common/features/new_login_register/presentation/notifiers/login_register_page_status_notifier.dart';
import 'package:common/features/new_login_register/presentation/widgets/error_app_text.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class ErrorTimerResendRowWidget extends HookConsumerWidget {
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final Color? otpTimerColor;
  final VoidCallback? resendCallback;
  final Color? otpSentMsgColor;
  final bool showDecorationOnCTAs;
  final Color? changeCTAColor;

  const ErrorTimerResendRowWidget({
    super.key,
    this.resendEnableColor,
    this.resendDisableColor,
    this.resendCallback,
    this.otpTimerColor,
    this.otpSentMsgColor,
    this.showDecorationOnCTAs = false,
    this.changeCTAColor = ColorUtilsV2.hex_4E52F8,
    // this.errorMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enableResend = useState<bool>(false);
    final counterkey = useState<int>(0);
    var state = ref.watch(loginRegisterPageNotifierProvider);
    var notifier = ref.read(loginRegisterPageNotifierProvider.notifier);

    if (state.value < LoginRegisterStatesEnum.otpSent.value) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          notifier.loginRegisterApiError.isNullOrEmpty()
              ? const SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ErrorAppText(
                      errorText: notifier.loginRegisterApiError!,
                      lineHeight: 1.2,
                    ),
                    const SizedBox(height: 15.0),
                  ],
                ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextV2(
                  height: 19.12 / 14.0,
                  fontWeight: FontWeight.w400,
                  data: "OTP will be sent to ",
                  fontColor: otpSentMsgColor,
                  fontSize: 14),
              AppTextV2(
                  fontWeight: FontWeight.w600,
                  height: 19.12 / 14.0,
                  data: notifier.getMobileNumber(),
                  //
                  fontColor: otpSentMsgColor,
                  fontSize: 14.0),
              const SizedBox(width: 4.0),
              InkWell(
                onTap: () {
                  ref
                      .read(loginRegisterPageNotifierProvider.notifier)
                      .updateState(
                          LoginRegisterStatesEnum.otpWillBeSendToMobileNumber);
                  // Future.delayed(const Duration(milliseconds: 300), () {
                  //   if (!fieldFocusNode.hasFocus) {
                  //     fieldFocusNode.requestFocus();
                  //   }
                  // });
                },
                child: AppTextV2(
                  data: "Change",
                  height: 19.12 / 14.0,
                  textDecoration: showDecorationOnCTAs
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  fontSize: 14,
                  fontColor: changeCTAColor,
                  textAlign: TextAlign.right,
                  fontWeight: FontWeight.w600,
                  decorationColor: ColorUtilsV2.genericWhite,
                  decorationThickness: 3.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (enableResend.value == false)
                TweenAnimationBuilder<Duration>(
                  key: ValueKey(counterkey.value),
                  duration: const Duration(seconds: 31),
                  tween: Tween(
                      begin: const Duration(seconds: 30), end: Duration.zero),
                  onEnd: () {
                    enableResend.value = true;
                  },
                  builder:
                      (BuildContext context, Duration value, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12, right: 8),
                      child: AppTextV2(
                        data: otpFormattedTime(time: value.inSeconds),
                        height: 19.12 / 14.0,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontColor: otpTimerColor,
                      ),
                    );
                  },
                ),
              GestureDetector(
                onTap: () {
                  if (enableResend.value) {
                    enableResend.value = false;
                    counterkey.value = counterkey.value + 1;
                    resendCallback?.call();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: AppTextV2(
                    data: AppConstants.resendOTP,
                    height: 19.12 / 14.0,
                    fontSize: 14,
                    textDecoration: enableResend.value
                        ? showDecorationOnCTAs
                            ? TextDecoration.underline
                            : TextDecoration.none
                        : TextDecoration.none,
                    decorationColor: ColorUtilsV2.genericWhite,
                    decorationThickness: 3.0,
                    fontColor: enableResend.value
                        ? resendEnableColor ?? ColorUtilsV2.specialBackground500
                        : resendDisableColor ?? ColorUtilsV2.specialNeutral400,
                    textAlign: TextAlign.right,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String otpFormattedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute:$second";
  }
}
