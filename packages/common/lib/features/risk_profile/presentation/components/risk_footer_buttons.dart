import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/app_string_constants.dart';
import 'package:common/features/risk_profile/domain/enum/risk_profile_enum.dart';
import 'package:common/features/risk_profile/presentation/providers/get_risk_profile_selections_provider.dart';
import 'package:common/features/risk_profile/presentation/providers/risk_profile_base_layout_notifier.dart';
import 'package:common/features/risk_profile/presentation/widgets/dash_page_stepper.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiskProfileFooterButtons extends HookConsumerWidget {
  final String backToPod;
  final VoidCallback backActionButton;

  const RiskProfileFooterButtons({
    super.key,
    this.backToPod = AppConstants.backToNps,
    required this.backActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentPage = ref.watch(riskProfilePageViewNotifierProvider);

    bool enableNextBtnValue = ref.watch(enableNextButtonProvider);

    // bool isAllFieldsSelected = ref.watch(isRiskProfileAnsAllSelectedProvider);

    final currentEnum = ref.watch(getRiskProfileRedirectionEnumProvider);

    return SizedBox(
        height: Sizes.screenHeight * 0.18,
        width: Sizes.screenWidth(),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          ///custom stepper...
          Visibility(
              visible: currentEnum != RiskProfileRedirection.goToResultPage,
              child: Expanded(
                child: Center(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return DashPageIndicator(
                        defaultColor: ColorUtils.stepperDefault,
                        currentPage: currentPage == index,
                        onPreviousPage: currentPage < index ? false : true,
                      );
                    },
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 6,
                      );
                    },
                  ),
                ),
              )),

          ///rest of the ui
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Row(
              children: [
                /// previous button...
                Expanded(
                  child: SecondaryAppButtonV2(
                    label: AppConstants.previous,
                    width: 170,
                    textColor: enableNextBtnValue
                        ? ColorUtilsV2.specialBackground500
                        : ColorUtilsV2.specialBackground50,
                    enableBtnColor: enableNextBtnValue
                        ? ColorUtilsV2.genericWhite
                        : ColorUtilsV2.specialBackground500,
                    onTap: () {
                      if (currentEnum ==
                          RiskProfileRedirection.goToResultPage) {
                        ref
                            .read(redirectRiskProfileResultProvider.notifier)
                            .setResponseValue(-1);
                        ref
                            .read(riskProfilePageViewNotifierProvider.notifier)
                            .setCurrentPageValue(0);
                      } else {
                        if (currentPage > 0) {
                          ref
                              .read(
                                  riskProfilePageViewNotifierProvider.notifier)
                              .pageController
                              .animateToPage(--currentPage,
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.linearToEaseOut);
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),

                currentPage == 4

                    /// back to pod button
                    ? Expanded(
                        child: SecondaryAppButtonV2(
                          // width:
                          //     currentEnum != RiskProfileRedirection.goToResultPage
                          //         ? 170
                          //         : Sizes.screenWidth() * 0.9,
                          textColor: enableNextBtnValue
                              ? ColorUtilsV2.specialBackground50
                              : ColorUtilsV2.specialBackground500,
                          enableBtnColor: enableNextBtnValue
                              ? ColorUtilsV2.specialBackground500
                              : ColorUtilsV2.genericWhite,
                          onTap: () async {
                            if (currentEnum !=
                                RiskProfileRedirection.goToResultPage) {
                              if (ref
                                  .watch(isRiskProfileAnsAllSelectedProvider)) {
                                ref
                                    .read(riskProfileApiNotifierProvider
                                        .notifier)
                                    .callRiskProfileCalculateApi();
                              }
                            } else {
                              backActionButton.call();
                            }
                            if (currentPage > 0) {
                              if (currentEnum ==
                                  RiskProfileRedirection.goToResultPage) {
                                ref
                                    .read(redirectRiskProfileResultProvider
                                        .notifier)
                                    .setResponseValue(-1);
                                ref
                                    .read(riskProfilePageViewNotifierProvider
                                        .notifier)
                                    .setCurrentPageValue(0);
                              } else {
                                // ref
                                //     .read(
                                //     riskProfilePageViewNotifierProvider.notifier)
                                //     .pageController
                                //     .animateToPage(--currentPage,
                                //     duration: const Duration(milliseconds: 400),
                                //     curve: Curves.linearToEaseOut);
                              }
                            }
                          },
                          contentPadding: const EdgeInsets.only(right: 5),
                          label: currentEnum !=
                                  RiskProfileRedirection.goToResultPage
                              ? AppConstants.showMyRiskProfile
                              : backToPod,
                        ),
                      )

                    ///next button...
                    : SecondaryAppButtonV2(
                        label: AppConstants.next,
                        width: 170,
                        textColor: enableNextBtnValue
                            ? ColorUtilsV2.specialBackground50
                            : ColorUtilsV2.specialBackground500,
                        enableBtnColor: enableNextBtnValue
                            ? ColorUtilsV2.specialBackground500
                            : ColorUtilsV2.genericWhite,
                        onTap: () {
                          if (enableNextBtnValue) {
                            ref
                                .read(riskProfilePageViewNotifierProvider
                                    .notifier)
                                .pageController
                                .animateToPage(++currentPage,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.linearToEaseOut);
                          }
                        },
                      ),
              ],
            ),
          ),
        ]));
  }
}
