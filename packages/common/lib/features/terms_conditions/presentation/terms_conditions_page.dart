import 'package:common/core/presentation/components_v2/app_bar_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/services/moengage_service_truefin.dart';
import 'package:common/core/presentation/utils/login_enums.dart';
import 'package:common/core/presentation/utils/mo_engage_events_const.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:common/core/presentation/widgets/common_truefin_loader.dart';
import 'package:common/features/terms_conditions/presentation/terms_conditions_app_view.dart'
    if (dart.library.html) 'package:common/features/terms_conditions/presentation/terms_conditions_mweb_view.dart';
import 'package:common/features/terms_conditions/provider/tnc_state_notifier.dart';
import 'package:flutter/material.dart';

class TermsConditionsPage extends HookConsumerWidget {
  const TermsConditionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      MoEngageService().trackEvent(
          eventName: MoEngageEventsConsts.eventsNames.truefininfoscreenviewed,
          product: ProductEvent.truefin,
          properties: {"screen_viewed": "terms and conditions"});
      return null;
    }, []);
    AsyncValue state = ref.watch(tncStateNotifierProvider);
    return Scaffold(
      appBar: const AppBarV2(
        toolbarHeight: kToolbarHeight,
        actionWidgets: [SizedBox()],
        backgroundColor: ColorUtilsV2.hex_F5F5FF,
        title: "Terms & Conditions",
        centerTitle: true,
        onLeadingTap: null,
      ),
      body: state.when(
        data: (data) {
          return TermsAndConditionView(htmlContent: data);
        },
        error: (error, stackTrace) {
          return Center(
            child: AppTextV2(
                data: error.toString(),
                fontSize: 12.0,
                fontColor: Colors.black),
          );
        },
        loading: () {
          return const CommonTrueFinLoader();
        },
      ),
    );
  }
}
