import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TruepalProgressWidget extends StatelessWidget {
  final Color color;
  final bool showCircularProgress;
  const TruepalProgressWidget(
      {Key? key,
      this.color = ColorUtils.kSliderActiveColor,
      this.showCircularProgress = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showCircularProgress) {
      return Center(
        child: CircularProgressIndicator(
          color: color,
        ),
      );
    }
    return const Center(
      child: SizedBox(
        height: 200.0,
        child: TrupalAppLoader(),
      ),
    );
  }
}

class TrupalAppLoader extends StatelessWidget {
  final String? bottomText;
  final Color? txtColor;
  const TrupalAppLoader({super.key, this.bottomText, this.txtColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            "assets/lotties/truepal_loader.json",
            repeat: true,
            animate: true,
            package: "common",
          ),
          5.height,
          AppText(
            data: bottomText ?? "Loading...",
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
            fontColor: txtColor ?? ColorUtils.blackBluish,
          )
        ],
      ),
    );
  }
}

class TrupalAppCircularLoader extends StatelessWidget {
  const TrupalAppCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
