import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/sizes.dart';
import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/overall_portfolio_model.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widget/investment_info_widget.dart';

class InvestInfoExpansionWidget extends HookWidget {
  final String primaryTitle;
  final String primaryAmount;
  final bool isSipZero;
  final InvestInfoFields? infoFields;

  const InvestInfoExpansionWidget(
      {super.key,
      required this.primaryTitle,
      required this.primaryAmount,
       this.isSipZero = false,this.infoFields});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);

    return Container(
      padding: const EdgeInsets.only(left: 35,right: 12,top: 12,bottom: 12),
      color: ColorUtilsV2.specialNeutral700,
      child: ExpansionTile(
        enabled: isSipZero != true,
        shape: const Border(),
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

          AppTextV2(
              data: primaryTitle,
              fontSize: Sizes.textSize14,
              fontWeight: FontWeight.w700,
              fontColor: ColorUtilsV2.hex_AEAEB7),

          AppTextV2(
              data: isSipZero ? 'Start Sip' : primaryAmount,
              fontSize: Sizes.textSize16,
              fontWeight: FontWeight.w600,
              fontColor: isSipZero
                  ? ColorUtilsV2.specialBackground300
                  : ColorUtilsV2.hex_AEAEB7),

        ]),
        onExpansionChanged: (value) {
          if (value) {
            isExpanded.value=true;
          }else{
            isExpanded.value=false;
          }
        },
        trailing:ValueListenableBuilder(
          valueListenable: isExpanded,
          builder: (ctx, tIsExpanded, child) {
            return SizedBox(
                height: 20,
                width: 20,
                child: isExpanded.value
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3),
                        child: Icon(Icons.expand_less,color: ColorUtilsV2.hex_C2C2C9,),
                      )
                    : isSipZero
                        ? const Icon(Icons.keyboard_arrow_right,color: ColorUtilsV2.specialBackground300)
                        : const Icon(Icons.expand_more,color: ColorUtilsV2.hex_C2C2C9,));
          },
        ),
        dense: true,
        children: [
          Padding(padding: const EdgeInsets.only(left: 16.0,right: 20),
            child: InvestmentInfo(commonFields: infoFields),
          ),
        ],
      ),
    );
  }
  
}