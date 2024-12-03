import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/scheme_filter_type_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/mixins/mf_performance_ui_mixin.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/user_mf_performance_base/scheme_details_row.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';
import 'dart:math';

class MfPerformanceCardWidget extends HookWidget with MfPerformanceAnalysisUiMixin{
  final MapEntry<AnalysisQuadrantEnum, List<AmcScheme>> performanceMap;
  final SchemeFilterTypeEnum schemeFilterTypeEnum;
  const MfPerformanceCardWidget({super.key,required this.performanceMap,required this.schemeFilterTypeEnum});

  @override
  Widget build(BuildContext context) {
    var isExpanded = useState(false);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorUtilsV2.genericWhite, //getPerformanceHeaderBgColor(performanceMap.key))
        border: Border.all(width: 0.4,color: getPerformanceHeaderBgColor(performanceMap.key)),
        boxShadow: [
          BoxShadow(
            color: getPerformanceHeaderBgColor(performanceMap.key).withOpacity(0.5), // Shadow color
            spreadRadius: 1, // The spread radius
            blurRadius: 4, // The blur radius
            offset: const Offset(2, 2), // Changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              isExpanded.value = !isExpanded.value;
            },
            child: Container(
              //height: 50,
              decoration:   BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: getPerformanceHeaderBgColor(performanceMap.key)),
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
              child: Column(
                children: [
                  schemeRiskInfoWidget(
                        label: performanceMap.key.uiValue,
                        infoColor: ColorUtilsV2.specialNeutral700,
                        infoBgColor: getBulbInfoBgColor(performanceMap.key),
                        iconBorderColor: getBulbInfoBorderColor(performanceMap.key),
                        isExpanded: isExpanded.value,
                        trailing:  Container(height: 30,
                          padding: const EdgeInsets.all(11),
                          child: Transform(
                            transform: Matrix4.identity()..rotateZ(isExpanded.value ? pi : 0),
                            alignment: Alignment.center,
                            child: Image.asset(
                              MfAssetUtils.icDownArrow,
                              package: 'mf_pod',
                              height: 9,color: ColorUtilsV2.hex_4E52F8,
                            ),
                          ),
                        ),),
                  AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild:  Padding(
                        padding: const EdgeInsets.only(top: 5,bottom: 5,right: 15),
                        child: AppTextV2(
                          data:getAnalysisDescription(performanceMap.key),
                          fontSize: Sizes.textSize12,
                          fontWeight: FontWeight.w400,
                          fontColor: ColorUtilsV2.specialNeutral600,
                          textAlign: TextAlign.start,
                        ),
                      ),
                     crossFadeState: isExpanded.value
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),),

                ],
              )),
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              //padding: const EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (_, index) {
                return SchemeDetailsRow(
                    amcScheme: performanceMap.value[index],
                    isExpanded: isExpanded.value,
                    schemeFilterTypeEnum: schemeFilterTypeEnum);
              },
              separatorBuilder: (_, index) {
                return  Divider(
                  height: 2,
                  color: !isExpanded.value ? ColorUtilsV2.hex_E5E7EB : ColorUtilsV2.transparent,
                  thickness: 2,
                );
              },
              itemCount: performanceMap.value.length),
        ],
      ),
    );
  }
}
