import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/styles/app_assets.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/risk_profile_base_layout_notifier.dart';
import 'package:common/features/risk_profile/presentation/screens/risk_login_page.dart';
import 'package:common/features/risk_profile/presentation/components/risk_footer_buttons.dart';
import 'package:common/features/risk_profile/presentation/screens/risk_result_page.dart';
import 'package:common/features/risk_profile/presentation/providers/get_risk_profile_selections_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiskProfilePageBottomSheet extends HookConsumerWidget {
  const RiskProfilePageBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculateRiskProfApiObs =
        ref.watch(riskProfileApiNotifierProvider);
    final currentPage = ref.watch(getRiskProfileRedirectionEnumProvider);

    return Stack(
      children: [
        //main layout
        Positioned(
            top: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  width: Sizes.screenWidth(),
                  child: Container(
                    margin: const EdgeInsets.only(left: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            clearAndCloseSheet(ref, context);
                          },
                          child: const Icon(
                            Icons.chevron_left,
                            size: 30,
                            color: ColorUtils.hex35354D,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        AppTextV2(
                          data: currentPage ==
                                  RiskProfileRedirection.goToResultPage
                              ? AppConstants.hereYourRiskProfile
                              : AppConstants.findMyRiskProfile,
                          fontSize: Sizes.textSize22,
                          fontWeight: FontWeight.w400,
                          fontColor: ColorUtils.bluishblack,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                    height: Sizes.screenHeight * 0.8,
                    width: Sizes.screenWidth(),
                    child: riskProfileRedirection(ref, currentPage))
              ],
            )),

        // bottom layout
        Positioned(
          bottom: 0,
          child: Visibility(
              visible: currentPage != RiskProfileRedirection.goToLoginPage,
              // child: const RiskProfileFooterLayout()),
              child: RiskProfileFooterButtons(
                backActionButton: () {
                  clearAndCloseSheet(ref, context);
                },
              )),
        ),

        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
              visible: calculateRiskProfApiObs.isLoading,
              child: const Center(
                  child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator()))),
        )
      ],
    );
  }

  Widget riskProfileRedirection(
      WidgetRef ref, RiskProfileRedirection redirectTo) {
    final riskProfilePagViewNotifier =
        ref.watch(riskProfilePageViewNotifierProvider.notifier);

    var riskProfRes = ref
            .watch(riskProfileApiNotifierProvider)
            .value
            ?.riskData
            ?.riskProfile ??
        "";

    var riskProfileMessage =
        ref.watch(riskProfileApiNotifierProvider).value?.riskData?.message;
    return redirectTo == RiskProfileRedirection.goToResultPage
        ? riskProfileResultPage(riskProfRes, riskProfileMessage ?? '')
        : redirectTo == RiskProfileRedirection.goToLoginPage
            ? RiskLoginPage(
                onPostApiCalled: () {
                  ref
                      .read(riskProfileApiNotifierProvider.notifier)
                      .callRiskProfileCalculateApi();
                },
              )
            : PageView.builder(
                itemCount: riskProfilePagViewNotifier.pageViewItem.length,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                controller: riskProfilePagViewNotifier.pageController,
                itemBuilder: (context, position) {
                  return riskProfilePagViewNotifier.pageViewItem[position];
                },
                onPageChanged: (index) {
                  ref
                      .read(riskProfilePageViewNotifierProvider.notifier)
                      .setCurrentPageValue(index);
                },
              );
  }

  Widget riskProfileResultPage(String result, String message) {
    return result == AppConstants.riskProfileAggressive
        ? RiskProfileResultPage(
            riskType: result,
            imagePath: AssetUtils.aggressive,
            subtext: message,
          )
        : result == AppConstants.riskProfileModerate
            ? RiskProfileResultPage(
                riskType: result,
                imagePath: AssetUtils.moderate,
                subtext: message,
              )
            : RiskProfileResultPage(
                riskType: result,
                imagePath: AssetUtils.conservative,
                subtext: message,
              );
  }

  clearAndCloseSheet(WidgetRef ref, BuildContext context) {
    ref.read(riskProfilePageViewNotifierProvider.notifier).clearAllAnswers();
    context.pop(ref
            .watch(riskProfileApiNotifierProvider)
            .value
            ?.riskData
            ?.riskProfile ??
        "");
  }
}
