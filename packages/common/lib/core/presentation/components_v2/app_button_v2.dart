import 'package:common/core/presentation/components_v2/app_text_v2.dart';
import 'package:common/core/presentation/components_v2/app_values.dart';
import 'package:common/core/presentation/components_v2/color_utils_v2.dart';
import 'package:common/core/presentation/components_v2/text_styles.dart';
import 'package:common/core/presentation/widgets/ui_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../styles/color_utils.dart';

//Use this enum to handle Button states
enum ButtonStateEnum { ENABLE, DISABLE, LOADING}

class PrimaryAppButtonV2 extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color enableBtnColor;
  final Color disableBtnColor;
  final Color textColor;
  final Color? disableTextColor;
  final double btnBorderRadius;

  /// Show Circular loader when button is Busy
  final bool isBusy;

  /// Button will [Expand] the available Width of the Screen if [Width] is null
  final double? width;

  /// To enable / disable button click
  /// Default value is [true]
  final bool isEnable;

  /// Instead of default text & style pass a custom widget
  /// it will display in between of button
  final Widget? widget;

  /// Inner padding default is [EdgeInsets.zero]
  final EdgeInsets contentPadding;

  final double height;

  const PrimaryAppButtonV2({
    super.key,
    required this.label,
    required this.onTap,
    this.enableBtnColor = ColorUtilsV2.specialBackground500,
    this.disableBtnColor = ColorUtilsV2.specialBackground300,
    this.textColor = ColorUtilsV2.genericWhite,
    this.disableTextColor = ColorUtilsV2.genericWhite,
    this.btnBorderRadius = AppValues.DEFAULT_RADIUS,
    this.isBusy = false,
    this.width,
    this.isEnable = true,
    this.widget,
    this.contentPadding = EdgeInsets.zero,
    this.height = AppValues.DEFAULT_BUTTON_HEIGHT,
  });

  @override
  Widget build(BuildContext context) {
    Widget? defaultWidget;
    if (widget == null && !isBusy) {
      defaultWidget = AppTextV2(
        data: label,
        fontSize: 14,
        textAlign: TextAlign.center,
        textStyle: TextStyles.manropeStyle(
          14,
          fontWeight: FontWeight.w500,
          color: isEnable ?  textColor : disableTextColor,
        ),
      );
    } else if (isBusy) {
      defaultWidget = SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(color: textColor));
    }

    Decoration? btnDecoration;
    btnDecoration = ShapeDecoration(
        color: isEnable ? enableBtnColor : disableBtnColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnBorderRadius)));

    return GestureDetector(
      onTap: () {
        UiManager.hideKeyboard();
        if (!isBusy && isEnable) {
          onTap.call();
        }
      },
      child: Container(
        height: height,
        padding: contentPadding,
        width: width,
        decoration: btnDecoration,
        child: Center(
          child: (widget ?? defaultWidget),
        ),
      ),
    );
  }
}

