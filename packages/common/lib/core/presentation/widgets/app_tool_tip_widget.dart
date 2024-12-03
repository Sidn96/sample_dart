import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

import '../components_v2/text_styles.dart';

class AppToolTipWidget extends StatelessWidget {
  final String toolTipContent;
  /// Either tooltipContent : text is needed or
  /// toolTipContentWidget : Widget
  final Widget? toolTipContentWidget;
  final double? contentFontSize;
  final Color? contentTextColor;
  final double? contentTextHeight;
  final FontWeight? fontWeight;
  final TooltipTriggerMode? tooltipTriggerMode;
  final double contentPadding;
  final Widget toolTipWidget;
  final AxisDirection preferredDirection;
  final EdgeInsetsGeometry margin;
  final Duration showDuration;
  final Color backgroundColor;
  final double borderRadius;
  final double elevation;
  final bool isDismissable;
  final TextAlign? contentTextAlignment;
  final JustTheController? controller;

  const AppToolTipWidget(
      {super.key,
      this.toolTipContent = '',
      this.toolTipContentWidget,
      this.contentFontSize = 10,
      this.contentTextColor = ColorUtilsV2.specialNeutral500,
      this.contentTextHeight = 1.4,
      this.fontWeight = FontWeight.w400,
      this.tooltipTriggerMode = TooltipTriggerMode.tap,
      this.contentPadding = 8.0,
      required this.toolTipWidget,
      this.preferredDirection = AxisDirection.up,
      this.margin = const EdgeInsets.all(8.0),
      this.showDuration = const Duration(seconds: 5),
      this.borderRadius = 5,
      this.backgroundColor = Colors.white,
      this.elevation = 1,
      this.contentTextAlignment,
      this.controller,
      this.isDismissable = true,
      });

  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      key: UniqueKey(),
      barrierDismissible: isDismissable,
        controller: controller,
        preferredDirection: preferredDirection,
        triggerMode: tooltipTriggerMode,
        margin: margin,
        showDuration: showDuration,
        backgroundColor: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        elevation: elevation,
        content:  Padding(
            padding: EdgeInsets.all(contentPadding),
            child: toolTipContentWidget ?? Text(
              toolTipContent,
              style: TextStyle(
                fontSize: contentFontSize,
                color: contentTextColor,
                fontWeight: fontWeight,
                fontFamily: TextStyles.instance.getFontFamily(),
                height: contentTextHeight,
              ),
              textAlign: contentTextAlignment,
            )),
        child: toolTipWidget);
  }
}
