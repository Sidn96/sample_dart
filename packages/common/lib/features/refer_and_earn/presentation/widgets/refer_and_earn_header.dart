import 'dart:ui' as ui;

import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_coupon_card.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_share_cta.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReferAndEarnHeader extends ConsumerWidget {
  const ReferAndEarnHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSocial = ref.watch(showSocialCtaNotifierProvider);
    return SizedBox(
      height: (showSocial) ? 620 : 570,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: SizedBox(
              child: Image.asset(
                AppImages.referbg,
                package: "common",
                fit: BoxFit.fill,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 26,
            child: Image.asset(
              AppImages.rightcoinstar,
              package: "common",
              width: 27,
            ),
          ),
          Positioned(
            top: 60,
            right: 26,
            child: Image.asset(
              AppImages.leftcoinstar,
              package: "common",
              width: 27,
            ),
          ),
          Positioned(
            top: 65,
            // bottom: showSocial ? -50 : -120,
            right: 0,
            left: 0,
            child: Image.asset(
              AppImages.referearnspark,
              package: "common",
              width: 30,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 25,
              color: ColorUtilsV2.purpleDark.withOpacity(0.3),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppTextV2(
                  data: AppConstants.referEarntitle,
                  fontSize: 42,
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.white,
                ),
                24.height,
                const AppTextV2(
                  data: AppConstants.referEarnDescription,
                  fontSize: 16,
                  height: 1.4,
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.white,
                ),
                40.height,
                const ReferAndEarnCouponCard(),
                10.height,
                const AppTextV2(
                  data: AppConstants.foreveryFrndinvestnps,
                  fontSize: 19,
                  height: 1.4,
                  fontWeight: FontWeight.w300,
                  fontColor: Colors.white,
                ),
                40.height,
                const ReferAndShareCta(),
              ],
            ),
          ),
          Positioned(
            top: 50,
            child: IconButton(
                onPressed: () => context.pop(),
                icon:
                    const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
