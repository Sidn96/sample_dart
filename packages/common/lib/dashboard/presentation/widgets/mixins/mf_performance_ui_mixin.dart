import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/features/profile/presentation/common_imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/utils/mf_asset_utils.dart';

mixin MfPerformanceAnalysisUiMixin {

  Widget schemeRiskInfoWidget({required String label,required Color infoColor,required Color infoBgColor,required Color iconBorderColor,Widget? trailing,required bool isExpanded}){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: infoBgColor,
              border: Border.all(color: iconBorderColor,width: 1)
          ),
          padding: const EdgeInsets.all(7),
          margin:  const EdgeInsets.only(right: 10),
          child: SvgPicture.asset(
            height: 17,
            width: 17,
            MfAssetUtils.icBulb,
            package: 'mf_pod',
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
              child: AppTextV2(
                data: label,
                fontSize: Sizes.textSize15,
                fontWeight: FontWeight.w500,
                height: 1.37,
                fontColor: infoColor,
                textAlign: TextAlign.start,
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild:const Padding(
                padding: EdgeInsets.only(left: 4.0,top :4.0),
                child: Icon(Icons.info,color: ColorUtilsV2.hex_C2C2C9,size: 10,),
              ),
              crossFadeState: isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),),
          ],),
        ),
        if(trailing != null)
          trailing
      ],
    );
  }

  Widget investmentValueWidget({required String label,required String value,Color? valColor,bool isShowInfoIcon = false}){
    return  Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppTextV2(
              data: label,
              fontSize: Sizes.textSize12,
              fontColor: ColorUtilsV2.hex_AEAEB7,
            ),
            if(isShowInfoIcon)
              const Padding(
              padding: EdgeInsets.only(left: 3),
              child: Icon(Icons.info,color: ColorUtilsV2.hex_C2C2C9,size: 10,),
            )
          ],
        ),
        AppTextV2(
          data:value,
          fontSize: Sizes.textSize14,
          fontWeight: FontWeight.w500,
          fontColor: valColor ?? ColorUtilsV2.specialNeutral700,
          textAlign: TextAlign.start,
        )
      ],
    );
  }

  bool isItExternal(bool? value){
    if(value != null){
      return value;
    }
    return false;
  }

  Color getAmcAnalysisInfoColor(AnalysisQuadrantEnum value) {
    return switch (value) {
      AnalysisQuadrantEnum.ideal => ColorUtilsV2.hex_22C55E,
      AnalysisQuadrantEnum.imperfect => ColorUtilsV2.hex_FCA43F,
      AnalysisQuadrantEnum.undesirable => ColorUtilsV2.hex_3B82F6,
      AnalysisQuadrantEnum.concerning => ColorUtilsV2.hex_F87171,
      _ => ColorUtilsV2.specialNeutral700,
    };
  }

  Color getPerformanceHeaderBgColor(AnalysisQuadrantEnum value) {
    return switch (value) {
      AnalysisQuadrantEnum.ideal => ColorUtilsV2.hex_DCFCE7,
      AnalysisQuadrantEnum.imperfect => ColorUtilsV2.hex_FEF3C7,
      AnalysisQuadrantEnum.undesirable => ColorUtilsV2.hex_E3F2FD,
      AnalysisQuadrantEnum.concerning => ColorUtilsV2.hex_FEE2E2,
      _ => ColorUtilsV2.specialNeutral700,
    };
  }

  Color getBulbInfoBgColor(AnalysisQuadrantEnum value) {
    return switch (value) {
      AnalysisQuadrantEnum.ideal => ColorUtilsV2.hex_BBF7D0,
      AnalysisQuadrantEnum.imperfect => ColorUtilsV2.hex_FFE270,
      AnalysisQuadrantEnum.undesirable => ColorUtilsV2.hex_BFDBFE,
      AnalysisQuadrantEnum.concerning => ColorUtilsV2.hex_FECACA,
      _ => ColorUtilsV2.specialNeutral700,
    };
  }

  Color getBulbInfoBorderColor(AnalysisQuadrantEnum value) {
    return switch (value) {
      AnalysisQuadrantEnum.ideal => ColorUtilsV2.hex_4ADE80,
      AnalysisQuadrantEnum.imperfect => ColorUtilsV2.hex_FFCD4E,
      AnalysisQuadrantEnum.undesirable => ColorUtilsV2.hex_60A5FA,
      AnalysisQuadrantEnum.concerning => ColorUtilsV2.hex_FCA5A5,
      _ => ColorUtilsV2.specialNeutral700,
    };
  }

  String getAnalysisDescription(AnalysisQuadrantEnum value){
    return switch (value) {
      AnalysisQuadrantEnum.ideal => "This fund has been performing well, you might want to increase your allocation in this.",
      AnalysisQuadrantEnum.imperfect => "This fund has underperforming. You may want to switch with a better performing fund within the category.",
      AnalysisQuadrantEnum.undesirable => "The Fund has not been performing well. You may want to switch with a better performing fund within the category.",
      AnalysisQuadrantEnum.concerning => "This fund has not been performing well. You may want to switch with a better performing fund within the category.",
      _ => "",
    };
  }
}