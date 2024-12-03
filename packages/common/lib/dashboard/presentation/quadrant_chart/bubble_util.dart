import 'dart:ui';
import 'dart:ui' as ui;

import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mf_pod/presentation/features/check_your_kyc/presentation/widgets/mixins/common_mixins.dart';
import 'package:mf_pod/presentation/features/dashboard/data/mf_sync_dashboard_dto.dart';
import 'package:mf_pod/presentation/features/dashboard/presentation/widgets/mixins/mf_performance_ui_mixin.dart';

import 'bubble.dart';

class BubbleUtil with AmcUiMixin, MfPerformanceAnalysisUiMixin {

  static BubbleUtil? _instance;
  BubbleUtil._();

  double graphSize = 0;
  double bubbleMaxRadius = 36;
  double bubbleMinRadius = 14;
  double imageSize = 16;
  double valueRangeMin = 0;
  double valueRangeMax = 10;

  static final Map<String, ui.Image> _uiImages = {};
  static List<QuadrantBubble>? _bubbleList;

  factory BubbleUtil(double graphSize) {
    _instance ??= BubbleUtil._();
    if(graphSize > 0) {
      _instance!.graphSize = graphSize;
    }
    return _instance!;
  }

  List<QuadrantBubble> createBubbles(List<AmcScheme> schemes) {
    if(schemes.isEmpty) return [];
    _bubbleList = schemes.map((e) => createBubble(e)).toList();
    return _bubbleList!;
  }

  List<QuadrantBubble>? getAlreadyCreatedBubbles() {
    return _bubbleList;
  }

  QuadrantBubble createBubble(AmcScheme input) {
    double dx = mapValueToRange(input.performanceScore);
    double dy = mapRiskValueToRange(input.riskScore);
    double size = mapRadiusToRange(input.radius);

    // Adjust the point
    if (dx <= size || dx + size > graphSize) {
      if (dx <= size) {
        dx = dx + size + 4;
      } else {
        dx = dx - size - 4;
      }
    }
    if (dy <= size || dy + size > graphSize) {
      if (dy <= size) {
        dy = dy + size + 4;
      } else {
        dy = dy - size - 4;
      }
    }
    // print("-- dx $dx dy $dy size $size GraphSize $graphSize Scheme ${input.symbol}");
    return QuadrantBubble(
      position: Offset(dx, dy),
      size: size,
      color: getBulbInfoBgColor(input.analysisQuadrantEnum),
      label: input.amcName ?? "-",
      image: _uiImages[input.symbol]!,
    );
  }



  double mapValueToRange(double x) {
    double outMin = 0;    // Output range minimum
    double outMax = graphSize;              // Output range maximum
    return (((x - valueRangeMin) / (valueRangeMax - valueRangeMin)) * (outMax - outMin) + outMin).roundToDouble();
  }

  double mapRiskValueToRange(double x) {
    double outMax = 0;    // Output range minimum
    double outMin = graphSize;              // Output range maximum
    return (((x - valueRangeMin) / (valueRangeMax - valueRangeMin)) * (outMax - outMin) + outMin).roundToDouble();
  }

  double mapRadiusToRange(double radius){
    return (((radius - 1) / (10 - 1)) * (bubbleMaxRadius - bubbleMinRadius) + bubbleMinRadius).roundToDouble();
  }

  Future<void> loadAllUiImages(List<AmcScheme> schemes) async {
    for (var scheme in schemes) {
      if(!_uiImages.containsKey(scheme.symbol)) {
        // final ByteData data = await rootBundle.load("packages/mf_pod/assets/images/company_logos/${scheme.symbol?.replaceAll(" ", "_")}",);
        final ByteData data = await rootBundle.load("packages/mf_pod/${getImageNameBySymbol(scheme.symbol ?? "")}",);
        final ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
        final ui.FrameInfo frameInfo = await codec.getNextFrame();
        _uiImages[scheme.symbol!] = frameInfo.image;
      }
    }
  }

  // Detect if tap is inside a bubble
  QuadrantBubble? getTappedBubble(Offset tapPosition) {
    if(_bubbleList == null || _bubbleList!.isEmpty) return null;
    for (QuadrantBubble bubble in _bubbleList!) {
      // Convert bubble position relative to the canvas center
      // final canvasCenter = Offset(MediaQuery.of(context).size.width / 2, 200);
      // Offset bubbleCenter = canvasCenter + bubble.position;
      Offset bubbleCenter = bubble.position;

      // Check if the tap is inside this bubble (using distance from center)
      if ((bubbleCenter - tapPosition).distance <= bubble.size) {
        return bubble;
      }
    }
    return null;
  }

  OverlayEntry? _overlayEntry;

  // Function to show the tooltip overlay
  void showTooltip(BuildContext context, Offset globalPosition, String text) {
    _overlayEntry?.remove(); // Remove any existing tooltip

    _overlayEntry = _createOverlayEntry(context, globalPosition, text);
    Overlay.of(context).insert(_overlayEntry!);
  }

