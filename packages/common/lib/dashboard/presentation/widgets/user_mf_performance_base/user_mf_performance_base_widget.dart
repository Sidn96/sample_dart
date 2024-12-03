import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/scheme_filter_type_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/provider/sync_mf_api_notifier.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/user_mf_performance_base/mf_amc_card_widget.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/user_mf_performance_base/mf_performance_card_widget.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';



class UserMfPerformanceBaseWidget extends HookConsumerWidget {
   UserMfPerformanceBaseWidget({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    var selectedPerformanceType = useState(SchemeFilterTypeEnum.amc);
    var syncMfHoldingsNotifier = ref.read(syncMfHoldingsApiNotifierProvider.notifier);
    return Container(
      color: ColorUtilsV2.genericWhite,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12,),
            child: Row(
              children: [
                SvgPicture.asset(
                  height: 25,
                  width: 25,
                  MfAssetUtils.icMyFunds,
                  package: 'mf_pod',
                ),
                const SizedBox(width: 15,),
                const AppTextV2(
                  data: MfStringConstants.myFunds,
                  fontSize: Sizes.textSize24,
                  fontColor: ColorUtilsV2.specialNeutral700,
                  fontWeight: FontWeight.w600,
                ),
                const Spacer(),
                PopupMenuButton(
                  elevation: 5,
                  color: ColorUtilsV2.genericWhite,
                  icon: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppTextV2(
                        data: selectedPerformanceType.value.uiValue,
                        fontSize: Sizes.textSize16,
                        fontColor: ColorUtilsV2.specialNeutral700,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 3),
                        child: Image.asset(
                          MfAssetUtils.icDownArrow,
                          package: 'mf_pod',
                          height: 8,
                        ),
                      )
                    ],
                  ),
                  onSelected: (val) {
                    selectedPerformanceType.value = val;
                  },
                  offset: const Offset(0, 45),
                  itemBuilder: (BuildContext context) {
                    return SchemeFilterTypeEnum.values
                        .map((SchemeFilterTypeEnum value) {
                      return PopupMenuItem<SchemeFilterTypeEnum>(
                        value: value,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                              border: SchemeFilterTypeEnum.values.last == value
                                  ? null
                                  : const Border(
                                      bottom: BorderSide(
                                          color: ColorUtilsV2.specialNeutral200))),
                          child: Text(
                            value.uiValue,
                            style: const TextStyle(
                                fontSize: Sizes.textSize15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      );
                    }).toList();
                  },
                ),
              ],
            ),
          ),
          if(selectedPerformanceType.value.isAmc)
          ListView.builder(
              itemCount: syncMfHoldingsNotifier.amcSchemesDetailsList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
               return MfAmcCardWidget(amcMap: syncMfHoldingsNotifier.amcSchemesDetailsList[index],schemeFilterTypeEnum: selectedPerformanceType.value,);
              })
          else
            ListView.builder(
                itemCount: syncMfHoldingsNotifier.performanceSchemesDetailsList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return MfPerformanceCardWidget(performanceMap: syncMfHoldingsNotifier.performanceSchemesDetailsList[index],schemeFilterTypeEnum: selectedPerformanceType.value,);
                })
        ],
      ),
    );
  }

}
