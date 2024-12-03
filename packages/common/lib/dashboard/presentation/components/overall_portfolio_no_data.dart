import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/overall_portfolio_model.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widget/investment_info_widget.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';

class OverallPortfolioNoData extends StatelessWidget{
  const OverallPortfolioNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorUtilsV2.hex_2A2A3D,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 32,top: 12,bottom: 16),
        child: Column(children: [
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

            const AppTextV2(data: '${MfStringConstants.symbolRupee}0',
                fontSize: Sizes.textSize22,
                fontColor: ColorUtilsV2.hex_E5E7EB,
                fontWeight: FontWeight.w600),

          ]),

          ///total investment info row
           Padding(
            padding: const EdgeInsets.only(left: 42.0,top: 16.0),
             child: InvestmentInfo(
                  commonFields: InvestInfoFields(totInvested: 0, xirr: 0, gainLoss: 0),
                defaultColor: ColorUtilsV2.hex_22C55E,defaultXirr: "0%",xirrTitle: 'IRR',
             ),
            ),
        ],),
      ),
    );
  }

}