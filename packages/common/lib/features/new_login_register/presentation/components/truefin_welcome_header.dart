import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TruefinWelcomeHeaderWidget extends StatelessWidget {
  final String? comingFrom;
  const TruefinWelcomeHeaderWidget({super.key, this.comingFrom});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 150.w,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          const Row(
            children: [
              AppTextV2(
                  data: "Welcome to",
                  fontSize: 26.0,
                  height: 35.52 / 26.0,
                  fontWeight: FontWeight.w400,
                  fontColor: ColorUtilsV2.hex_35354D),
              SizedBox(width: 4.0),
              AppTextV2(
                  data: "TrueFin",
                  fontSize: 26.0,
                  height: 35.52 / 26.0,
                  fontWeight: FontWeight.w700,
                  fontColor: ColorUtilsV2.hex_4E52F8),
            ],
          ),
          const SizedBox(height: 8.0),
          AppTextV2(
            data: comingFrom == CommonRouteString.referAndEarnScreen
                ? "Let's start earning rewards with referrals"
                : "Let's start your retirement planning",
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            fontColor: ColorUtilsV2.hex_717182,
            height: 19.12 / 14.0,
          ),
        ],
      ),
    );
  }
}
