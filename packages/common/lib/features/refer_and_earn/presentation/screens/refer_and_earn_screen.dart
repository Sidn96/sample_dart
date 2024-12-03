import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/features/refer_and_earn/presentation/providers/refer_and_earn_provider.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/benifits_of_nps.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_h_i_work.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_header.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/refer_and_earn_share_cta.dart';
import 'package:common/features/refer_and_earn/presentation/widgets/why_refer_friend.dart';
import 'package:flutter/material.dart';

class ReferAndEarnScreen extends HookWidget {
  const ReferAndEarnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollControl = useScrollController();
    useEffect(
      () {
        MoEngageService().trackEvent(
            eventName: MoEngageEventsConsts
                .eventsNames.truefinreferralhomepagescreenviewed,
            product: ProductEvent.truefin);
        return null;
      },
    );
    return Scaffold(
      backgroundColor: ColorUtilsV2.purpleDark,
      body: SingleChildScrollView(
        controller: scrollControl,
        child: Column(
          children: [
            const ReferAndEarnHeader(),
            const SizedBox(height: 30),
            const ReferAndEarnHowItsWork(),
            const SizedBox(height: 40),
            const WhyReferFriend(),
            const SizedBox(height: 40),
            const BenifitsOfNps(),
            const SizedBox(height: 20),
            Consumer(
              builder: (context, ref, child) {
                final showSocial = ref.watch(showSocialCtaNotifierProvider);
                return Column(
                  children: [
                    if (showSocial) ...[
                      ReferAndShareCta(scrollControl: scrollControl),
                      const SizedBox(height: 60)
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
