import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:flutter/material.dart';

class AppTabSwitcherWidget extends StatelessWidget {
  final VoidCallback? onFirstTabClicked;
  final VoidCallback? onSecondTabClicked;
  final String firstTabLabel;
  final String secondTabLabel;
  final int enabledTabPosition;

  /// Margin around widget
  /// ```dart
  /// const EdgeInsets.symmetric(vertical: 24)
  /// ```
  final EdgeInsets? margin;

  /// Padding for text inside tab button
  final EdgeInsets labelContentPadding;
  final EdgeInsets? labelForSecondTabContentPadding;
  final Color? enableColor;
  final Color? disableColor;
  final Color? enableFontColor;
  final Color? disableFontColor;

  /// Expand widget to full width if [true].
  final bool useFullWidth;

  const AppTabSwitcherWidget({
    Key? key,
    required this.secondTabLabel,
    required this.firstTabLabel,
    this.onFirstTabClicked,
    this.onSecondTabClicked,
    required this.enabledTabPosition,
    this.margin = const EdgeInsets.symmetric(vertical: 24),
    this.labelContentPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.labelForSecondTabContentPadding,
    this.useFullWidth = false,
    this.enableColor,
    this.enableFontColor,
    this.disableFontColor,
    this.disableColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = ColorUtilsV2.specialBackground100;
    if (onFirstTabClicked == null || onSecondTabClicked == null) {
      // TODO change background color as per UI/UX
      // backgroundColor = new disable view color
    }

    return Container(
      margin: margin,
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: const StadiumBorder(
          side: BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisSize: useFullWidth ? MainAxisSize.max : MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            fit: useFullWidth ? FlexFit.tight : FlexFit.loose,
            child: _TabSwitcherButton(
              buttonText: firstTabLabel,
              onPressed: onFirstTabClicked,
              isEnable: enabledTabPosition == 0,
              enableColor: enableColor,
              enableFontColor: enableFontColor,
              disableFontColor: disableFontColor,
              contentPadding: labelContentPadding,
              disableColor: disableColor,
            ),
          ),
          Flexible(
            flex: 1,
            fit: useFullWidth ? FlexFit.tight : FlexFit.loose,
            child: _TabSwitcherButton(
              buttonText: secondTabLabel,
              onPressed: onSecondTabClicked,
              isEnable: enabledTabPosition == 1,
              enableColor: enableColor,
              enableFontColor: enableFontColor,
              disableColor: disableColor,
              disableFontColor: disableFontColor,
              contentPadding:
                  labelForSecondTabContentPadding ?? labelContentPadding,
            ),
          ),
        ],
      ),
    );
  }
}

class _TabSwitcherButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final bool isEnable;
  final EdgeInsets contentPadding;
  final Color? enableColor;
  final Color? disableColor;
  final Color? enableFontColor;
  final Color? disableFontColor;

  const _TabSwitcherButton({
    required this.buttonText,
    required this.onPressed,
    required this.isEnable,
    this.enableColor,
    this.enableFontColor,
    this.disableFontColor,
    this.disableColor,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    var viewColor = Colors.transparent;
    var fontColor = enableFontColor ?? ColorUtilsV2.neutral500;

    ///Changed the 'onPressed == null' condition to '!isEnable', as it
    ///wasn't working for disableFontColor state

    if (/*onPressed == null*/ !isEnable) {
      //If onPressed is null it is considered as disabled -> Corporate Buy Journey NPS
      viewColor = disableColor ?? ColorUtilsV2.specialBackground100;
      fontColor = disableFontColor ??
          ColorUtilsV2
              .hex_717182; //TODO ask for disable view color from UI/UX team
    } else if (isEnable) {
      viewColor = enableColor ?? ColorUtilsV2.specialBackground500;
      fontColor = enableFontColor ?? ColorUtilsV2.genericWhite;
    }
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: contentPadding,
        decoration: ShapeDecoration(
          color: viewColor,
          shape: const StadiumBorder(
            side: BorderSide.none,
          ),
        ),
        child: AppTextV2(
          data: buttonText,
          fontSize: 14,
          fontColor: fontColor,
          fontWeight: isEnable ? FontWeight.w600 : FontWeight.w400,
          letterSpacing: null,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
