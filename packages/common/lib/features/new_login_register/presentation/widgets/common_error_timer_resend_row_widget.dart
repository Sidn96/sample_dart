import 'package:common/features/new_login_register/presentation/widgets/error_app_text.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';

class CommonErrorTimerResendRowWidget extends HookConsumerWidget {
  final Color? resendEnableColor;
  final Color? resendDisableColor;
  final VoidCallback? resendCallback;
  final String? errorMessage;
  final bool showWidget;

  const CommonErrorTimerResendRowWidget({
    super.key,
    this.resendEnableColor,
    this.resendDisableColor,
    this.resendCallback,
    this.errorMessage,
    this.showWidget = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final enableResend = useState<bool>(false);
    final counterkey = useState<int>(0);

    if (!showWidget) {
      return const SizedBox.shrink();
    }
    
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: errorMessage.isNullOrEmpty()
                ? const SizedBox.shrink()
                : ErrorAppText(
                    errorText: errorMessage,
                    lineHeight: 1.2,
                  ),
          ),
          TweenAnimationBuilder<Duration>(
            key: ValueKey(counterkey.value),
            duration: const Duration(seconds: 31),
            tween: Tween(begin: const Duration(seconds: 30), end: Duration.zero),
            onEnd: () {
              enableResend.value = true;
            },
            builder: (BuildContext context, Duration value, Widget? child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AppText(
                  data: value.inSeconds == 0
                      ? ""
                      : otpFormattedTime(time: value.inSeconds),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 18),
            child: GestureDetector(
              onTap: () {
                if (enableResend.value) {
                  enableResend.value = false;
                  counterkey.value = counterkey.value + 1;
                  resendCallback?.call();
                }
              },
              child: AppText(
                data: AppConstants.resendOTP,
                fontSize: 12,
                fontColor: enableResend.value
                    ? resendEnableColor ?? ColorUtils.kBlueColor
                    : resendDisableColor ?? ColorUtils.disabledColor,
                textAlign: TextAlign.right,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String otpFormattedTime({required int time}) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min":"$min";
    String second = sec.toString().length <= 1 ? "0$sec":"$sec";
    return "$minute:$second";
  }
}
