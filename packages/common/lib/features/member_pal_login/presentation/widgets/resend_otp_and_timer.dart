import 'package:common/core/consts/constant_app_strings.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/toast_custom_widget.dart';
import 'package:common/features/member_pal_login/presentation/providers/member_signup_login_provider.dart';
import 'package:flutter/material.dart';

class ResendOtpAndTimerWidget extends StatefulHookConsumerWidget {
  final TextEditingController otpController;
  final Function()? onResendPressed;

  const ResendOtpAndTimerWidget(
      {super.key, required this.otpController, this.onResendPressed});

  @override
  ConsumerState<ResendOtpAndTimerWidget> createState() =>
      _ResendOtpAndTimerWidgetState();
}

class _ResendOtpAndTimerWidgetState
    extends ConsumerState<ResendOtpAndTimerWidget> {
  Key timerKey = UniqueKey();
  var seconds = 31;
  @override
  Widget build(BuildContext context) {
    final showOtpError = ref.watch(showMemberPalOtpErrorProvider);
    final isTimerStart = useState<bool>(true);
    return Row(
      children: [
        if (showOtpError)
          const AppText(
            data: AppConstants.invalidSendOTPText,
            fontSize: 12,
            fontColor: ColorUtils.errorColor,
          ),
        const Spacer(),
        if (seconds != 0)
          TweenAnimationBuilder<Duration>(
            key: timerKey,
            duration: const Duration(seconds: 31),
            tween:
                Tween(begin: const Duration(seconds: 31), end: Duration.zero),
            onEnd: () {
              isTimerStart.value = false;
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              seconds = value.inSeconds;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppText(
                  data: "00:${seconds.toString().padLeft(2, '0')}",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
        SizedBox(
          // height: 28,
          child: InkWell(
            onTap: isTimerStart.value
                ? null
                : () async {
                    timerKey = UniqueKey();
                    seconds = 30;
                    isTimerStart.value = true;
                    widget.otpController.clear();
                    widget.onResendPressed?.call();
                    ref
                        .read(showMemberPalOtpErrorProvider.notifier)
                        .changeState(false);
                    final result =
                        await ref.read(memberPalSendOtpProvider.future);
                    if (result == false) {
                      // failed to send otp try again
                      showToastBox(context,
                          message: AppConstants.failedTosendOtp,
                          toastDuration: const Duration(seconds: 2));
                    }
                  },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 8.0),
              child: AppText(
                data: AppStrings.resendOtp,
                fontSize: 14,
                textAlign: TextAlign.end,
                fontColor: isTimerStart.value
                    ? ColorUtilsV2.hex_BFDBFE
                    : ColorUtilsV2.hex_2563EB,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
