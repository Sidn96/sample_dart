
import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/extensions/number_format_extension.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/presentation/widgets/mixins/gain_loss_mixin.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/overall_portfolio_model.dart';
import 'package:mf_pod/utils/mf_string_constants.dart';

class InvestmentInfo extends StatelessWidget with GainLossUiMixin{
  final InvestInfoFields? commonFields;
  final Color? defaultColor;
  final String? defaultXirr;
  final String? xirrTitle;
  const InvestmentInfo({super.key, this.commonFields, this.defaultColor, this.defaultXirr, this.xirrTitle = MfStringConstants.xirr});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      ///total invested
      _titleValue(MfStringConstants.totalInvested,'${MfStringConstants.symbolRupee}${commonFields?.totInvested?.toCurrencyFormat ?? 0}'),

      ///gain/loss
      _titleValue(MfStringConstants.gainOrLoss,'${MfStringConstants.symbolRupee}${commonFields?.gainLoss?.toCurrencyFormat ?? 0}'),

      ///IRR
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextV2(
            data: xirrTitle ?? MfStringConstants.xirr,
            fontSize: Sizes.textSize12,
            fontColor: ColorUtilsV2.hex_AEAEB7,
          ),
          AppTextV2(
            data: getIRRGainLossString(commonFields?.xirr ?? 0,defaultValue: defaultXirr),
            fontSize: Sizes.textSize18,
            fontWeight: FontWeight.w600,
            fontColor: getIRRColor(commonFields?.xirr,defaultColor: defaultColor),
            textAlign: TextAlign.start,
          )
        ],
      ),
    ]);
  }

  Widget _titleValue(String title,String value){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextV2(
          data: title,
          fontSize: Sizes.textSize12,
          fontColor: ColorUtilsV2.hex_AEAEB7,
        ),
        const SizedBox(height: 4),
        AppTextV2(
          data: value,
          fontSize: Sizes.textSize18,
          fontWeight: FontWeight.w600,
          fontColor: ColorUtilsV2.specialNeutral200,
        )
      ],
    );
  }

}