import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/app_text.dart';
import 'package:common/features/coupon_ui_kit/src/widgets/coupon_card.dart';
import 'package:flutter/material.dart';

class ReferAndEarnHomeCouponCard extends StatelessWidget {
  const ReferAndEarnHomeCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = ColorUtilsV2.blackDarkBlue;
    const rotateDegree = 19;
    const rotateChildDegree = 1;
    return RotatedBox(
      quarterTurns: rotateDegree,
      child: CouponCard(
        backgroundColor: primaryColor,
        curveAxis: Axis.vertical,
        curvePosition: 45,
        firstChild: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                ColorUtilsV2.gold,
                ColorUtilsV2.goldLight,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                left: 0.0,
                child: RotatedBox(
                  quarterTurns: 30,
                  child: Image.asset(
                    AppImages.couponsnakes,
                    package: "common",
                    width: 50,
                  ),
                ),
              ),
              Positioned(
                top: 0.0,
                left: -22,
                bottom: 0.0,
                child: RotatedBox(
                  quarterTurns: rotateChildDegree,
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppTextV2(
                          data: "worth",
                          fontSize: 9,
                          fontWeight: FontWeight.w500,
                        ),
                        2.height,
                        const AppTextV2(
                          data: "\u{20B9}${500}",
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        2.height,
                        const AppTextV2(
                          data: "For every referral*",
                          fontSize: 9,
                          fontWeight: FontWeight.w900,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        secondChild: SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    10,
                    (index) => circlegold(),
                  ),
                ),
              ),
              Expanded(
                child: RotatedBox(
                  quarterTurns: rotateChildDegree,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        data: "Get a voucher",
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        fontColor: Colors.white,
                      ),
                      8.height,
                      Image.asset(
                        AppImages.amazonlogo,
                        package: "common",
                        width: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget circlegold() {
    return Container(
      width: 4,
      height: 4,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorUtilsV2.gold,
      ),
    );
  }
}
