import 'package:common/core/presentation/components/dotted_divider.dart';
import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:common/core/presentation/utils/extensions/number_format_extension.dart';
import 'package:go_router/go_router.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/presentation/widgets/mixins/gain_loss_mixin.dart';
import 'package:common/core/domain/number_to_string_format.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/scheme_filter_type_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/mixins/mf_performance_ui_mixin.dart';
import 'package:mf_pod/routing/mf_route_paths.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';

class SchemeDetailsRow extends StatelessWidget with GainLossUiMixin,MfPerformanceAnalysisUiMixin {
  final AmcScheme? amcScheme;
  final bool isExpanded;
  final SchemeFilterTypeEnum schemeFilterTypeEnum;
  const SchemeDetailsRow({super.key,required this.amcScheme ,required this.isExpanded,required this.schemeFilterTypeEnum});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                          color: ColorUtilsV2.specialNeutral100,
                          borderRadius: BorderRadius.circular(15)),
                      child:  AppTextV2(
                        data: "Folio : ${amcScheme?.folio ?? ''}",
                        fontSize: Sizes.textSize14,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtilsV2.specialNeutral500,
                      )),
                  const SizedBox(width: 11),
                  if (amcScheme?.external ?? false)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: AppTextV2(
                      data: 'External',
                      fontSize: Sizes.textSize12,
                      fontWeight: FontWeight.w500,
                      fontColor: ColorUtilsV2.hex_AEAEB7,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
               AppTextV2(
                data : amcScheme?.schemeName ?? '',
                fontSize: Sizes.textSize15,
                fontWeight: FontWeight.w500,
                fontColor: ColorUtilsV2.specialNeutral600,
                textAlign: TextAlign.start,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 17),
                  child: (amcScheme?.tfRating != null)
                      ? Row(
                          children: [
                            const AppTextV2(
                              data: MfStringConstants.trueFinRating,
                              fontSize: Sizes.textSize12,
                              fontColor: ColorUtilsV2.hex_AEAEB7,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            AppTextV2(
                              data: amcScheme?.tfRating.toString() ?? "",
                              fontSize: Sizes.textSize12,
                              fontWeight: FontWeight.w500,
                              fontColor: ColorUtilsV2.specialNeutral700,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: ColorUtilsV2.hex_FCA43F,
                            )
                          ],
                        )
                      : const SizedBox.shrink()),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  investmentValueWidget(label: "Invested",value: NumberToStringFormat.currencyNumberToString(amcScheme?.investedAmount ?? 0),),
                  const Spacer(),
                  investmentValueWidget(label: "Current value",value: NumberToStringFormat.currencyNumberToString(amcScheme?.currentCorpus ?? 0),),
                  const Spacer(),
                  investmentValueWidget(label: "Gain/Loss",value: "${MfStringConstants.symbolRupee}${(amcScheme?.returnAmount ?? 0).toCurrencyFormat}"),
                  const Spacer(),
                  investmentValueWidget(label: "XIRR",value: getIRRGainLossString(amcScheme?.xirr ?? 0),valColor: getIRRColor2(amcScheme?.xirr ?? 0),isShowInfoIcon: true),
                ],
              ),
              AnimatedCrossFade(
                  firstChild: const SizedBox(height: 12),
                  secondChild: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                          investmentValueWidget(label: MfStringConstants.performanceScore, value: _hyphenOrValue(amcScheme?.performanceScore), valColor: getPerformanceScoreColor((amcScheme?.performanceScore ?? 0)),isShowInfoIcon: true),
                          const SizedBox(width: 24),
                          investmentValueWidget(label: MfStringConstants.riskScore,value: _hyphenOrValue(amcScheme?.riskScore),valColor: getRiskScoreColor((amcScheme?.riskScore ?? 0)),isShowInfoIcon: true),
                      ],),
                  ),
                  crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),),
              if(schemeFilterTypeEnum.isAmc || (schemeFilterTypeEnum.isPerformance && isExpanded))
              const DottedDivider(),
              const SizedBox(height: 10),
              if(schemeFilterTypeEnum.isAmc)
              schemeRiskInfoWidget(
                  label: amcScheme?.analysisQuadrantEnum.uiValue ?? "",
                  infoColor: getAmcAnalysisInfoColor(amcScheme!.analysisQuadrantEnum),
                  infoBgColor: getBulbInfoBgColor(amcScheme!.analysisQuadrantEnum),
                  iconBorderColor: getBulbInfoBorderColor(amcScheme!.analysisQuadrantEnum),
                  isExpanded: isExpanded,
              ),
              AnimatedCrossFade(
                secondCurve: Curves.easeInOut,
                firstCurve: Curves.easeInOut,
                firstChild:  SizedBox(height: schemeFilterTypeEnum.isAmc ? 20 : 0,),
                secondChild: Column(
                  children: [
                    if(schemeFilterTypeEnum.isAmc)
                     Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: AppTextV2(
                        data: getAnalysisDescription(amcScheme!.analysisQuadrantEnum),
                        fontSize: Sizes.textSize12,
                        fontWeight: FontWeight.w400,
                        fontColor: ColorUtilsV2.specialNeutral600,
                        textAlign: TextAlign.start,
                      ),
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: AppSecondaryButton(
                              height: 37,
                              fontSize: Sizes.textSize14,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              title: MfStringConstants.sell2,
                              enabled: false,
                              onTap: () {}),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppSecondaryButton(
                              height: 37,
                              fontSize: Sizes.textSize14,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              title: MfStringConstants.investMore,
                              enabled: !isItExternal(amcScheme?.external),
                              onTap: () {
                                if(!isItExternal(amcScheme?.external)){
                                  context.pushNamed(
                                    MutualFundRoutePaths.schemeDetails,
                                    queryParameters: {"id": amcScheme?.isin ?? ""},
                                  );
                                }
                              }),
                        ),
                      ],
                    ),
                     const SizedBox(height: 10),
                  ],
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          secondCurve: Curves.easeInOut,
          firstChild: const SizedBox.shrink(),
          secondChild: InkWell(
            onTap: (){
              ///enabled the navigation to scheme details for internal/external funds
              // if(!isItExternal(amcScheme?.external)){
                context.pushNamed(
                  MutualFundRoutePaths.schemeDetails,
                  queryParameters: {"id": amcScheme?.isin ?? ""},
                );
              // }
            },
            child: Container(
              alignment: Alignment.center,
              height: 45,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  border: Border(
                      top:
                          BorderSide(color: ColorUtilsV2.hex_E5E7EB, width: 1.5)),
                  color: ColorUtilsV2.specialNeutral100),
              child: const AppTextV2(
                data: MfStringConstants.viewDetail,
                fontSize: Sizes.textSize15,
                fontWeight: FontWeight.w500,
                fontColor: ColorUtilsV2.hex_4E52F8,
              ),
            ),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
      ],
    );
  }

String _hyphenOrValue(double? val) {
    return ((val ?? 0) > 0) ? val.toString() : "-";
  }
}
