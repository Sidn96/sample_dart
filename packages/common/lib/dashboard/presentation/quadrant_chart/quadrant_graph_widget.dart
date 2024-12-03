import 'dart:math';

import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/domain/analysis_quadrant_enum.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/quadrant_chart/bubble_util.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/quadrant_chart/quadrant_graph_painter.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/mixins/mf_performance_ui_mixin.dart';

class QuadrantGraphWidget extends StatelessWidget {

  final List<AmcScheme> inputSchemes;

  const QuadrantGraphWidget({super.key, required this.inputSchemes});

  @override
  Widget build(BuildContext context) {

    if(inputSchemes.isEmpty) return const SizedBox.shrink();

    final List<AmcScheme> schemes = inputSchemes
        .where((i) => i.performanceScore > 0 && i.riskScore > 0)
        .toList();

    var screenWidth = min(MediaQuery.sizeOf(context).width,
        MediaQuery.sizeOf(context).height) - 32;
    BubbleUtil bubbleUtil = BubbleUtil(screenWidth);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 28, 16, 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppTextV2(data: "Performance Analysis", fontSize: 20, fontWeight: FontWeight.w600, textAlign: TextAlign.center,fontColor: ColorUtilsV2.hex_35354D,),
          const AppTextV2(data: "Optimizes returns by evaluating risk and performance", fontSize: 12, fontWeight: FontWeight.w500, textAlign: TextAlign.center,fontColor: ColorUtilsV2.hex_717182),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            width: screenWidth,
            height: screenWidth,
            color: ColorUtilsV2.hex_FFFFFF,
            child: FutureBuilder(
                future: bubbleUtil.loadAllUiImages(schemes),
                builder: (_, snapshot){
                  if(snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        Offset tapPosition = details.localPosition;
                        var tappedBubble = bubbleUtil.getTappedBubble(tapPosition);
                        // print("TappedBubble $tappedBubble");
                        if (tappedBubble != null) {
                          bubbleUtil.showTooltip(context, details.globalPosition, tappedBubble.label);
                        } else {
                          bubbleUtil.hideTooltip();
                        }
                      },
                      child: CustomPaint(
                        size: Size(screenWidth, screenWidth),
                        painter: QuadrantGraphPainter(bubbleUtil: bubbleUtil,
                            bubbles: bubbleUtil.createBubbles(schemes)),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
            }),
          ),
          const _QuadrantLegendRow()
        ],
      ),
    );
  }
}

class _QuadrantLegendRow extends StatelessWidget with MfPerformanceAnalysisUiMixin {

  const _QuadrantLegendRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _QuadrantLegendItemRow(itemEnum: AnalysisQuadrantEnum.ideal),
          _QuadrantLegendItemRow(itemEnum: AnalysisQuadrantEnum.imperfect),
          _QuadrantLegendItemRow(itemEnum: AnalysisQuadrantEnum.undesirable),
          _QuadrantLegendItemRow(itemEnum: AnalysisQuadrantEnum.concerning),
        ],
      ),
    );
  }
}

class _QuadrantLegendItemRow extends StatelessWidget with MfPerformanceAnalysisUiMixin {
  final AnalysisQuadrantEnum itemEnum;

  const _QuadrantLegendItemRow({required this.itemEnum});

  @override
  Widget build(BuildContext context) {
    double containerSize = 10;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getBulbInfoBgColor(itemEnum),
            border: Border.all(
              color: getBulbInfoBgColor(itemEnum).withOpacity(0.7),
              width: 1.0,
              // style: BorderStyle.solid
            ),
          ),
          child: const SizedBox.shrink(),
        ),
        const SizedBox(width: 4),
        AppTextV2(data: itemEnum.uiTitle, fontSize: 14, fontWeight: FontWeight.w500, fontColor: ColorUtilsV2.hex_5D5D70),
      ],
    );
  }
}

