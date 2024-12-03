import 'package:common/core/presentation/components/dotted_line.dart';
import 'package:common/core/presentation/components_v2/app_button_v2.dart';
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/date_utils/date_utils.dart';
import 'package:common/core/presentation/utils/extensions/date_time_extension.dart';
import 'package:common/core/presentation/utils/extensions/number_format_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/overall_portfolio_model.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widget/investment_info_expansion_widget.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widget/investment_info_widget.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';

class OverallPortfolioWidget extends StatelessWidget{
  final Function onStartInvestingTap;
  final Function onRefreshTap;
  final OverallPortfolioModel? model;
  const OverallPortfolioWidget({super.key, required this.onStartInvestingTap, required this.onRefreshTap,this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtilsV2.hex_2A2A3D,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          ///date & re-sync row
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 20.0),
            child: Row(mainAxisSize: MainAxisSize.min,children: [


              AppTextV2(data: 'as of ${model?.rootPortfolioModel?.asOfDate?.formatTo(
                  dateFormat: AppDateUtils.NAV_DATE_FORMAT)}',
                  fontSize: Sizes.textSize12,
                  fontColor: ColorUtilsV2.specialNeutral500),

              const SizedBox(width: 8),

              InkWell(
                onTap: (){
                  onRefreshTap.call();
                },
                child: Row(
                  children: [
                    const AppTextV2(data: 'Re-sync',
                        fontSize: Sizes.textSize14,
                        fontColor: ColorUtilsV2.hex_9B9DFD,
                        fontWeight: FontWeight.w500),


                    const SizedBox(width: 4),

                    SvgPicture.asset(MfAssetUtils.icSyncBlue, package: 'mf_pod', height: 18)
                  ],
                ),
              ),
            ]),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0,right: 32,top: 12),
            child: Column(children: [

              ///overall portfolio header
              Row(children: [
                SizedBox(width: 30,
                    child: SvgPicture.asset(MfAssetUtils.icRupeeGold, package: 'mf_pod')),

                const SizedBox(width: 12),

                const Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                    AppTextV2(data: MfStringConstants.overallPortfolio,
                        fontSize: Sizes.textSize16,
                        fontColor: ColorUtilsV2.hex_E5E7EB,
                        fontWeight: FontWeight.w700),
                    SizedBox(height: 4),
                    AppTextV2(data: MfStringConstants.totalMfPortfolio,
                        fontSize: Sizes.textSize12,
                        fontColor: ColorUtilsV2.hex_717182,
                        fontWeight: FontWeight.w500),
                  ],),
                ),

                AppTextV2(data: '${MfStringConstants.symbolRupee}${model?.rootPortfolioModel?.investInfoFiellds?.currentValue?.toCurrencyFormat ?? 0}',
                    fontSize: Sizes.textSize22,
                    fontColor: ColorUtilsV2.hex_E5E7EB,
                    fontWeight: FontWeight.w600),

              ]),

              ///total investment info row
               Padding(
                padding: const EdgeInsets.only(left: 42.0,top: 16.0),
                child: InvestmentInfo(commonFields: model?.rootPortfolioModel?.investInfoFiellds),
              ),
            ],),
          ),

          const SizedBox(height: 24),

          ///trueFin portfolio expansion
           GestureDetector(
             onTap: (){

               if(model?.internalPortfolioModel?.commonFields?.totInvested == 0){
                 onStartInvestingTap.call();
               }
             },
             child:  InvestInfoExpansionWidget(
               primaryTitle: 'TrueFin Portfolio',
               primaryAmount: '${MfStringConstants.symbolRupee}${model?.internalPortfolioModel?.commonFields?.currentValue?.toCurrencyFormat ?? 0}',
               isSipZero: model?.internalPortfolioModel?.commonFields?.totInvested == 0,
               infoFields:model?.internalPortfolioModel?.commonFields ,
             ),
           ),
          DottedLine(
              lineLength: Sizes.screenWidth(),
              dashGapLength: 2.0,
              dashColor: ColorUtilsV2.specialNeutral600,
              dashLength: 4.0,
          ),

          ///external portfolio expansion
          InvestInfoExpansionWidget(
            primaryTitle: 'External Portfolio',
            primaryAmount: '${MfStringConstants.symbolRupee}${model?.externalPortfolioModel?.informationFields?.currentValue?.toCurrencyFormat ?? 0}',
            infoFields: model?.externalPortfolioModel?.informationFields,
          ),

          ///invest more
          Padding(
            padding: const EdgeInsets.only(top: 16.0,right: 16.0,left: 16.0),
            child: PrimaryAppButtonV2(
                label: MfStringConstants.investMore, onTap: () {
              onStartInvestingTap.call();
            }),
          )
        ],
      ),
    );
  }

}