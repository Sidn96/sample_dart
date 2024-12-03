import 'package:common/features/login_signup/presentation/providers/active_form_provider.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';

class HeaderLeftWidget extends ConsumerWidget {
  const HeaderLeftWidget({super.key, this.title, this.subTitle,this.showStepper = true});

  final String? title;
  final String? subTitle;
  final bool showStepper;

  @override
  Widget build(BuildContext context, ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          data: title ?? AppConstants.getStarted,
          fontSize: 22,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 6),
        // AppText(
        //   data: subTitle ??
        //       AppConstants.subTitle,
        //   textAlign: TextAlign.start,
        //   height: 1.3,
        //   fontSize: 12,
        //   fontWeight: FontWeight.w300,
        // ),
        const SizedBox(height: 10),
        if(showStepper)
          const StepperWidget(),
        
      ],
    );
  }

  
}

class StepperWidget extends ConsumerWidget {
  const StepperWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeForm = ref.watch(activeFormProviderProvider);
    return Row(
      children: [
        countCircle(
            "01", activeForm > 0, activeForm == 0),
        Text("------", style: TextStyle(color: (activeForm == 0) ? ColorUtils.kGreyBorderColor : ColorUtils.kGreenBrightColor)),
        countCircle(
            "02", false, activeForm == 1),
      ],
    );
  }

  Container countCircle(String data, bool isCompleted, bool isActive) {
    var color = isActive ? ColorUtils.yellow : isCompleted ? ColorUtils.kGreenBrightColor : ColorUtils.kGreyBorderColor;
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(width: (isActive || isCompleted) ? 2 : 1, color: color),
        ),
      ),
      child: AppText(
        data: data,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontColor: color,
      ),
    );
  }
}
