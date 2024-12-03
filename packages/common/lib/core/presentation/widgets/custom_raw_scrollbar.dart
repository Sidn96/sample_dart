import 'package:common/core/presentation/styles/color_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomRawScrollbar extends StatelessWidget {
  final ScrollController? controller;
  final bool? thumbVisibility;
  final bool? interactive;
  final double? crossAxisMargin;
  final double? mainAxisMargin;

  final Color? thumbColor;
  final Radius? radius;
  final double? thickness;
  final bool? trackVisibility;
  final ScrollbarOrientation? scrollbarOrientation;
  final OutlinedBorder? shape;
  final double? minThumbLength;
  final Duration? fadeDuration;
  final double? minOverscrollLength;
  final Function(ScrollNotification)? notificationPredicate;
  final Duration pressDuration;
  final Color? trackBorderColor;
  final Color? trackColor;
  final Radius? trackRadius;
  final Widget child;

  const CustomRawScrollbar({Key? key, this.controller, this.thumbVisibility = false,
    this.interactive = true, this.crossAxisMargin, this.mainAxisMargin,
    this.thumbColor = ColorUtils.scienceBlueColor, this.radius = const Radius.circular(20),
    this.thickness = 2, this.trackVisibility,
    this.scrollbarOrientation, this.shape, this.minThumbLength, this.fadeDuration,
    this.minOverscrollLength, this.notificationPredicate, this.pressDuration = Duration.zero,
    this.trackBorderColor, this.trackColor, this.trackRadius,
    required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false, physics: const ClampingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.touch,
          }
      ),
      child: RawScrollbar(
        controller: controller,
        thumbVisibility: thumbVisibility,
        interactive: interactive,
        crossAxisMargin: crossAxisMargin ?? 0,
        thumbColor: thumbColor,
        radius: radius,
        thickness: thickness,
        trackVisibility: trackVisibility,
        scrollbarOrientation: scrollbarOrientation,
        mainAxisMargin: mainAxisMargin ?? 0,
        // shape: shape,
        // minThumbLength: minThumbLength ?? 0,
        // minOverscrollLength: minOverscrollLength,
        // notificationPredicate: (notificationScroll) => notificationPredicate?.call(notificationScroll),
        // pressDuration: pressDuration,
        trackBorderColor: trackBorderColor,
        trackColor: trackColor,
        trackRadius: trackRadius,
        child: child,

      ),
    );
  }
}