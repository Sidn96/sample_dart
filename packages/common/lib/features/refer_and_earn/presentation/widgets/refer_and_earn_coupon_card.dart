import 'dart:math' as math;

import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/features/coupon_ui_kit/src/widgets/coupon_card.dart';
import 'package:flutter/material.dart';

class ReferAndEarnCouponCard extends StatelessWidget {
  const ReferAndEarnCouponCard({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = ColorUtilsV2.blackDarkBlue;
    const transformValue = math.pi / 0.2; // 45 degrees in radians;
    return SizedBox(
      width: 260,
      child: Transform.rotate(
        angle: transformValue,
        child: CouponCard(
          height: 85,
          backgroundColor: primaryColor,
          curveAxis: Axis.vertical,
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
                  child: Transform.rotate(
                    angle: transformValue,
                    child: Image.asset(
                      AppImages.couponsnakes,
                      package: "common",
                      width: 80,
                    ),
                  ),
                ),
                Positioned(
                  right: 0.0,
                  left: 0.0,
                  child: Transform.rotate(
                    angle: transformValue,
                    child: SizedBox(
                      height: 85,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AppTextV2(
                            data: "worth",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          5.height,
                          const AppTextV2(
                            data: "\u{20B9}${500}",
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
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
                  child: Transform.rotate(
                    angle: transformValue,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppTextV2(
                          data: "Get a voucher",
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontColor: Colors.white,
                        ),
                        8.height,
                        Image.asset(
                          AppImages.amazonlogo,
                          package: "common",
                          width: 80,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
