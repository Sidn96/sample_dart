import 'package:flutter/material.dart';

import '../styles/color_utils.dart';
import '../styles/sizes.dart';
import '../utils/app_string_constants.dart';
import '../utils/app_text.dart';

class OtpTimerWidget extends StatelessWidget {
  final ValueNotifier<bool> startTimer;
  final ValueNotifier<int> resendOnboardOtpTime;
  final VoidCallback? resendPressed;
  final ValueNotifier<String?> invalidOtp;
  const OtpTimerWidget({
    required this.startTimer,
    required this.resendOnboardOtpTime,
    required this.invalidOtp,
    this.resendPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (invalidOtp.value != null)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: AppText(
              data: invalidOtp.value!,
              fontSize: 12,
              fontColor: ColorUtils.errorColor2,
              fontWeight: FontWeight.w500,
            ),
          ),
        const Spacer(),
        if (startTimer.value)
          TweenAnimationBuilder<Duration>(
              duration: Duration(seconds: resendOnboardOtpTime.value),
              tween: Tween(
                  begin: Duration(seconds: resendOnboardOtpTime.value),
                  end: Duration.zero),
              onEnd: () {
                startTimer.value = false;
              },
              builder: (BuildContext context, Duration value, Widget? child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: AppText(
                    data: '${formatedTime(time: value.inSeconds)}',
                    textAlign: TextAlign.center,
                    fontSize: Sizes.textFieldR12,
                    fontWeight: FontWeight.w500,
                  ),
                );
              }),
        const SizedBox(width: 5),
        TextButton(
          onPressed: resendPressed,
          child: AppText(
            data: AppConstants.resendOTP,
            fontSize: Sizes.textFieldR12,
            fontColor: startTimer.value
                ? ColorUtils.disabledColor
                : ColorUtils.kBlueColor,
          ),
        ),
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
