import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';

class CountdownTimerAnimation extends StatelessWidget {
  final Duration duration;
  final Function()? onTimerEnd;
  final String? prefixText;
  final String? suffixText;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final double? fontSize;
  const CountdownTimerAnimation({
    super.key,
    required this.duration,
    this.onTimerEnd,
    this.prefixText = "",
    this.suffixText = "",
    this.fontWeight,
    this.fontColor,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<Duration>(
        duration: duration,
        tween: Tween(begin: duration, end: Duration.zero),
        onEnd: onTimerEnd,
        builder: (BuildContext context, Duration value, Widget? child) {
          return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: AppText(
                  data:
                      '$prefixText ${prettyDuration(value)} $suffixText'.trim(),
                  fontSize: fontSize ?? 12,
                  fontColor: fontColor,
                  fontWeight: fontWeight ?? FontWeight.w600));
        });
  }

  String prettyDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