  // Create an overlay entry for the tooltip
  OverlayEntry _createOverlayEntry(BuildContext context, Offset globalPosition, String text) {
    var width = MediaQuery.sizeOf(context).width;
    var overlayTopOffset = globalPosition.dx;
    if(overlayTopOffset + (text.length * 8) >= width){
      var extra = (overlayTopOffset + (text.length * 8)) - width;
      overlayTopOffset -= extra;
    }
    // print("Global Position ${globalPosition.dx} Overlay $overlayTopOffset Width $width");
    return OverlayEntry(
      builder: (context) => Positioned(
        top: globalPosition.dy + 15,
        left: overlayTopOffset,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(width: 1, color: ColorUtilsV2.hex_717182)
            ),
            child: AppTextV2(data: text, fontSize: 12, fontColor: ColorUtilsV2.hex_717182, fontWeight: FontWeight.w500)
          ),
        ),
      ),
    );
  }

  // Function to hide the tooltip
  void hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

List<AmcScheme> getDummySchemes(){
  return [
    AmcScheme.fromJson({
      "schemeName": "DSP Nifty 50 Index Fund - Dir - Growth ",
      "radius": 5,
      "amcName": "DSP Mutual Fund",
      "symbol": "DSP MF",
      "performanceScore": 7,
      "riskScore": 2,
      "analysisQuadrant": "Ideal",
    }),
    AmcScheme.fromJson({
      "schemeName": "quant Multi Asset Fund (Formerly know as Quant Unconstrained Fund) - Direct Plan",
      "radius": 2,
      "amcName": "Quant MF",
      "symbol": "Quant MF",
      "performanceScore": 2,
      "riskScore": 9,
      "analysisQuadrant": "Concerning",
    }),
    AmcScheme.fromJson({
      "schemeName": "Bandhan Nifty 50 Index Fund-Direct Plan - Growth ",
      "radius": 2,
      "amcName": "Bandhan Mutual Fund",
      "symbol": "Bandhan MF",
      "performanceScore": 1,
      "riskScore": 4,
      "analysisQuadrant": "Undesirable",
    }),
    AmcScheme.fromJson({
      "schemeName": "Parag Parikh Flexi Cap Fund - Direct Plan (formerly Parag Parikh Long Term Value Fund)",
      "radius": 2,
      "amcName": "PPFAS Mutual Fund",
      "symbol": "PPFAS",
      "performanceScore": 4,
      "riskScore": 3,
      "analysisQuadrant": "Undesirable",
    }),
    AmcScheme.fromJson({
      "schemeName": "Kotak Emerging Equity Fund-  Direct Plan - Growth ",
      "radius": 2,
      "amcName": "Kotak Mutual Fund",
      "symbol": "Kotak MF",
      "performanceScore": 10,
      "riskScore": 3,
      "analysisQuadrant": "Ideal",
    }),
    AmcScheme.fromJson({
      "schemeName": "Quantum Gold Savings Fund - Direct Plan Growth",
      "radius": 6,
      "amcName": "Quantum Mutual Fund",
      "symbol": "Quantum MF",
      "performanceScore": 8,
      "riskScore": 7,
      "analysisQuadrant": "Imperfect",
    }),
    AmcScheme.fromJson({
      "schemeName": "Axis Small Cap Fund Direct Growth",
      "radius": 2,
      "amcName": "Axis Mutual Fund",
      "symbol": "Axis MF",
      "performanceScore": 4,
      "riskScore": 8,
      "analysisQuadrant": "Concerning",
    }),
    AmcScheme.fromJson({
      "schemeName": "SBI  Nifty Index Fund - Direct Plan - Growth ",
      "radius": 7,
      "amcName": "SBI Mutual Fund",
      "symbol": "SBI MF",
      "performanceScore": 2,
      "riskScore": 2,
      "analysisQuadrant": "Undesirable",
    }),
    AmcScheme.fromJson({
      "schemeName": "NIPPON INDIA LARGE CAP FUND - DIRECT GROWTH PLAN GROWTH OPTION",
      "radius": 4,
      "amcName": "Nippon India Mutual Fund",
      "symbol": "Nippon MF",
      "performanceScore": 6,
      "riskScore": 4,
      "analysisQuadrant": "Ideal",
    }),
    AmcScheme.fromJson({
      "schemeName": "NIPPON INDIA LOW DURATION FUND - GROWTH PLAN GROWTH OPTION",
      "radius": 6,
      "amcName": "Nippon India Mutual Fund",
      "symbol": "Nippon MF",
      "performanceScore": 3,
      "riskScore": 6,
      "analysisQuadrant": "Concerning",
    }),
    AmcScheme.fromJson({
      "schemeName": "NIPPON INDIA EQUITY HYBRID FUND -  SEGREGATED PORTFOLIO 1 - DIRECT GROWTH PLAN",
      "radius": 3,
      "amcName": "Nippon India Mutual Fund",
      "symbol": "Nippon MF",
      "performanceScore": 7,
      "riskScore": 9,
      "analysisQuadrant": "Imperfect",
    })
  ];
}

}