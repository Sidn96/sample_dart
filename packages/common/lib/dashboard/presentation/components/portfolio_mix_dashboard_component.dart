import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/utils/extensions/string_extension.dart';
import 'package:common/core/presentation/widgets/app_tool_tip_widget.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:common/features/risk_profile/infrastructure/dtos/calculate_risk_profile_response_dto_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_pod/infrastructure/dtos/get_portfolio_allocation_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/provider/mf_dashboard_provider.dart';
import 'package:mf_pod/presentation/features/new_home_page/widget/truefin_plan_for_retire_component.dart';
import 'package:mf_pod/presentation/features/portfolio_allocation/screens/portfolio_mix_result_mobile_view.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';


class PortfolioMixDashboardComponent extends HookConsumerWidget {
  const PortfolioMixDashboardComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var showPortfolioMix = useState<RiskProfileDataDto?>(null);
    var getPortfolioData = useState<GetPortfolioAllocationDto?>(null);
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((t) async {
        var response =
            await ref.read(getDashboardProvider).getRiskProfile();
        showPortfolioMix.value = response?.riskData;

        if (response?.riskData?.riskProfile != null) {
          var portfolioResult = await ref.read(getDashboardProvider).getPortfolioMix(response?.riskData?.currentAge ?? 18, response?.riskData?.riskProfile?.toLowerCase() ?? '');
          getPortfolioData.value = portfolioResult!;
        }
      });

      return null;
    }, []);

    final riskProfile = showPortfolioMix.value?.riskProfile?.toLowerCase() ?? '';

    final riskProfileMsg = showPortfolioMix.value?.message;

    return showPortfolioMix.value != null
        ? Container(
            color: ColorUtilsV2.genericWhite,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const AppTextV2(
                    data:
                        'Based on your risk profile here is\nyour Investment Strategy',
                    fontSize: Sizes.textSize16,
                    fontWeight: FontWeight.w500,
                    fontColor: ColorUtilsV2.specialNeutral700),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize:MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconWRTRiskProfile(riskProfile),
                    const SizedBox(width: 12),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppTextV2(
                          data: MfStringConstants.yourRiskProfile,
                          fontSize: Sizes.textSize14,
                          fontColor: ColorUtilsV2.specialNeutral600,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            AppTextV2(
                              data: riskProfile.capitalizeFirstLetter(),
                              fontSize: Sizes.textSize22,
                              fontColor: ColorUtilsV2.specialNeutral600,
                            ),
                            const SizedBox(width: 8),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: AppToolTipWidget(
                                toolTipContentWidget: SizedBox(
                                  width: Sizes.screenWidth() * .4,
                                  child: AppTextWithoutAutoSize(
                                      data: riskProfileMsg ?? '',
                                      textAlign: TextAlign.start,
                                      fontSize: Sizes.textSize12),
                                ),
                                preferredDirection: AxisDirection.up,
                                toolTipWidget: const Icon(
                                  Icons.info,
                                  color: ColorUtilsV2.hex_C2C2C9,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                PortfolioDescription(riskProfile: riskProfile.toLowerCase(),modelFromDashboard: getPortfolioData.value,)
              ],
            ),
          )
        : const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: TrueFinPlanForRetireComponent(),
        );
  }
}

Widget iconWRTRiskProfile(String result) {
  var imagePath = AssetUtils.aggressive;

  if (result == 'moderate') {
    imagePath = AssetUtils.moderate;
  } else if (result == 'conservative') {
    imagePath = AssetUtils.conservative;
  }

  return SvgPicture.asset(
    height: 90,
    imagePath,
    package: 'common',
  );
}