class SecondaryAppButtonV2 extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  final Color enableBtnColor;
  final Color disableBtnColor;
  final Color textColor;
  final Color btnBorderColor;
  final double btnBorderRadius;

  /// Show Circular loader when button is Busy
  final bool isBusy;

  /// Button will [Expand] the available Width of the Screen if [Width] is null
  final double? width;

  /// To enable / disable button click
  /// Default value is [true]
  final bool isEnable;

  /// Instead of default text & style pass a custom widget
  /// it will display in between of button
  final Widget? widget;

  /// Inner padding default is [EdgeInsets.zero]
  final EdgeInsets contentPadding;

  final double height;

  const SecondaryAppButtonV2({
    super.key,
    required this.label,
    required this.onTap,
    this.enableBtnColor = ColorUtilsV2.specialBackground500,
    this.disableBtnColor = ColorUtilsV2.specialBackground300,
    this.textColor = ColorUtilsV2.genericWhite,
    this.btnBorderColor = ColorUtilsV2.specialBackground500,
    this.btnBorderRadius = AppValues.DEFAULT_RADIUS,
    this.isBusy = false,
    this.width,
    this.isEnable = true,
    this.widget,
    this.contentPadding = EdgeInsets.zero,
    this.height = AppValues.DEFAULT_BUTTON_HEIGHT,
  });

  @override
  Widget build(BuildContext context) {
    Widget? defaultWidget;
    if (widget == null && !isBusy) {
      defaultWidget = AppTextV2(
        data: label,
        fontSize: 14,
        textAlign: TextAlign.center,
        textStyle: TextStyles.manropeStyle(
          14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      );
    } else if (isBusy) {
      defaultWidget = SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(color: textColor));
    }
    Decoration? btnDecoration = ShapeDecoration(
        color: isEnable ? enableBtnColor : disableBtnColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: btnBorderColor),
          borderRadius: BorderRadius.circular(btnBorderRadius),
        ),
      );

    return GestureDetector(
      onTap: () {
        UiManager.hideKeyboard();
        if (!isBusy && isEnable) {
          onTap.call();
        }
      },
      child: Container(
        padding: contentPadding,
        height: height,
        width: width,
        decoration: btnDecoration,
        child: Center(
          child: (widget ?? defaultWidget),
        ),
      ),
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  final double height;
  final double? width;
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color? textColor;
  final bool enabled;
  final Color? enabledBtnColor;
  final Color enabledBtnBorderColor;
  final Color disabledBtnBorderColor;
  final Color? disableBtnColor;
  final Function? onTap;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppSecondaryButton({Key? key,
    this.height = AppValues.DEFAULT_BUTTON_HEIGHT,
    this.width,
    required this.title,
    this.fontWeight = FontWeight.w500,
    this.fontSize = 14,
    this.borderRadius=const BorderRadius.all(Radius.circular(6)),
    this.textColor = ColorUtilsV2.specialBackground500,
    this.enabled = true,  this.enabledBtnColor = ColorUtils.white,
    this.enabledBtnBorderColor = ColorUtilsV2.specialBackground500,
    this.padding,
    this.disableBtnColor, this.onTap, this.disabledBtnBorderColor = Colors.grey}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: enabled ? () {
        UiManager.hideKeyboard();
        onTap?.call();
      } : null,
      padding: EdgeInsets.zero,
      child: Container(
        height: height,
        width: width,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 19, vertical: 11),
        decoration: ShapeDecoration(
          color: enabledBtnColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: enabled ? enabledBtnBorderColor : disabledBtnBorderColor),
            borderRadius: borderRadius,
          ),
        ),
        child:  Center(
          child: AppTextV2(
            data: title,
            fontSize: fontSize,
            fontWeight: fontWeight,
            height: 0,
            fontColor: enabled ? textColor : Colors.grey,
          ),
        ),
      ),
    );
  }
}


class PrimaryAppButtonV3 extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final Color enableBtnColor;
  final Color disableBtnColor;
  final Color textColor;
  final Color? disableTextColor;
  final double btnBorderRadius;

  /// Show Circular loader when button is Busy
  final bool isBusy;

  /// Button will [Expand] the available Width of the Screen if [Width] is null
  final double? width;

  /// To enable / disable button click
  /// Default value is [true]
  final bool isEnable;

  /// Instead of default text & style pass a custom widget
  /// it will display in between of button
  final Widget? widget;

  /// Inner padding default is [EdgeInsets.zero]
  final EdgeInsets contentPadding;
  final double? height;

  const PrimaryAppButtonV3({
    super.key,
    required this.label,
    required this.onTap,
    this.enableBtnColor = ColorUtilsV2.specialBackground500,
    this.disableBtnColor = ColorUtilsV2.specialBackground300,
    this.textColor = ColorUtilsV2.genericWhite,
    this.disableTextColor = ColorUtilsV2.genericWhite,
    this.btnBorderRadius = AppValues.DEFAULT_RADIUS,
    this.isBusy = false,
    this.width,
    this.isEnable = true,
    this.widget,
    this.contentPadding = EdgeInsets.zero,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    Widget? defaultWidget;
    if (widget == null && !isBusy) {
      defaultWidget = AppTextV2(
        data: label,
        fontSize: 14,
        textAlign: TextAlign.center,
        textStyle: TextStyles.manropeStyle(
          14,
          fontWeight: FontWeight.w500,
          color: isEnable ?  textColor : disableTextColor,
        ),
      );
    } else if (isBusy) {
      defaultWidget = SizedBox(
          height: 28,
          width: 28,
          child: CircularProgressIndicator(color: textColor));
    }

    Decoration? btnDecoration;
    btnDecoration = ShapeDecoration(
        color: isEnable ? enableBtnColor : disableBtnColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnBorderRadius)));

    return GestureDetector(
      onTap: () {
        UiManager.hideKeyboard();
        if (!isBusy && isEnable) {
          onTap.call();
        }
      },
      child: Container(
        height:height?? AppValues.DEFAULT_BUTTON_HEIGHT,
        padding: contentPadding,
        width: width,
        decoration: btnDecoration,
        child: (widget ?? defaultWidget),
      ),
    );
  }
}