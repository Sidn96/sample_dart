import 'package:common/core/presentation/components/otp_text_field.dart';
import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class ResendButtonAndCounter extends HookConsumerWidget {
  const ResendButtonAndCounter({
    super.key,
    required this.otpController,
    required this.otpcc,
    required this.showOptError,
    this.onResendSuccessHandler,
  });
  final TextEditingController otpController;
  final OtpFieldController otpcc;
  final ValueNotifier<bool> showOptError;
  final Function(String)? onResendSuccessHandler;

  @override
  Widget build(BuildContext context, ref) {
    final invalidOTPMessagae =  ref.watch(sendOtpErrorNotifierProvider);
    final enableResend = useState<bool>(false);
    final counterTime = useState<int>(30);
    return Row(
      children: [
        Expanded(
          child: AppText(
            data: invalidOTPMessagae ?? "",
            fontSize: 12,
            fontColor: ColorUtils.errorColor,
            textAlign: TextAlign.left,
          ),
        ),
        TweenAnimationBuilder<Duration>(
          key: ValueKey(counterTime.value),
          duration: const Duration(seconds: 30),
          tween: Tween(begin: const Duration(seconds: 31), end: Duration.zero),
          onEnd: () {
            enableResend.value = true;
          },
          builder: (BuildContext context, Duration value, Widget? child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AppText(
                data: value.inSeconds == 0
                    ? ""
                    : "${formatedTime(time: value.inSeconds)}",
                fontSize: 14,
              ),
            );
          },
        ),
        TextButton(
          onPressed: () {
            if (enableResend.value) {
              final showOtpErrorMsg = ref.read(sendOtpErrorNotifierProvider.notifier);
              showOtpErrorMsg.sendOtpErrorMessage("");
              counterTime.value = counterTime.value + 1;
              enableResend.value = false;
              otpController.clear();
              otpcc.clear();
              ref
                  .read(enableCtaButtonProvider.notifier)
                  .changeActiveState(false);
              onResendSuccessHandler!("");
            }
          },
          child: AppText(
            data: AppConstants.resendOTP,
            fontSize: 14,
            fontColor: enableResend.value
                ? ColorUtils.kBlueColor
                : ColorUtils.disabledColor,
          ),
        )
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
