import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/styles/font_sizes.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';

class CheckYourPortfolioWidget extends StatelessWidget{
  final VoidCallback onTap;
  const CheckYourPortfolioWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onTap.call();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        decoration: BoxDecoration(
            color: ColorUtilsV2.specialNeutral700,
            borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: SizedBox(
                  width: 92,
                  height: 72,
                  child: Image.asset(
                    MfAssetUtils.checkPortfolioImg,
                    package: 'mf_pod',
                    fit: BoxFit.fitHeight,
                  )),
            ),
            const Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      AppTextV2(
                        data: 'Risk Analysis',
                        fontSize: FontSizes.textSize16,
                        fontWeight: FontWeight.w600,
                        fontColor: ColorUtilsV2.specialNeutral200,
                      ),
                      SizedBox(height: 4),
                      AppTextV2(
                        data: 'Check your Portfolio Risk',
                        fontSize: FontSizes.textSize12,
                        fontWeight: FontWeight.w500,
                        fontColor: ColorUtilsV2.hex_AEAEB7,
                      ),
                    ],
                  ),
                  SizedBox(width: 18),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 32,
                    color: ColorUtilsV2.specialSuccess300,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}