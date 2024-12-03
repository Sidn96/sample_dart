import 'package:common/core/presentation/components_v2/components_v2.dart';
import 'package:common/core/presentation/extensions/int_extension.dart';
import 'package:common/core/presentation/routing/route_strings.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/app_images.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_home_coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReferAndEarnCardWidget extends StatelessWidget {
  const ReferAndEarnCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        MoEngageService().trackEvent(
            eventName: MoEngageEventsConsts
                .eventsNames.truefinreferralhomepagescreenButtonClick,
            product: ProductEvent.truefin);
        context.pushNamed(CommonRouteString.referAndEarnScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 170,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorUtilsV2.hex_282843,
              ColorUtilsV2.hex_282843,
              ColorUtilsV2.hex_282843.withOpacity(0.7),
              Colors.teal.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(5, 5),
              blurRadius: 10,
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -10.0,
              left: 12.0,
              child: Image.asset(
                AppImages.rightcoinstar,
                package: "common",
                width: 20,
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 15.0,
              child: Image.asset(
                AppImages.leftcoinstar,
                package: "common",
                width: 20,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppTextV2(
                          data: AppConstants.referEarntitle,
                          fontSize: 24,
                          fontWeight: FontWeight.w300,
                          textAlign: TextAlign.start,
                          fontColor: Colors.white,
                        ),
                        8.height,
                        const AppTextV2(
                          data: AppConstants.referEarnCardDescription,
                          fontSize: 12,
                          height: 1.4,
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.w300,
                          fontColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 160,
                    padding: const EdgeInsets.all(25.0),
                    child: const ReferAndEarnHomeCouponCard(),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
